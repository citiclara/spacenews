import 'package:flutter/material.dart';

class NotificationItem {
  final String title;
  final String subtitle;
  final IconData icon;
  final String time;

  NotificationItem({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.time,
  });
}

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  // Catatan: spesifikasi soal tidak menjelaskan sumber data notifikasi secara
  // detail, sehingga di sini ditampilkan sebagai daftar statis (urut terbaru
  // ke terlama). Bisa dikembangkan lebih lanjut untuk terhubung ke Firestore
  // / Realtime Database jika diperlukan.
  List<NotificationItem> get _dummyNotifications => [
        NotificationItem(
          title: 'Berita Baru Tersedia',
          subtitle: 'Ada update terbaru seputar eksplorasi luar angkasa.',
          icon: Icons.newspaper,
          time: 'Baru saja',
        ),
        NotificationItem(
          title: 'Artikel Favorit Diperbarui',
          subtitle: 'Salah satu artikel favoritmu mendapat update.',
          icon: Icons.favorite,
          time: '2 jam lalu',
        ),
        NotificationItem(
          title: 'Selamat Datang!',
          subtitle: 'Terima kasih telah bergabung dengan SpaceNews Core.',
          icon: Icons.celebration,
          time: '1 hari lalu',
        ),
      ];

  @override
  Widget build(BuildContext context) {
    final notifications = _dummyNotifications;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notification'),
        backgroundColor: const Color(0xFFF8BBD0),
        foregroundColor: const Color(0xFF880E4F),
        automaticallyImplyLeading: false,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: notifications.length,
        separatorBuilder: (context, index) => const Divider(),
        itemBuilder: (context, index) {
          final item = notifications[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundColor: const Color(0xFFFCE4EC),
              child: Icon(item.icon, color: const Color(0xFFEC407A)),
            ),
            title: Text(item.title, style: const TextStyle(fontWeight: FontWeight.w600)),
            subtitle: Text(item.subtitle),
            trailing: Text(
              item.time,
              style: TextStyle(fontSize: 11, color: Colors.grey.shade500),
            ),
          );
        },
      ),
    );
  }
}
