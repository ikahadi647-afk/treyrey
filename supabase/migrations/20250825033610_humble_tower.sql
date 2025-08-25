/*
  # Create Profile Table

  1. New Tables
    - `profiles`
      - `id` (uuid, primary key)
      - `full_name` (text)
      - `email` (text)
      - `phone` (text)
      - `company_name` (text)
      - `website` (text)
      - `address` (text)
      - `bank_account` (text)
      - `authorized_signer` (text)
      - `id_number` (text, optional)
      - `bio` (text)
      - `income_categories` (jsonb)
      - `expense_categories` (jsonb)
      - `project_types` (jsonb)
      - `event_types` (jsonb)
      - `asset_categories` (jsonb)
      - `sop_categories` (jsonb)
      - `project_status_config` (jsonb)
      - `notification_settings` (jsonb)
      - `security_settings` (jsonb)
      - `briefing_template` (text)
      - `terms_and_conditions` (text, optional)
      - `contract_template` (text, optional)
      - `logo_base64` (text, optional)
      - `brand_color` (text, optional)
      - `public_page_config` (jsonb)
      - `package_share_template` (text, optional)
      - `booking_form_template` (text, optional)
      - `chat_templates` (jsonb)
      - `current_plan_id` (text, optional)
      - `vendor_id` (text)
      - `created_at` (timestamp)
      - `updated_at` (timestamp)

  2. Security
    - Enable RLS on `profiles` table
    - Add policy for vendor users to manage their profile
*/

