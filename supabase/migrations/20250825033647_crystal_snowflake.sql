/*
  # Insert Mock Data for Vena Pictures

  1. Mock Data Insertion
    - Insert sample users (admin and member)
    - Insert sample profile
    - Insert sample clients
    - Insert sample packages and add-ons
    - Insert sample team members
    - Insert sample projects
    - Insert sample transactions
    - Insert sample cards and pockets
    - Insert sample leads
    - Insert sample assets
    - Insert sample contracts
    - Insert sample feedback
    - Insert sample notifications
    - Insert sample promo codes
    - Insert sample SOPs

  2. Notes
    - All data uses vendor_id 'VEN001' for consistency
    - Passwords are plain text for demo purposes (should be hashed in production)
    - UUIDs are generated for all primary keys
    - Dates are set to realistic values
*/

-- Insert Users
INSERT INTO users (id, email, password, full_name, company_name, role, permissions, vendor_id) VALUES
  ('550e8400-e29b-41d4-a716-446655440001', 'admin@vena.pictures', 'admin', 'Vena Pratama', 'Vena Pictures', 'Admin', '[]'::jsonb, 'VEN001'),
  ('550e8400-e29b-41d4-a716-446655440002', 'member@vena.pictures', 'member', 'Sarah Editor', 'Vena Pictures', 'Member', '["Proyek", "Manajemen Klien", "Keuangan"]'::jsonb, 'VEN001');

-- Insert Profile
INSERT INTO profiles (
  id, full_name, email, phone, company_name, website, address, bank_account, authorized_signer, bio, vendor_id
) VALUES (
  '550e8400-e29b-41d4-a716-446655440100',
  'Vena Pratama',
  'admin@vena.pictures',
  '085693762240',
  'Vena Pictures',
  'https://venapictures.com',
  'Jl. Fotografi No. 123, Jakarta Selatan',
  'BCA 1234567890 a.n. Vena Pratama',
  'Vena Pratama',
  'Spesialis fotografi pernikahan dan prewedding dengan pengalaman lebih dari 5 tahun.',
  'VEN001'
);

-- Insert Packages
INSERT INTO packages (id, name, price, physical_items, digital_items, processing_time, photographers, videographers, vendor_id) VALUES
  ('550e8400-e29b-41d4-a716-446655440201', 'Paket Silver', 5000000, '[{"name": "Album 20x30 (20 halaman)", "price": 500000}]'::jsonb, '["300+ foto edited", "10 foto premium retouch", "Online gallery"]'::jsonb, '21 hari kerja', '1 Fotografer', '', 'VEN001'),
  ('550e8400-e29b-41d4-a716-446655440202', 'Paket Gold', 8000000, '[{"name": "Album 25x35 (30 halaman)", "price": 800000}, {"name": "Mini album 15x20", "price": 300000}]'::jsonb, '["500+ foto edited", "20 foto premium retouch", "Online gallery", "Slideshow video"]'::jsonb, '30 hari kerja', '2 Fotografer', '1 Videografer', 'VEN001'),
  ('550e8400-e29b-41d4-a716-446655440203', 'Paket Platinum', 12000000, '[{"name": "Album 30x40 (40 halaman)", "price": 1200000}, {"name": "Mini album 15x20", "price": 300000}, {"name": "Frame foto 20x30", "price": 200000}]'::jsonb, '["All edited photos", "50 foto premium retouch", "Online gallery", "Cinematic video", "Same day edit"]'::jsonb, '45 hari kerja', '3 Fotografer', '2 Videografer', 'VEN001');

-- Insert Add-ons
INSERT INTO add_ons (id, name, price, vendor_id) VALUES
  ('550e8400-e29b-41d4-a716-446655440301', 'Drone Photography', 1500000, 'VEN001'),
  ('550e8400-e29b-41d4-a716-446655440302', 'Extra Photographer', 1000000, 'VEN001'),
  ('550e8400-e29b-41d4-a716-446655440303', 'Album Tambahan', 800000, 'VEN001'),
  ('550e8400-e29b-41d4-a716-446655440304', 'Same Day Edit', 2000000, 'VEN001');

