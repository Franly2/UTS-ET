import 'package:project_uts/class/user.dart';

final List<User> users = [
  User(
    'Budi Santoso',
    '5121100001',
    'Teknik Informatika',
    'Mahasiswa semester 5 yang bersemangat dalam pengembangan mobile dan web. Saat ini sedang mendalami Flutter dan tertarik dengan machine learning.',
    'https://i.pravatar.cc/300?u=1',
    'budi.santoso@email.com',
    'password123',
  ),
  User(
    'Citra Lestari',
    '5121100002',
    'Sistem Informasi',
    'Fokus pada analisis data dan UI/UX design. Aktif di organisasi kampus dan memiliki hobi fotografi.',
    'https://i.pravatar.cc/300?u=2',
    'citra.lestari@email.com',
    'password234',
  ),
  User(
    'Agus Wijaya',
    '5121100003',
    'Teknik Komputer',
    'Tertarik pada bidang keamanan siber dan jaringan komputer. Sering mengikuti kompetisi CTF (Capture The Flag).',
    'https://i.pravatar.cc/300?u=3',
    'agus.wijaya@email.com',
    'password345',
  ),
  User(
    'Dewi Anggraini',
    '5121100004',
    'Teknik Informatika',
    'Spesialisasi di bidang kecerdasan buatan dan pengolahan citra digital. Sedang mengerjakan proyek akhir tentang deteksi objek.',
    'https://i.pravatar.cc/300?u=4',
    'dewi.anggraini@email.com',
    'password456',
  ),
  User(
    'Eko Prasetyo',
    '5121100005',
    'Desain Komunikasi Visual',
    'Memiliki passion di ilustrasi digital dan animasi. Menggabungkan seni dengan teknologi untuk menciptakan karya interaktif.',
    'https://i.pravatar.cc/300?u=5',
    'eko.prasetyo@email.com',
    'password567',
  ),
];

List<User> getUserData() {
  return users;
}
