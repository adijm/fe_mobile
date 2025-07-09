import 'package:flutter/material.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  final List<HistoryItem> historyItems = const [
    HistoryItem(
      dateTime: '04 Juni 2025, 09:31 AM',
      message: 'Buku “Rahasia Pelangi” telah dikembalikan.',
    ),
    HistoryItem(
      dateTime: '29 Mei 2025, 11:00 AM',
      message:
          'Buku “Rahasia Pelangi” telah diambil di perpustakaan Tenggat pengembalian : 5 Juni 2025.',
    ),
    HistoryItem(
      dateTime: '26 Mei 2025, 08:07 AM',
      message: 'Peminjaman buku “Rahasia Pelangi” disetujui oleh admin',
    ),
    HistoryItem(
      dateTime: '24 Mei 2025, 04:30 PM',
      message:
          'Permintaan Peminjaman buku “Rahasia Pelangi” telah diajukan.',
    ),
    HistoryItem(
      dateTime: '24 Mei 2025, 10:31 AM',
      message: 'Pendaftaran akun berhasil. Selamat datang di perpustakaan !',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('History'),
        centerTitle: true,
        backgroundColor: const Color(0xFFB3D7F3),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        elevation: 0,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: historyItems.length,
        separatorBuilder: (context, index) => const Divider(
          height: 32,
          thickness: 1,
          color: Color(0xFFDDDDDD),
        ),
        itemBuilder: (context, index) {
          final item = historyItems[index];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.dateTime,
                style: const TextStyle(
                  fontSize: 13,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                item.message,
                style: const TextStyle(
                  fontSize: 15.5,
                  color: Colors.black,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class HistoryItem {
  final String dateTime;
  final String message;

  const HistoryItem({
    required this.dateTime,
    required this.message,
  });
}