-- Insert Clients
INSERT INTO clients (id, name, email, phone, whatsapp, instagram, since, status, client_type, last_contact, portal_access_id, vendor_id) VALUES
  ('550e8400-e29b-41d4-a716-446655440401', 'Andi & Sari', 'andi.sari@email.com', '081234567890', '081234567890', '@andisari_wedding', '2024-01-15', 'Aktif', 'Langsung', '2024-01-20T10:00:00Z', '550e8400-e29b-41d4-a716-446655440501', 'VEN001'),
  ('550e8400-e29b-41d4-a716-446655440402', 'Budi & Maya', 'budi.maya@email.com', '081234567891', '081234567891', '@budimaya_couple', '2024-02-01', 'Aktif', 'Langsung', '2024-02-05T14:30:00Z', '550e8400-e29b-41d4-a716-446655440502', 'VEN001'),
  ('550e8400-e29b-41d4-a716-446655440403', 'Citra & Doni', 'citra.doni@email.com', '081234567892', '081234567892', '@citradoni_love', '2024-03-10', 'Aktif', 'Langsung', '2024-03-15T09:15:00Z', '550e8400-e29b-41d4-a716-446655440503', 'VEN001');

-- Insert Team Members
INSERT INTO team_members (id, name, role, email, phone, standard_fee, no_rek, reward_balance, rating, performance_notes, portal_access_id, vendor_id) VALUES
  ('550e8400-e29b-41d4-a716-446655440601', 'Rizki Photographer', 'Fotografer', 'rizki@email.com', '081234567893', 800000, 'BCA 9876543210', 500000, 4.8, '[{"id": "note1", "date": "2024-01-10", "note": "Excellent work on the Andi & Sari wedding", "type": "Pujian"}]'::jsonb, '550e8400-e29b-41d4-a716-446655440701', 'VEN001'),
  ('550e8400-e29b-41d4-a716-446655440602', 'Maya Videographer', 'Videografer', 'maya@email.com', '081234567894', 1000000, 'Mandiri 1122334455', 300000, 4.9, '[{"id": "note2", "date": "2024-02-05", "note": "Great creativity in video editing", "type": "Pujian"}]'::jsonb, '550e8400-e29b-41d4-a716-446655440702', 'VEN001'),
  ('550e8400-e29b-41d4-a716-446655440603', 'Dedi Editor', 'Editor', 'dedi@email.com', '081234567895', 600000, 'BNI 5566778899', 200000, 4.7, '[]'::jsonb, '550e8400-e29b-41d4-a716-446655440703', 'VEN001');

-- Insert Projects
INSERT INTO projects (
  id, project_name, client_name, client_id, project_type, package_name, package_id, add_ons, date, location, progress, status, total_cost, amount_paid, payment_status, team, notes, vendor_id
) VALUES
  ('550e8400-e29b-41d4-a716-446655440801', 'Wedding Andi & Sari', 'Andi & Sari', '550e8400-e29b-41d4-a716-446655440401', 'Pernikahan', 'Paket Gold', '550e8400-e29b-41d4-a716-446655440202', '[{"id": "550e8400-e29b-41d4-a716-446655440301", "name": "Drone Photography", "price": 1500000}]'::jsonb, '2024-02-14', 'Ballroom Hotel Mulia, Jakarta', 85, 'Editing', 9500000, 4000000, 'DP Terbayar', '[{"memberId": "550e8400-e29b-41d4-a716-446655440601", "name": "Rizki Photographer", "role": "Fotografer", "fee": 800000, "reward": 100000}]'::jsonb, 'Klien sangat kooperatif, venue bagus', 'VEN001'),
  ('550e8400-e29b-41d4-a716-446655440802', 'Prewedding Budi & Maya', 'Budi & Maya', '550e8400-e29b-41d4-a716-446655440402', 'Prewedding', 'Paket Silver', '550e8400-e29b-41d4-a716-446655440201', '[]'::jsonb, '2024-03-20', 'Taman Mini Indonesia Indah', 100, 'Selesai', 5000000, 5000000, 'Lunas', '[{"memberId": "550e8400-e29b-41d4-a716-446655440601", "name": "Rizki Photographer", "role": "Fotografer", "fee": 800000, "reward": 50000}]'::jsonb, 'Hasil sangat memuaskan', 'VEN001'),
  ('550e8400-e29b-41d4-a716-446655440803', 'Engagement Citra & Doni', 'Citra & Doni', '550e8400-e29b-41d4-a716-446655440403', 'Engagement', 'Paket Platinum', '550e8400-e29b-41d4-a716-446655440203', '[{"id": "550e8400-e29b-41d4-a716-446655440302", "name": "Extra Photographer", "price": 1000000}]'::jsonb, '2024-04-15', 'Ancol Beach City, Jakarta', 45, 'Briefing', 13000000, 6500000, 'DP Terbayar', '[{"memberId": "550e8400-e29b-41d4-a716-446655440601", "name": "Rizki Photographer", "role": "Fotografer", "fee": 800000, "reward": 0}, {"memberId": "550e8400-e29b-41d4-a716-446655440602", "name": "Maya Videographer", "role": "Videografer", "fee": 1000000, "reward": 0}]'::jsonb, 'Konsep outdoor dengan tema vintage', 'VEN001');