CREATE TABLE IF NOT EXISTS profiles (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  full_name text NOT NULL,
  email text NOT NULL,
  phone text NOT NULL,
  company_name text NOT NULL,
  website text DEFAULT '',
  address text NOT NULL,
  bank_account text NOT NULL,
  authorized_signer text NOT NULL,
  id_number text,
  bio text DEFAULT '',
  income_categories jsonb DEFAULT '["DP Proyek", "Pelunasan Proyek", "Add-On", "Lainnya"]'::jsonb,
  expense_categories jsonb DEFAULT '["Operasional", "Peralatan", "Transport", "Akomodasi", "Printing", "Gaji Freelancer", "Lainnya"]'::jsonb,
  project_types jsonb DEFAULT '["Pernikahan", "Prewedding", "Engagement", "Lamaran", "Siraman", "Akad", "Resepsi", "Sangjit", "Lainnya"]'::jsonb,
  event_types jsonb DEFAULT '["Meeting Klien", "Survey Lokasi", "Libur", "Workshop", "Lainnya"]'::jsonb,
  asset_categories jsonb DEFAULT '["Kamera", "Lensa", "Lighting", "Audio", "Drone", "Aksesoris", "Komputer", "Software", "Lainnya"]'::jsonb,
  sop_categories jsonb DEFAULT '["Pernikahan", "Prewedding", "Editing", "Administrasi", "Umum"]'::jsonb,
  project_status_config jsonb DEFAULT '[
    {"id": "1", "name": "Dikonfirmasi", "color": "#3b82f6", "subStatuses": [], "note": "Proyek telah dikonfirmasi dan siap dimulai"},
    {"id": "2", "name": "Briefing", "color": "#8b5cf6", "subStatuses": [{"name": "Persiapan Brief", "note": "Menyiapkan materi briefing"}, {"name": "Meeting Brief", "note": "Melakukan meeting briefing dengan klien"}], "note": "Tahap briefing dengan klien"},
    {"id": "3", "name": "Persiapan", "color": "#06b6d4", "subStatuses": [{"name": "Cek Peralatan", "note": "Memastikan semua peralatan siap"}, {"name": "Koordinasi Tim", "note": "Briefing dengan tim yang bertugas"}], "note": "Persiapan sebelum hari H"},
    {"id": "4", "name": "Pelaksanaan", "color": "#f97316", "subStatuses": [{"name": "Setup", "note": "Persiapan di lokasi"}, {"name": "Shooting", "note": "Proses pemotretan berlangsung"}], "note": "Hari pelaksanaan acara"},
    {"id": "5", "name": "Editing", "color": "#eab308", "subStatuses": [{"name": "Seleksi Foto", "note": "Memilih foto terbaik"}, {"name": "Basic Editing", "note": "Editing dasar foto"}, {"name": "Advanced Editing", "note": "Editing lanjutan dan retouching"}], "note": "Proses editing foto dan video"},
    {"id": "6", "name": "Review", "color": "#6366f1", "subStatuses": [{"name": "Internal Review", "note": "Review internal tim"}, {"name": "Client Review", "note": "Menunggu review dari klien"}], "note": "Tahap review hasil editing"},
    {"id": "7", "name": "Printing", "color": "#ec4899", "subStatuses": [{"name": "Persiapan File", "note": "Menyiapkan file untuk cetak"}, {"name": "Proses Cetak", "note": "Proses pencetakan album/foto"}], "note": "Proses pencetakan album dan foto"},
    {"id": "8", "name": "Dikirim", "color": "#10b981", "subStatuses": [{"name": "Packing", "note": "Pengemasan hasil"}, {"name": "Pengiriman", "note": "Dalam proses pengiriman"}], "note": "Hasil sedang dikirim ke klien"},
    {"id": "9", "name": "Selesai", "color": "#16a34a", "subStatuses": [], "note": "Proyek telah selesai dan diterima klien"},
    {"id": "10", "name": "Dibatalkan", "color": "#ef4444", "subStatuses": [], "note": "Proyek dibatalkan"}
  ]'::jsonb,
  notification_settings jsonb DEFAULT '{"newProject": true, "paymentConfirmation": true, "deadlineReminder": true}'::jsonb,
  security_settings jsonb DEFAULT '{"twoFactorEnabled": false}'::jsonb,
  briefing_template text DEFAULT 'Template briefing default...',
  terms_and_conditions text,
  contract_template text,
  logo_base64 text,
  brand_color text DEFAULT '#3b82f6',
  public_page_config jsonb DEFAULT '{"template": "modern", "title": "Paket Layanan Fotografi", "introduction": "Pilih paket yang sesuai dengan kebutuhan acara Anda.", "galleryImages": []}'::jsonb,
  package_share_template text DEFAULT 'Halo {leadName}! Terima kasih sudah menghubungi {companyName}. Silakan lihat paket layanan kami di: {packageLink}',
  booking_form_template text DEFAULT 'Halo {leadName}! Silakan lengkapi formulir booking berikut untuk melanjutkan: {bookingFormLink}',
  chat_templates jsonb DEFAULT '[
    {"id": "greeting", "title": "Salam Pembuka", "template": "Halo {clientName}! Terima kasih sudah mempercayakan {projectName} kepada kami. Kami akan memberikan pelayanan terbaik untuk Anda."},
    {"id": "reminder", "title": "Pengingat", "template": "Halo {clientName}, ini adalah pengingat untuk proyek {projectName}. Jangan lupa untuk..."},
    {"id": "completion", "title": "Proyek Selesai", "template": "Halo {clientName}! Proyek {projectName} telah selesai. Terima kasih atas kepercayaannya!"}
  ]'::jsonb,
  current_plan_id text,
  vendor_id text NOT NULL,
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);

ALTER TABLE profiles ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Vendor users can manage their profile"
  ON profiles
  FOR ALL
  TO authenticated
  USING (
    EXISTS (
      SELECT 1 FROM users 
      WHERE users.id::text = auth.uid()::text 
      AND users.vendor_id = profiles.vendor_id
    )
  );

CREATE POLICY "Public can read profiles for public pages"
  ON profiles
  FOR SELECT
  TO anon
  USING (true);

-- Create indexes for all tables
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
CREATE INDEX IF NOT EXISTS idx_profiles_vendor_id ON profiles(vendor_id);