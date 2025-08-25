/*
  # Create Projects Table

  1. New Tables
    - `projects`
      - `id` (uuid, primary key)
      - `project_name` (text)
      - `client_name` (text)
      - `client_id` (uuid, foreign key)
      - `project_type` (text)
      - `package_name` (text)
      - `package_id` (uuid, foreign key)
      - `add_ons` (jsonb)
      - `date` (date)
      - `deadline_date` (date, optional)
      - `location` (text)
      - `progress` (integer, 0-100)
      - `status` (text)
      - `active_sub_statuses` (jsonb)
      - `total_cost` (numeric)
      - `amount_paid` (numeric)
      - `payment_status` (text)
      - `team` (jsonb)
      - `notes` (text, optional)
      - `accommodation` (text, optional)
      - `drive_link` (text, optional)
      - `client_drive_link` (text, optional)
      - `final_drive_link` (text, optional)
      - `start_time` (text, optional)
      - `end_time` (text, optional)
      - `image` (text, optional)
      - `revisions` (jsonb)
      - `promo_code_id` (uuid, optional)
      - `discount_amount` (numeric, optional)
      - `shipping_details` (text, optional)
      - `dp_proof_url` (text, optional)
      - `printing_details` (jsonb)
      - `printing_cost` (numeric, optional)
      - `transport_cost` (numeric, optional)
      - `booking_status` (text, optional)
      - `rejection_reason` (text, optional)
      - `chat_history` (jsonb)
      - `invoice_signature` (text, optional)
      - `vendor_id` (text)
      - `created_at` (timestamp)
      - `updated_at` (timestamp)

  2. Security
    - Enable RLS on `projects` table
    - Add policies for vendor users and client portal access
*/

CREATE TABLE IF NOT EXISTS projects (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  project_name text NOT NULL,
  client_name text NOT NULL,
  client_id uuid REFERENCES clients(id) ON DELETE CASCADE,
  project_type text NOT NULL,
  package_name text NOT NULL,
  package_id uuid REFERENCES packages(id),
  add_ons jsonb DEFAULT '[]'::jsonb,
  date date NOT NULL,
  deadline_date date,
  location text NOT NULL,
  progress integer DEFAULT 0 CHECK (progress >= 0 AND progress <= 100),
  status text NOT NULL DEFAULT 'Dikonfirmasi',
  active_sub_statuses jsonb DEFAULT '[]'::jsonb,
  total_cost numeric NOT NULL DEFAULT 0,
  amount_paid numeric DEFAULT 0,
  payment_status text NOT NULL DEFAULT 'Belum Bayar' CHECK (payment_status IN ('Lunas', 'DP Terbayar', 'Belum Bayar')),
  team jsonb DEFAULT '[]'::jsonb,
  notes text,
  accommodation text,
  drive_link text,
  client_drive_link text,
  final_drive_link text,
  start_time text,
  end_time text,
  image text,
  revisions jsonb DEFAULT '[]'::jsonb,
  promo_code_id uuid,
  discount_amount numeric DEFAULT 0,
  shipping_details text,
  dp_proof_url text,
  printing_details jsonb DEFAULT '[]'::jsonb,
  printing_cost numeric DEFAULT 0,
  transport_cost numeric DEFAULT 0,
  booking_status text CHECK (booking_status IN ('Baru', 'Terkonfirmasi', 'Ditolak')),
  rejection_reason text,
  chat_history jsonb DEFAULT '[]'::jsonb,
  invoice_signature text,
  vendor_id text NOT NULL,
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);

ALTER TABLE projects ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Vendor users can manage their projects"
  ON projects
  FOR ALL
  TO authenticated
  USING (
    EXISTS (
      SELECT 1 FROM users 
      WHERE users.id::text = auth.uid()::text 
      AND users.vendor_id = projects.vendor_id
    )
  );

CREATE POLICY "Clients can view their projects via portal"
  ON projects
  FOR SELECT
  TO anon
  USING (
    EXISTS (
      SELECT 1 FROM clients 
      WHERE clients.id = projects.client_id
    )
  );

-- Create indexes
CREATE INDEX IF NOT EXISTS idx_projects_vendor_id ON projects(vendor_id);
CREATE INDEX IF NOT EXISTS idx_projects_client_id ON projects(client_id);
CREATE INDEX IF NOT EXISTS idx_projects_date ON projects(date);
CREATE INDEX IF NOT EXISTS idx_projects_status ON projects(status);