import 'package:flutter/material.dart';
import 'models/book_model.dart';
import '../services/api_service.dart';

class BorrowScreen extends StatelessWidget {
  final Book book;

  const BorrowScreen({Key? key, required this.book}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Borrow'),
        backgroundColor: const Color.fromARGB(255, 180, 217, 248),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: BorrowBookCard(book: book),
      ),
    );
  }
}

class BorrowBookCard extends StatelessWidget {
  final Book book;
  const BorrowBookCard({Key? key, required this.book}) : super(key: key);

  static const red500 = Color(0xFFEF4444);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2)),
        ],
      ),
      padding: const EdgeInsets.all(16),
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
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                ),
                const SizedBox(height: 12),
                _buildDetailRow('Title', book.title),
                _buildDetailRow('Authors', book.author),
                _buildDetailRow(
                  'Remaining',
                  '12 available',
                ), // optional: backend later
                const SizedBox(height: 8),
                Row(
                  children: const [
                    Icon(
                      Icons.access_time_outlined,
                      size: 16,
                      color: Colors.grey,
                    ),
                    SizedBox(width: 6),
                    SizedBox(
                      width: 100,
                      child: Text(
                        'Borrow Period',
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                    Text(
                      ': 24 Mei 2025',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    const Icon(
                      Icons.info_outline,
                      size: 16,
                      color: Colors.grey,
                    ),
                    const SizedBox(width: 6),
                    const SizedBox(
                      width: 100,
                      child: Text('Status', style: TextStyle(fontSize: 14)),
                    ),
                    Container(
                      width: 10,
                      height: 10,
                      decoration: const BoxDecoration(
                        color: red500,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 6),
                    const Text(
                      'Pending Approval',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
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

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}
