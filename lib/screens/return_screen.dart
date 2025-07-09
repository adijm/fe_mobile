import 'package:flutter/material.dart';
import '../services/api_service.dart';

class ReturnScreen extends StatefulWidget {
  final Map<String, dynamic> peminjaman;

  const ReturnScreen({super.key, required this.peminjaman});

  @override
  State<ReturnScreen> createState() => _ReturnScreenState();
}

class _ReturnScreenState extends State<ReturnScreen> {
  int denda = 0;
  late String status;

  @override
  void initState() {
    super.initState();
    status = widget.peminjaman['status'] ?? 'dipinjam';
  }

  Future<void> _kembalikanBuku() async {
    final result = await ApiService.returnBook(widget.peminjaman['id']);
    if (result['success']) {
      setState(() {
        denda = result['denda'] ?? 0;
        status = result['status'] ?? 'dikembalikan';
      });

      showDialog(
        context: context,
        builder:
            (_) => AlertDialog(
              title: const Text('Berhasil'),
              content: Text(
                'Buku berhasil dikembalikan.\nDenda: Rp $denda',
                style: TextStyle(
                  color: denda > 0 ? Colors.red : Colors.green[800],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('OK'),
                ),
              ],
            ),
      );
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Gagal mengembalikan buku')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final peminjaman = widget.peminjaman;
    final judul = peminjaman['judul'] ?? 'Tanpa Judul';
    final penulis = peminjaman['penulis'] ?? 'Tidak diketahui';
    final tanggalPinjam = peminjaman['tanggal_pinjam'] ?? '-';
    final tenggat = peminjaman['tenggat'] ?? '-';
    final imageUrl = 'http://127.0.0.1:8000/storage/${peminjaman['cover']}';

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Return'),
        centerTitle: true,
        backgroundColor: const Color(0xFFB3D9F5),
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
                color: Colors.grey[200],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return const Center(child: Icon(Icons.image_not_supported));
                  },
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
                  detailText('Judul', judul),
                  detailText('Penulis', penulis),
                  iconTextRow(Icons.access_time, 'Periode Pinjam: -'),
                  iconTextRow(
                    Icons.date_range,
                    'Tanggal Pinjam: $tanggalPinjam',
                  ),
                  iconTextRow(Icons.calendar_today, 'Tenggat: $tenggat'),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      const Icon(Icons.circle, size: 12, color: Colors.orange),
                      const SizedBox(width: 4),
                      Text(
                        'Status: $status',
                        style: TextStyle(
                          fontSize: 13,
                          color:
                              status == 'terlambat'
                                  ? Colors.red
                                  : status == 'dikembalikan'
                                  ? Colors.green
                                  : Colors.orange,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  if (denda > 0)
                    Text(
                      'Denda: Rp $denda',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: _kembalikanBuku,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            padding: const EdgeInsets.symmetric(vertical: 16),
          ),
          child: const Text('Kembalikan Buku'),
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
          Expanded(child: Text(text, style: const TextStyle(fontSize: 13))),
        ],
      ),
    );
  }
}
