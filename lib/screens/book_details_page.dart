import 'package:flutter/material.dart';
import 'models/book_model.dart';
import '../services/api_service.dart';  // import ApiService
import 'borrow_screen.dart';

class BookDetailsPage extends StatelessWidget {
  final Book book;
  final int currentUserId;   // harus tahu siapa user yang login

  const BookDetailsPage({
    super.key,
    required this.book,
    required this.currentUserId,  // dapatkan userId dari login
  });

  void _confirmBorrow(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Pinjam Buku"),
        content: const Text("Apakah kamu yakin ingin meminjam buku ini?"),
        actions: [
          TextButton(
            child: const Text("Batal"),
            onPressed: () => Navigator.pop(context),
          ),
          ElevatedButton(
            child: const Text("Ya, Pinjam"),
            onPressed: () {
              Navigator.pop(context);
              _borrowBook(context);
            },
          ),
        ],
      ),
    );
  }

  void _borrowBook(BuildContext context) async {
    // Contoh tenggat waktu (bisa diganti dengan datepicker)
    final tenggatWaktu = DateTime.now().add(const Duration(days: 7)).toIso8601String().split('T').first;

    final result = await ApiService.borrowBook(
      bukuId: book.id,
      userId: currentUserId,
      tenggatWaktu: tenggatWaktu,
    );

    if (result['success']) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Berhasil meminjam buku!")),
      );
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BorrowScreen(book: book),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Gagal meminjam buku: ${result['error']}")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Detail Buku")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Image.asset(book.image, height: 180),
            const SizedBox(height: 16),
            Text(book.title,
                style: const TextStyle(
                    fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text("Oleh ${book.author}",
                style: const TextStyle(color: Colors.grey)),
            const SizedBox(height: 16),
            Text(book.description),
            const Spacer(),
            ElevatedButton(
              onPressed: () => _confirmBorrow(context),
              child: const Text("Borrow"),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 48),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