-- Insert Cards
INSERT INTO cards (id, card_holder_name, bank_name, card_type, last_four_digits, expiry_date, balance, color_gradient, vendor_id) VALUES
  ('550e8400-e29b-41d4-a716-446655440901', 'Vena Pratama', 'BCA', 'Debit', '1234', '12/26', 25000000, 'from-blue-500 to-sky-400', 'VEN001'),
  ('550e8400-e29b-41d4-a716-446655440902', 'Vena Pratama', 'Mandiri', 'Kredit', '5678', '08/25', 15000000, 'from-purple-500 to-pink-400', 'VEN001'),
  ('550e8400-e29b-41d4-a716-446655440903', 'Vena Pictures', 'Tunai', 'Tunai', 'CASH', '', 5000000, 'from-green-500 to-emerald-400', 'VEN001');

-- Insert Financial Pockets
INSERT INTO financial_pockets (id, name, description, icon, type, amount, goal_amount, vendor_id) VALUES
  ('550e8400-e29b-41d4-a716-446655441001', 'Dana Darurat', 'Simpanan untuk keperluan mendesak', 'lock', 'Terkunci', 10000000, 20000000, 'VEN001'),
  ('550e8400-e29b-41d4-a716-446655441002', 'Upgrade Peralatan', 'Tabungan untuk beli kamera baru', 'piggy-bank', 'Nabung & Bayar', 8000000, 50000000, 'VEN001'),
  ('550e8400-e29b-41d4-a716-446655441003', 'Reward Pool', 'Pool hadiah untuk freelancer', 'star', 'Tabungan Hadiah Freelancer', 2000000, NULL, 'VEN001');

-- Insert Transactions
INSERT INTO transactions (id, date, description, amount, type, project_id, category, method, card_id, vendor_id) VALUES
  ('550e8400-e29b-41d4-a716-446655441101', '2024-01-15', 'DP Wedding Andi & Sari', 4000000, 'Pemasukan', '550e8400-e29b-41d4-a716-446655440801', 'DP Proyek', 'Transfer Bank', '550e8400-e29b-41d4-a716-446655440901', 'VEN001'),
  ('550e8400-e29b-41d4-a716-446655441102', '2024-02-20', 'Pelunasan Prewedding Budi & Maya', 5000000, 'Pemasukan', '550e8400-e29b-41d4-a716-446655440802', 'Pelunasan Proyek', 'Transfer Bank', '550e8400-e29b-41d4-a716-446655440901', 'VEN001'),
  ('550e8400-e29b-41d4-a716-446655441103', '2024-03-10', 'DP Engagement Citra & Doni', 6500000, 'Pemasukan', '550e8400-e29b-41d4-a716-446655440803', 'DP Proyek', 'Transfer Bank', '550e8400-e29b-41d4-a716-446655440902', 'VEN001'),
  ('550e8400-e29b-41d4-a716-446655441104', '2024-01-20', 'Beli Lensa 85mm', 8000000, 'Pengeluaran', NULL, 'Peralatan', 'Transfer Bank', '550e8400-e29b-41d4-a716-446655440901', 'VEN001'),
  ('550e8400-e29b-41d4-a716-446655441105', '2024-02-01', 'Gaji Rizki Photographer', 800000, 'Pengeluaran', '550e8400-e29b-41d4-a716-446655440802', 'Gaji Freelancer', 'Transfer Bank', '550e8400-e29b-41d4-a716-446655440901', 'VEN001');

