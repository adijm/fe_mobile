import 'package:flutter/material.dart';
import 'models/book_model.dart';
import 'borrow_screen.dart';
import '../services/api_service.dart';

class BookDetailsPage extends StatelessWidget {
  final BookModel book;

  const BookDetailsPage({super.key, required this.book});

  void _showBorrowDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false, // agar tidak bisa ditutup manual saat loading
      builder:
          (dialogContext) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            content: const Text(
              'Are you sure you want to borrow this book?',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(dialogContext).pop(),
                child: const Text(
                  "Cancel",
                  style: TextStyle(color: Colors.red),
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  Navigator.of(dialogContext).pop(); // Tutup dialog konfirmasi

                  // ✅ Tampilkan loading indicator
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder:
                        (_) => const Center(child: CircularProgressIndicator()),
                  );

                  try {
                    await ApiService.borrowBook(bukuId: book.id, jumlah: 1);

                    // ✅ Tutup loading
                    Navigator.of(context, rootNavigator: true).pop();

                    // ✅ Navigasi ke BorrowScreen
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (_) => const BorrowScreen()),
                    );
                  } catch (e) {
                    Navigator.of(
                      context,
                      rootNavigator: true,
                    ).pop(); // Tutup loading

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Gagal meminjam buku: $e")),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 20,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text("Yes, Borrow"),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            color: Colors.green,
            padding: const EdgeInsets.only(top: 40, left: 8),
            width: double.infinity,
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () => Navigator.pop(context),
                ),
                const Text(
                  "Book Details",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        book.coverUrl.isNotEmpty
                            ? book.coverUrl
                            : 'https://via.placeholder.com/150',
                        height: 220,
                        fit: BoxFit.cover,
                        errorBuilder:
                            (_, __, ___) =>
                                const Icon(Icons.broken_image, size: 80),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      book.title,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      book.author,
                      style: const TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      book.description,
                      textAlign: TextAlign.justify,
                      style: const TextStyle(fontSize: 14, height: 1.5),
                    ),
                    const SizedBox(height: 30),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () => _showBorrowDialog(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          "Borrow",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
