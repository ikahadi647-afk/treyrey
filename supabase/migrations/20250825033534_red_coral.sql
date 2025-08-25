/*
  # Create Additional Tables (Assets, Contracts, Feedback, etc.)

  1. New Tables
    - `assets`
    - `contracts`
    - `client_feedback`
    - `notifications`
    - `social_media_posts`
    - `promo_codes`
    - `sops`
    - `team_project_payments`
    - `team_payment_records`
    - `reward_ledger_entries`

  2. Security
    - Enable RLS on all tables
    - Add appropriate policies for each table
*/

-- Assets Table
CREATE TABLE IF NOT EXISTS assets (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  name text NOT NULL,
  category text NOT NULL,
  purchase_date date NOT NULL DEFAULT CURRENT_DATE,
  purchase_price numeric NOT NULL DEFAULT 0,
  serial_number text,
  status text NOT NULL DEFAULT 'Tersedia' CHECK (status IN ('Tersedia', 'Digunakan', 'Perbaikan')),
  notes text,
  vendor_id text NOT NULL,
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);

-- Contracts Table
CREATE TABLE IF NOT EXISTS contracts (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  contract_number text NOT NULL,
  client_id uuid REFERENCES clients(id) ON DELETE CASCADE,
  project_id uuid REFERENCES projects(id) ON DELETE CASCADE,
  signing_date date NOT NULL DEFAULT CURRENT_DATE,
  signing_location text NOT NULL,
  client_name1 text NOT NULL,
  client_address1 text NOT NULL,
  client_phone1 text NOT NULL,
  client_name2 text,
  client_address2 text,
  client_phone2 text,
  shooting_duration text NOT NULL,
  guaranteed_photos text NOT NULL,
  album_details text NOT NULL,
  digital_files_format text DEFAULT 'JPG High-Resolution',
  other_items text NOT NULL,
  personnel_count text NOT NULL,
  delivery_timeframe text DEFAULT '30 hari kerja',
  dp_date date,
  final_payment_date date,
  cancellation_policy text NOT NULL,
  jurisdiction text NOT NULL,
  vendor_signature text,
  client_signature text,
  vendor_id text NOT NULL,
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);

-- Client Feedback Table
CREATE TABLE IF NOT EXISTS client_feedback (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  client_name text NOT NULL,
  satisfaction text NOT NULL CHECK (satisfaction IN ('Sangat Puas', 'Puas', 'Biasa Saja', 'Tidak Puas')),
  rating integer NOT NULL CHECK (rating >= 1 AND rating <= 5),
  feedback text NOT NULL,
  date date NOT NULL DEFAULT CURRENT_DATE,
  vendor_id text NOT NULL,
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);

-- Notifications Table
CREATE TABLE IF NOT EXISTS notifications (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  title text NOT NULL,
  message text NOT NULL,
  timestamp timestamptz DEFAULT now(),
  is_read boolean DEFAULT false,
  icon text NOT NULL CHECK (icon IN ('lead', 'deadline', 'revision', 'feedback', 'payment', 'completed', 'comment')),
  link_view text,
  link_action jsonb,
  vendor_id text NOT NULL,
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);

-- Social Media Posts Table
CREATE TABLE IF NOT EXISTS social_media_posts (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  project_id uuid REFERENCES projects(id) ON DELETE CASCADE,
  client_name text NOT NULL,
  post_type text NOT NULL CHECK (post_type IN ('Instagram Feed', 'Instagram Story', 'Instagram Reels', 'TikTok Video', 'Artikel Blog')),
  platform text NOT NULL CHECK (platform IN ('Instagram', 'TikTok', 'Website')),
  scheduled_date date NOT NULL DEFAULT CURRENT_DATE,
  caption text NOT NULL,
  media_url text,
  status text NOT NULL DEFAULT 'Draf' CHECK (status IN ('Draf', 'Terjadwal', 'Diposting', 'Dibatalkan')),
  notes text,
  vendor_id text NOT NULL,
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);

-- Promo Codes Table
CREATE TABLE IF NOT EXISTS promo_codes (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  code text NOT NULL,
  discount_type text NOT NULL CHECK (discount_type IN ('percentage', 'fixed')),
  discount_value numeric NOT NULL DEFAULT 0,
  is_active boolean DEFAULT true,
  usage_count integer DEFAULT 0,
  max_usage integer,
  expiry_date date,
  vendor_id text NOT NULL,
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);

-- SOPs Table
CREATE TABLE IF NOT EXISTS sops (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  title text NOT NULL,
  category text NOT NULL,
  content text NOT NULL,
  last_updated timestamptz DEFAULT now(),
  vendor_id text NOT NULL,
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);

-- Team Project Payments Table
CREATE TABLE IF NOT EXISTS team_project_payments (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  project_id uuid REFERENCES projects(id) ON DELETE CASCADE,
  team_member_name text NOT NULL,
  team_member_id uuid REFERENCES team_members(id) ON DELETE CASCADE,
  date date NOT NULL DEFAULT CURRENT_DATE,
  status text NOT NULL DEFAULT 'Unpaid' CHECK (status IN ('Paid', 'Unpaid')),
  fee numeric NOT NULL DEFAULT 0,
  reward numeric DEFAULT 0,
  vendor_id text NOT NULL,
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);

-- Team Payment Records Table
CREATE TABLE IF NOT EXISTS team_payment_records (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  record_number text NOT NULL,
  team_member_id uuid REFERENCES team_members(id) ON DELETE CASCADE,
  date date NOT NULL DEFAULT CURRENT_DATE,
  project_payment_ids jsonb DEFAULT '[]'::jsonb,
  total_amount numeric NOT NULL DEFAULT 0,
  vendor_signature text,
  vendor_id text NOT NULL,
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);

