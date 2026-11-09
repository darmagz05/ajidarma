# DAFINITY Finance - aktivasi cloud privat

DAFINITY dibuat pada folder /dafinity/ dan TIDAK mengubah folder YooImprove.

GitHub Pages menayangkan web publik, tetapi database keuangan harus privat. Untuk mengaktifkan login dan sinkronisasi antarperangkat:

1. Buat proyek Supabase milik sendiri: https://supabase.com/dashboard
2. Supabase SQL Editor: jalankan isi file schema.sql sepenuhnya.
3. Authentication > Providers > Email: nonaktifkan pendaftaran publik jika hanya admin terpilih yang boleh masuk.
4. Authentication > Users > Add user: buat akun email dan PASSWORD KUAT, jangan masukkan password ke GitHub atau chat.
5. Settings > API Keys: salin **Project URL** dan **publishable/anon public key** (BUKAN secret/service_role).
6. Edit config.js pada folder dafinity, isi kedua nilai tersebut, lalu Commit.
7. Buka https://darmagz05.github.io/ajidarma/dafinity/ dan login di dua perangkat menggunakan akun yang sama.

Database dilindungi Row Level Security (RLS). Akun berbeda mendapat catatan terpisah; jangan membuat akun baru untuk orang yang perlu melihat data yang sama tanpa menambahkan sistem anggota/role. Sinkronisasi otomatis mengecek pembaruan kurang-lebih setiap 12 detik. Bila ada perubahan serentak, sistem menolak penimpaan data yang lebih baru.

Penting: Password ditangani sistem Supabase Auth, jangan gunakan password Javascript di halaman statis. Jangan masukkan data member sungguhan sebelum status koneksi cloud tersinkron dan pengaturan RLS diperiksa. Ekspor backup JSON secara rutin.

DAFINITY: VIP Rp99.000 dari normal Rp200.000; konsultasi voice call Rp25.000/sesi; tidak ada e-book.