-- Insert Leads
INSERT INTO leads (id, name, contact_channel, location, status, date, notes, whatsapp, vendor_id) VALUES
  ('550e8400-e29b-41d4-a716-446655441201', 'Eka & Fajar', 'Instagram', 'Bandung', 'Sedang Diskusi', '2024-01-25', 'Tertarik paket Gold untuk pernikahan Juni 2024', '081234567896', 'VEN001'),
  ('550e8400-e29b-41d4-a716-446655441202', 'Gita & Hendra', 'WhatsApp', 'Surabaya', 'Menunggu Follow Up', '2024-01-28', 'Butuh paket prewedding outdoor', '081234567897', 'VEN001'),
  ('550e8400-e29b-41d4-a716-446655441203', 'Indira & Joko', 'Website', 'Yogyakarta', 'Dikonversi', '2024-02-05', 'Sudah booking paket Silver', '081234567898', 'VEN001');

-- Insert Assets
INSERT INTO assets (id, name, category, purchase_date, purchase_price, serial_number, status, notes, vendor_id) VALUES
  ('550e8400-e29b-41d4-a716-446655441301', 'Canon EOS R5', 'Kamera', '2023-06-15', 65000000, 'CR5001234', 'Tersedia', 'Kamera utama untuk wedding', 'VEN001'),
  ('550e8400-e29b-41d4-a716-446655441302', 'Sony FX3', 'Kamera', '2023-08-20', 45000000, 'FX3005678', 'Digunakan', 'Untuk video cinematic', 'VEN001'),
  ('550e8400-e29b-41d4-a716-446655441303', 'DJI Mavic 3', 'Drone', '2023-10-10', 25000000, 'MV3009876', 'Tersedia', 'Drone untuk aerial shot', 'VEN001'),
  ('550e8400-e29b-41d4-a716-446655441304', 'Godox AD600', 'Lighting', '2023-05-01', 8000000, 'GD600123', 'Perbaikan', 'Perlu service rutin', 'VEN001');

-- Insert Contracts
INSERT INTO contracts (
  id, contract_number, client_id, project_id, signing_date, signing_location, client_name1, client_address1, client_phone1, 
  shooting_duration, guaranteed_photos, album_details, other_items, personnel_count, delivery_timeframe, 
  dp_date, final_payment_date, cancellation_policy, jurisdiction, vendor_id
) VALUES
  ('550e8400-e29b-41d4-a716-446655441401', 'VP/CTR/2024/001', '550e8400-e29b-41d4-a716-446655440401', '550e8400-e29b-41d4-a716-446655440801', '2024-01-15', 'Jakarta', 'Andi Wijaya', 'Jl. Mawar No. 45, Jakarta Selatan', '081234567890', '8 jam (10:00 - 18:00)', '500+ foto edited', 'Album 25x35 (30 halaman)', 'Slideshow video, Online gallery', '2 Fotografer, 1 Videografer', '30 hari kerja', '2024-01-15', '2024-02-10', 'DP yang sudah dibayarkan tidak dapat dikembalikan. Jika pembatalan dilakukan H-7 sebelum hari pelaksanaan, PIHAK KEDUA wajib membayar 50% dari total biaya.', 'Jakarta', 'VEN001'),
  ('550e8400-e29b-41d4-a716-446655441402', 'VP/CTR/2024/002', '550e8400-e29b-41d4-a716-446655440402', '550e8400-e29b-41d4-a716-446655440802', '2024-02-01', 'Jakarta', 'Budi Santoso', 'Jl. Melati No. 12, Jakarta Timur', '081234567891', '4 jam (14:00 - 18:00)', '300+ foto edited', 'Album 20x30 (20 halaman)', 'Online gallery', '1 Fotografer', '21 hari kerja', '2024-02-01', '2024-03-15', 'DP yang sudah dibayarkan tidak dapat dikembalikan. Jika pembatalan dilakukan H-7 sebelum hari pelaksanaan, PIHAK KEDUA wajib membayar 50% dari total biaya.', 'Jakarta', 'VEN001');