-- Reward Ledger Entries Table
CREATE TABLE IF NOT EXISTS reward_ledger_entries (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  team_member_id uuid REFERENCES team_members(id) ON DELETE CASCADE,
  date date NOT NULL DEFAULT CURRENT_DATE,
  description text NOT NULL,
  amount numeric NOT NULL DEFAULT 0,
  project_id uuid REFERENCES projects(id) ON DELETE SET NULL,
  vendor_id text NOT NULL,
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);

-- Enable RLS on all tables
ALTER TABLE assets ENABLE ROW LEVEL SECURITY;
ALTER TABLE contracts ENABLE ROW LEVEL SECURITY;
ALTER TABLE client_feedback ENABLE ROW LEVEL SECURITY;
ALTER TABLE notifications ENABLE ROW LEVEL SECURITY;
ALTER TABLE social_media_posts ENABLE ROW LEVEL SECURITY;
ALTER TABLE promo_codes ENABLE ROW LEVEL SECURITY;
ALTER TABLE sops ENABLE ROW LEVEL SECURITY;
ALTER TABLE team_project_payments ENABLE ROW LEVEL SECURITY;
ALTER TABLE team_payment_records ENABLE ROW LEVEL SECURITY;
ALTER TABLE reward_ledger_entries ENABLE ROW LEVEL SECURITY;

-- Create policies for all tables
CREATE POLICY "Vendor users can manage their assets"
  ON assets FOR ALL TO authenticated
  USING (EXISTS (SELECT 1 FROM users WHERE users.id::text = auth.uid()::text AND users.vendor_id = assets.vendor_id));

CREATE POLICY "Vendor users can manage their contracts"
  ON contracts FOR ALL TO authenticated
  USING (EXISTS (SELECT 1 FROM users WHERE users.id::text = auth.uid()::text AND users.vendor_id = contracts.vendor_id));

CREATE POLICY "Public can submit feedback"
  ON client_feedback FOR INSERT TO anon
  WITH CHECK (true);

CREATE POLICY "Vendor users can read their feedback"
  ON client_feedback FOR SELECT TO authenticated
  USING (EXISTS (SELECT 1 FROM users WHERE users.id::text = auth.uid()::text AND users.vendor_id = client_feedback.vendor_id));

CREATE POLICY "Vendor users can manage their notifications"
  ON notifications FOR ALL TO authenticated
  USING (EXISTS (SELECT 1 FROM users WHERE users.id::text = auth.uid()::text AND users.vendor_id = notifications.vendor_id));

CREATE POLICY "Vendor users can manage their social posts"
  ON social_media_posts FOR ALL TO authenticated
  USING (EXISTS (SELECT 1 FROM users WHERE users.id::text = auth.uid()::text AND users.vendor_id = social_media_posts.vendor_id));

CREATE POLICY "Vendor users can manage their promo codes"
  ON promo_codes FOR ALL TO authenticated
  USING (EXISTS (SELECT 1 FROM users WHERE users.id::text = auth.uid()::text AND users.vendor_id = promo_codes.vendor_id));

CREATE POLICY "Vendor users can manage their SOPs"
  ON sops FOR ALL TO authenticated
  USING (EXISTS (SELECT 1 FROM users WHERE users.id::text = auth.uid()::text AND users.vendor_id = sops.vendor_id));

CREATE POLICY "Freelancers can read relevant SOPs"
  ON sops FOR SELECT TO anon
  USING (true);

CREATE POLICY "Vendor users can manage team payments"
  ON team_project_payments FOR ALL TO authenticated
  USING (EXISTS (SELECT 1 FROM users WHERE users.id::text = auth.uid()::text AND users.vendor_id = team_project_payments.vendor_id));

CREATE POLICY "Vendor users can manage payment records"
  ON team_payment_records FOR ALL TO authenticated
  USING (EXISTS (SELECT 1 FROM users WHERE users.id::text = auth.uid()::text AND users.vendor_id = team_payment_records.vendor_id));

CREATE POLICY "Vendor users can manage reward entries"
  ON reward_ledger_entries FOR ALL TO authenticated
  USING (EXISTS (SELECT 1 FROM users WHERE users.id::text = auth.uid()::text AND users.vendor_id = reward_ledger_entries.vendor_id));

-- Create indexes
CREATE INDEX IF NOT EXISTS idx_assets_vendor_id ON assets(vendor_id);
CREATE INDEX IF NOT EXISTS idx_contracts_vendor_id ON contracts(vendor_id);
CREATE INDEX IF NOT EXISTS idx_client_feedback_vendor_id ON client_feedback(vendor_id);
CREATE INDEX IF NOT EXISTS idx_notifications_vendor_id ON notifications(vendor_id);
CREATE INDEX IF NOT EXISTS idx_social_media_posts_vendor_id ON social_media_posts(vendor_id);
CREATE INDEX IF NOT EXISTS idx_promo_codes_vendor_id ON promo_codes(vendor_id);
CREATE INDEX IF NOT EXISTS idx_sops_vendor_id ON sops(vendor_id);
CREATE INDEX IF NOT EXISTS idx_team_project_payments_vendor_id ON team_project_payments(vendor_id);
CREATE INDEX IF NOT EXISTS idx_team_payment_records_vendor_id ON team_payment_records(vendor_id);
CREATE INDEX IF NOT EXISTS idx_reward_ledger_entries_vendor_id ON reward_ledger_entries(vendor_id);