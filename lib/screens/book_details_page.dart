import 'package:flutter/material.dart';
import 'models/book_model.dart';
import 'borrow_screen.dart';

class BookDetailsPage extends StatelessWidget {
  final String imagePath;
  final String title;
  final String author;
  final String genre;
  final String year;
  final String description;

  const BookDetailsPage({
    Key? key,
    required this.imagePath,
    required this.title,
    required this.author,
    required this.genre,
    required this.year,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Buat objek Book dari detail yang ada
    final book = Book(
      id: 0, // Bisa disesuaikan kalau kamu punya ID unik
      image: imagePath,
      category: genre,
      title: title,
      author: author,
      description: description,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Cover image
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  imagePath,
                  width: 200,
                  height: 280,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Title
            Text(
              title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),

            // Author
            Text(
              'Author: $author',
              style: const TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 8),

            // Genre
            Text(
              'Genre: $genre',
              style: const TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 8),

            // Year
            Text(
              'Year Published: $year',
              style: const TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 24),

            // Description
            const Text(
              'Description:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 32),

            // Tombol Borrow
            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => BorrowScreen(book: book)),
                  );
                },
                icon: const Icon(Icons.book_online),
                label: const Text("Borrow"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
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