-- Insert Client Feedback
INSERT INTO client_feedback (id, client_name, satisfaction, rating, feedback, date, vendor_id) VALUES
  ('550e8400-e29b-41d4-a716-446655441501', 'Budi & Maya', 'Sangat Puas', 5, 'Hasil foto prewedding sangat bagus! Tim sangat profesional dan ramah. Highly recommended!', '2024-03-25', 'VEN001'),
  ('550e8400-e29b-41d4-a716-446655441502', 'Andi & Sari', 'Puas', 4, 'Overall bagus, cuma agak telat delivery. Tapi hasilnya memuaskan.', '2024-03-15', 'VEN001'),
  ('550e8400-e29b-41d4-a716-446655441503', 'Citra & Doni', 'Sangat Puas', 5, 'Perfect! Exactly what we wanted. The team was amazing!', '2024-04-20', 'VEN001');

-- Insert Notifications
INSERT INTO notifications (id, title, message, timestamp, is_read, icon, link_view, vendor_id) VALUES
  ('550e8400-e29b-41d4-a716-446655441601', 'Proyek Baru Ditambahkan', 'Wedding Andi & Sari telah ditambahkan ke sistem', '2024-01-15T10:00:00Z', false, 'lead', 'Proyek', 'VEN001'),
  ('550e8400-e29b-41d4-a716-446655441602', 'Pembayaran Diterima', 'DP sebesar Rp 4.000.000 dari Andi & Sari telah diterima', '2024-01-15T14:30:00Z', true, 'payment', 'Keuangan', 'VEN001'),
  ('550e8400-e29b-41d4-a716-446655441603', 'Deadline Mendekat', 'Proyek Wedding Andi & Sari deadline dalam 3 hari', '2024-02-11T09:00:00Z', false, 'deadline', 'Proyek', 'VEN001');

-- Insert Promo Codes
INSERT INTO promo_codes (id, code, discount_type, discount_value, is_active, usage_count, max_usage, expiry_date, vendor_id) VALUES
  ('550e8400-e29b-41d4-a716-446655441701', 'NEWCLIENT2024', 'percentage', 10, true, 2, 50, '2024-12-31', 'VEN001'),
  ('550e8400-e29b-41d4-a716-446655441702', 'EARLYBIRD', 'fixed', 500000, true, 5, 20, '2024-06-30', 'VEN001'),
  ('550e8400-e29b-41d4-a716-446655441703', 'REFERRAL', 'percentage', 15, true, 1, NULL, NULL, 'VEN001');

