import 'package:flutter/material.dart';

class SavedBooksScreen extends StatelessWidget {
  const SavedBooksScreen({super.key});

  final List<Map<String, String>> books = const [
    {
      'title': 'Rahasia Pelangi',
      'image': 'assets/books/rahasia_pelangi.png',
    },
    {
      'title': 'Aku Belajar Akhlak',
      'image': 'assets/books/akhlak.png',
    },
    {
      'title': 'Sapiens',
      'image': 'assets/books/sapiens.png',
    },
    {
      'title': 'The Hobbit',
      'image': 'assets/books/hobbit.png',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[100],
      appBar: AppBar(
        backgroundColor: Colors.blue[100],
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Saved Books',
          style: TextStyle(color: Colors.black87),
        ),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(12),
        child: GridView.builder(
          itemCount: books.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.65,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          itemBuilder: (context, index) {
            return _buildBookCard(books[index]);
          },
        ),
      ),
    );
  }

  Widget _buildBookCard(Map<String, String> book) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4)],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                book['image']!,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              top: 8,
              right: 8,
              child: Container(
                width: 20,
                height: 24,
                decoration: const BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(4),
                    bottomLeft: Radius.circular(8),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
