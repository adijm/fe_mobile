import 'package:flutter/material.dart';
import 'models/book_model.dart';

class BorrowScreen extends StatelessWidget {
  final Book? book;
  final String status;

  const BorrowScreen({Key? key, required this.book, this.status = "Menunggu Persetujuan"}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: const Text('Borrow'),
        backgroundColor: const Color(0xFFB4D9F8),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
          color: Colors.blue,
        ),
      ),
      body: book == null
          ? const EmptyBorrowState()
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  BorrowBookCard(book: book!, status: status),
                  const SizedBox(height: 32),
                  const NotificationSection()
                ],
              ),
            ),
    );
  }
}

class EmptyBorrowState extends StatelessWidget {
  const EmptyBorrowState({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(
            Icons.menu_book_outlined,
            size: 72,
            color: Colors.grey,
          ),
          SizedBox(height: 24),
          Text(
            'Belum terdapat koleksi pinjaman',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              fontFamily: 'Serif',
            ),
          ),
          SizedBox(height: 12),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: Text(
              'Kesempatan Anda untuk dapat lakukan peminjaman, pinjam sekarang juga',
              style: TextStyle(
                fontSize: 14,
                color: Colors.black54,
                fontFamily: 'Serif',
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

class BorrowBookCard extends StatelessWidget {
  final Book book;
  final String status;
  const BorrowBookCard({Key? key, required this.book, required this.status}) : super(key: key);

  Color _getStatusColor() {
    switch (status) {
      case "Disetujui":
        return Colors.green;
      case "Dikembalikan":
        return Colors.grey;
      default:
        return Colors.orange;
    }
  }

  IconData _getStatusIcon() {
    switch (status) {
      case "Disetujui":
        return Icons.check_circle_outline;
      case "Dikembalikan":
        return Icons.undo;
      default:
        return Icons.pending_actions;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2)),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: Image.asset(
              book.image,
              width: 80,
              height: 120,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Book Details',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18, color: Colors.green),
                ),
                const SizedBox(height: 12),
                _buildRow('Judul', book.title),
                _buildRow('Penulis', book.author),
                _buildRow('Sisa', '12 Salinan'),
                const SizedBox(height: 8),
                Row(
                  children: const [
                    Icon(Icons.access_time_outlined, size: 16, color: Colors.grey),
                    SizedBox(width: 6),
                    SizedBox(width: 100, child: Text('Tanggal Pinjam', style: TextStyle(fontSize: 14))),
                    Text(': 24 Mei 2025', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                  ],
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Icon(_getStatusIcon(), size: 16, color: Colors.grey),
                    const SizedBox(width: 6),
                    const SizedBox(width: 100, child: Text('Status', style: TextStyle(fontSize: 14))),
                    Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(color: _getStatusColor(), shape: BoxShape.circle),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      status,
                      style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          SizedBox(width: 80, child: Text(label, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14))),
          Expanded(child: Text(value, style: const TextStyle(fontSize: 14))),
        ],
      ),
    );
  }
}

class NotificationSection extends StatelessWidget {
  const NotificationSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Hari ini', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 12),
        _buildNotification(
          icon: Icons.check_circle,
          color: Colors.green,
          title: 'Pengembalian Berhasil',
          message: 'Buku “Rahasia Pelangi” telah dikembalikan. Terima kasih telah menjaga buku dengan baik!',
          time: '04 Juni 2025, 09:31 AM',
        ),
        const Divider(height: 32),
        const Text('Minggu ini', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 12),
        _buildNotification(
          icon: Icons.menu_book,
          color: Colors.blue,
          title: 'Peminjaman Disetujui',
          message:
              'Permintaanmu untuk meminjam buku “Rahasia Pelangi” telah disetujui oleh admin. Silahkan ambil buku di perpustakaan dalam 3 hari ke depan',
          time: '26 Mei 2025, 08:07 AM',
        ),
        const SizedBox(height: 12),
        _buildNotification(
          icon: Icons.send,
          color: Colors.lightBlue,
          title: 'Permintaan Peminjaman dikirim',
          message:
              'kamu telah mengajukan permintaan peminjaman buku “Rahasia Pelangi”. Mohon tunggu persetujuan dari admin ya!',
          time: '24 Mei 2025, 04:30 PM',
        ),
        const SizedBox(height: 12),
        _buildNotification(
          icon: Icons.person,
          color: Colors.green,
          title: 'Pendaftaran Berhasil',
          message:
              'Selamat datang! Sekarang kamu sudah bisa menjelajahi koleksi buku dan melakukan peminjaman!',
          time: '24 Mei 2025, 10:31 AM',
        ),
      ],
    );
  }

  Widget _buildNotification({
    required IconData icon,
    required Color color,
    required String title,
    required String message,
    required String time,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 28, color: color),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
              const SizedBox(height: 4),
              Text(message, style: const TextStyle(fontSize: 13)),
              const SizedBox(height: 4),
              Text(time, style: const TextStyle(fontSize: 12, color: Colors.grey)),
            ],
          ),
        ),
      ],
    );
  }
}