-- Insert SOPs
INSERT INTO sops (id, title, category, content, last_updated, vendor_id) VALUES
  ('550e8400-e29b-41d4-a716-446655441801', 'Checklist Persiapan Wedding', 'Pernikahan', '# Checklist Persiapan Wedding

## H-7 Sebelum Acara
- [ ] Konfirmasi lokasi dan waktu dengan klien
- [ ] Cek kondisi semua peralatan
- [ ] Charge semua baterai
- [ ] Format memory card
- [ ] Siapkan backup peralatan

## H-1 Sebelum Acara
- [ ] Packing semua peralatan
- [ ] Konfirmasi rundown dengan klien
- [ ] Briefing dengan tim

## Hari H
- [ ] Datang 30 menit sebelum acara
- [ ] Setup peralatan
- [ ] Koordinasi dengan WO
- [ ] Mulai dokumentasi', '2024-01-10T10:00:00Z', 'VEN001'),
  ('550e8400-e29b-41d4-a716-446655441802', 'Workflow Editing Foto', 'Editing', '# Workflow Editing Foto

## Tahap 1: Seleksi
- Import semua foto ke Lightroom
- Buat collection untuk proyek
- Seleksi foto terbaik (rating 4-5 bintang)
- Hapus foto blur/gagal

## Tahap 2: Basic Editing
- Color correction
- Exposure adjustment
- Crop dan straighten
- Noise reduction

## Tahap 3: Advanced Editing
- Skin retouching (untuk foto close-up)
- Background cleanup
- Color grading
- Final sharpening

## Tahap 4: Export
- Export dengan kualitas tinggi (300 DPI)
- Watermark untuk preview
- Upload ke Google Drive', '2024-01-12T15:30:00Z', 'VEN001');

-- Insert Team Project Payments
INSERT INTO team_project_payments (id, project_id, team_member_name, team_member_id, date, status, fee, reward, vendor_id) VALUES
  ('550e8400-e29b-41d4-a716-446655441901', '550e8400-e29b-41d4-a716-446655440802', 'Rizki Photographer', '550e8400-e29b-41d4-a716-446655440601', '2024-03-25', 'Paid', 800000, 50000, 'VEN001'),
  ('550e8400-e29b-41d4-a716-446655441902', '550e8400-e29b-41d4-a716-446655440801', 'Rizki Photographer', '550e8400-e29b-41d4-a716-446655440601', '2024-02-14', 'Unpaid', 800000, 100000, 'VEN001'),
  ('550e8400-e29b-41d4-a716-446655441903', '550e8400-e29b-41d4-a716-446655440803', 'Maya Videographer', '550e8400-e29b-41d4-a716-446655440602', '2024-04-15', 'Unpaid', 1000000, 0, 'VEN001');

-- Insert Team Payment Records
INSERT INTO team_payment_records (id, record_number, team_member_id, date, project_payment_ids, total_amount, vendor_id) VALUES
  ('550e8400-e29b-41d4-a716-446655442001', 'PAY/2024/001', '550e8400-e29b-41d4-a716-446655440601', '2024-03-25', '["550e8400-e29b-41d4-a716-446655441901"]'::jsonb, 850000, 'VEN001');

-- Insert Reward Ledger Entries
INSERT INTO reward_ledger_entries (id, team_member_id, date, description, amount, project_id, vendor_id) VALUES
  ('550e8400-e29b-41d4-a716-446655442101', '550e8400-e29b-41d4-a716-446655440601', '2024-03-25', 'Bonus kualitas foto excellent', 50000, '550e8400-e29b-41d4-a716-446655440802', 'VEN001'),
  ('550e8400-e29b-41d4-a716-446655442102', '550e8400-e29b-41d4-a716-446655440602', '2024-02-10', 'Bonus kreativitas video', 75000, '550e8400-e29b-41d4-a716-446655440801', 'VEN001');

-- Insert Social Media Posts
INSERT INTO social_media_posts (id, project_id, client_name, post_type, platform, scheduled_date, caption, status, vendor_id) VALUES
  ('550e8400-e29b-41d4-a716-446655442201', '550e8400-e29b-41d4-a716-446655440802', 'Budi & Maya', 'Instagram Feed', 'Instagram', '2024-03-30', 'Beautiful prewedding session with Budi & Maya 💕 #VenaPictures #PreweddingJakarta #LoveStory', 'Diposting', 'VEN001'),
  ('550e8400-e29b-41d4-a716-446655442202', '550e8400-e29b-41d4-a716-446655440801', 'Andi & Sari', 'Instagram Reels', 'Instagram', '2024-04-01', 'Behind the scenes dari wedding Andi & Sari yang magical ✨ #WeddingJakarta #BehindTheScenes', 'Terjadwal', 'VEN001');