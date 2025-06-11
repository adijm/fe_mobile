import 'package:flutter/material.dart';

class ReturnScreen extends StatelessWidget {
  const ReturnScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('Return'),
        centerTitle: true,
        backgroundColor: const Color(0xFFB3D9F5), // Warna biru muda
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Gambar buku
            Container(
              width: 90,
              height: 130,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: const DecorationImage(
                  image: AssetImage('assets/images/rahasia_pelangi.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 16),
            // Detail teks
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Return Details',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF007041),
                    ),
                  ),
                  const SizedBox(height: 12),
                  detailText('Judul', 'Rahasia Pelangi'),
                  detailText('Penulis', 'Riawani Elyta & Shabrina Ws'),
                  iconTextRow(Icons.access_time, 'Periode Pinjam : 12 Hari'),
                  iconTextRow(Icons.date_range, 'Tanggal Pinjam : 24 Mei 2025'),
                  iconTextRow(Icons.calendar_today, 'Tanggal kembali : 5 Juni 2025'),
                  Row(
                    children: const [
                      Icon(Icons.circle, size: 12, color: Colors.orange),
                      SizedBox(width: 4),
                      Text(
                        'Status : Sedang Dipinjam',
                        style: TextStyle(fontSize: 13),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget detailText(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: RichText(
        text: TextSpan(
          style: const TextStyle(fontSize: 13, color: Colors.black),
          children: [
            TextSpan(
              text: '$label    ',
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
            TextSpan(text: value),
          ],
        ),
      ),
    );
  }

  Widget iconTextRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 14, color: Colors.grey[700]),
          const SizedBox(width: 4),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }
}
