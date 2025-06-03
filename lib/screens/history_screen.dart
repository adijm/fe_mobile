import 'package:flutter/material.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  final List<Map<String, String>> histories = const [
    {
      'date': '04 Juni 2025, 09:31 AM',
      'message': 'Buku “Rahasia Pelangi” telah dikembalikan.',
    },
    {
      'date': '29 Mei 2025, 11:00 AM',
      'message': 'Buku “Rahasia Pelangi” telah diambil di perpustakaan Tenggat pengembalian : 5 Juni 2025.',
    },
    {
      'date': '26 Mei 2025, 08:07 AM',
      'message': 'Peminjaman buku “Rahasia Pelangi” disetujui oleh admin',
    },
    {
      'date': '24 Mei 2025, 04:30 PM',
      'message': 'Permintaan Peminjaman buku “Rahasia Pelangi” telah diajukan.',
    },
    {
      'date': '24 Mei 2025, 10:31 AM',
      'message': 'Pendaftaran akun berhasil. Selamat datang di perpustakaan !',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFCCE7FF),
      appBar: AppBar(
        backgroundColor: const Color(0xFFCCE7FF),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'History',
          style: TextStyle(color: Colors.black87),
        ),
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          itemCount: histories.length,
          separatorBuilder: (_, __) => const Divider(height: 28),
          itemBuilder: (context, index) {
            final item = histories[index];
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item['date']!,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  item['message']!,
                  style: const TextStyle(
                    fontSize: 15,
                    color: Colors.black87,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

