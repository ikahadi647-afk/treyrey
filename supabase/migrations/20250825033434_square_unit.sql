/*
  # Create Packages and Add-ons Tables

  1. New Tables
    - `packages`
      - `id` (uuid, primary key)
      - `name` (text)
      - `price` (numeric)
      - `physical_items` (jsonb)
      - `digital_items` (jsonb)
      - `processing_time` (text)
      - `photographers` (text, optional)
      - `videographers` (text, optional)
      - `cover_image` (text, optional)
      - `vendor_id` (text)
      - `created_at` (timestamp)
      - `updated_at` (timestamp)
    
    - `add_ons`
      - `id` (uuid, primary key)
      - `name` (text)
      - `price` (numeric)
      - `vendor_id` (text)
      - `created_at` (timestamp)
      - `updated_at` (timestamp)

  2. Security
    - Enable RLS on both tables
    - Add policies for vendor users to manage their packages and add-ons
*/

CREATE TABLE IF NOT EXISTS packages (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  name text NOT NULL,
  price numeric NOT NULL DEFAULT 0,
  physical_items jsonb DEFAULT '[]'::jsonb,
  digital_items jsonb DEFAULT '[]'::jsonb,
  processing_time text NOT NULL DEFAULT '30 hari kerja',
  photographers text,
  videographers text,
  cover_image text,
  vendor_id text NOT NULL,
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);

CREATE TABLE IF NOT EXISTS add_ons (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  name text NOT NULL,
  price numeric NOT NULL DEFAULT 0,
  vendor_id text NOT NULL,
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);

ALTER TABLE packages ENABLE ROW LEVEL SECURITY;
ALTER TABLE add_ons ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Vendor users can manage their packages"
  ON packages
  FOR ALL
  TO authenticated
  USING (
    EXISTS (
      SELECT 1 FROM users 
      WHERE users.id::text = auth.uid()::text 
      AND users.vendor_id = packages.vendor_id
    )
  );

CREATE POLICY "Public can read packages"
  ON packages
  FOR SELECT
  TO anon
  USING (true);

CREATE POLICY "Vendor users can manage their add-ons"
  ON add_ons
  FOR ALL
  TO authenticated
  USING (
    EXISTS (
      SELECT 1 FROM users 
      WHERE users.id::text = auth.uid()::text 
      AND users.vendor_id = add_ons.vendor_id
    )
  );

CREATE POLICY "Public can read add-ons"
  ON add_ons
  FOR SELECT
  TO anon
  USING (true);

-- Create indexes
CREATE INDEX IF NOT EXISTS idx_packages_vendor_id ON packages(vendor_id);
CREATE INDEX IF NOT EXISTS idx_add_ons_vendor_id ON add_ons(vendor_id);