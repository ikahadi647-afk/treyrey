/*
  # Create Financial Tables (Cards and Pockets)

  1. New Tables
    - `cards`
      - `id` (uuid, primary key)
      - `card_holder_name` (text)
      - `bank_name` (text)
      - `card_type` (text)
      - `last_four_digits` (text)
      - `expiry_date` (text, optional)
      - `balance` (numeric)
      - `color_gradient` (text)
      - `vendor_id` (text)
      - `created_at` (timestamp)
      - `updated_at` (timestamp)
    
    - `financial_pockets`
      - `id` (uuid, primary key)
      - `name` (text)
      - `description` (text)
      - `icon` (text)
      - `type` (text)
      - `amount` (numeric)
      - `goal_amount` (numeric, optional)
      - `lock_end_date` (date, optional)
      - `members` (jsonb, optional)
      - `source_card_id` (uuid, optional)
      - `vendor_id` (text)
      - `created_at` (timestamp)
      - `updated_at` (timestamp)

  2. Security
    - Enable RLS on both tables
    - Add policies for vendor users to manage their financial data
*/

CREATE TABLE IF NOT EXISTS cards (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  card_holder_name text NOT NULL,
  bank_name text NOT NULL,
  card_type text NOT NULL CHECK (card_type IN ('Prabayar', 'Kredit', 'Debit', 'Tunai')),
  last_four_digits text NOT NULL,
  expiry_date text,
  balance numeric DEFAULT 0,
  color_gradient text NOT NULL DEFAULT 'from-blue-500 to-sky-400',
  vendor_id text NOT NULL,
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);

CREATE TABLE IF NOT EXISTS financial_pockets (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  name text NOT NULL,
  description text NOT NULL,
  icon text NOT NULL DEFAULT 'piggy-bank' CHECK (icon IN ('piggy-bank', 'lock', 'users', 'clipboard-list', 'star')),
  type text NOT NULL CHECK (type IN ('Nabung & Bayar', 'Terkunci', 'Bersama', 'Anggaran Pengeluaran', 'Tabungan Hadiah Freelancer')),
  amount numeric DEFAULT 0,
  goal_amount numeric,
  lock_end_date date,
  members jsonb DEFAULT '[]'::jsonb,
  source_card_id uuid REFERENCES cards(id) ON DELETE SET NULL,
  vendor_id text NOT NULL,
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);

ALTER TABLE cards ENABLE ROW LEVEL SECURITY;
ALTER TABLE financial_pockets ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Vendor users can manage their cards"
  ON cards
  FOR ALL
  TO authenticated
  USING (
    EXISTS (
      SELECT 1 FROM users 
      WHERE users.id::text = auth.uid()::text 
      AND users.vendor_id = cards.vendor_id
    )
  );

CREATE POLICY "Vendor users can manage their pockets"
  ON financial_pockets
  FOR ALL
  TO authenticated
  USING (
    EXISTS (
      SELECT 1 FROM users 
      WHERE users.id::text = auth.uid()::text 
      AND users.vendor_id = financial_pockets.vendor_id
    )
  );

-- Create indexes
CREATE INDEX IF NOT EXISTS idx_cards_vendor_id ON cards(vendor_id);
CREATE INDEX IF NOT EXISTS idx_financial_pockets_vendor_id ON financial_pockets(vendor_id);