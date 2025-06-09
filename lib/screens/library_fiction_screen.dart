import 'package:flutter/material.dart';
import 'library_child_screen.dart';
import 'library_humanities_screen.dart';
import 'library_education_screen.dart';

class LibraryFictionScreen extends StatelessWidget {
  const LibraryFictionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> books = [
      {
        'image': 'assets/laskar_pelangi.png',
        'category': 'Fiksi Perjalanan Anak',
        'title': 'Laskar Pelangi',
        'author': 'Andrea Hirata',
      },
      {
        'image': 'assets/the_hobbit.jpg',
        'category': 'Fantasi Dunia Tengah',
        'title': 'The Hobbit',
        'author': 'J.R.R. Tolkien',
      },
      {
        'image': 'assets/rahasia_pelangi.jpg',
        'category': 'Fiksi anak',
        'title': 'Rahasia Pelangi',
        'author': 'Riawany Elita',
      },
      {
        'image': 'assets/perahu_kertas.jpg',
        'category': 'Fiksi dewasa',
        'title': 'Perahu Kertas',
        'author': 'Amelia',
      },
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFB4D9F8),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Text(
                'LIBRARY',
                style: TextStyle(
                  fontSize: 26,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            // Kategori Tab Navigasi
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildCategoryTab(context, 'Child'),
                  _buildCategoryTab(context, 'Humanities'),
                  _buildCategoryTab(context, 'Education'),
                  _buildCategoryTab(context, 'Fiction', isActive: true),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Daftar Buku
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                ),
                child: ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: books.length,
                  separatorBuilder: (_, __) => const Divider(height: 24),
                  itemBuilder: (context, index) {
                    final book = books[index];
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => BookDetailScreen(book: book),
                          ),
                        );
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.asset(
                              book['image']!,
                              width: 90,
                              height: 120,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  book['category']!,
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 13,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  book['title']!,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  book['author']!,
                                  style: const TextStyle(
                                    fontSize: 13,
                                    color: Colors.black87,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Icon(Icons.arrow_forward_ios,
                              size: 16, color: Colors.green),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          Navigator.pop(context);
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.library_books), label: 'Library'),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Borrow'),
          BottomNavigationBarItem(icon: Icon(Icons.assignment_turned_in), label: 'Return'),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle), label: 'Account'),
        ],
      ),
    );
  }

  Widget _buildCategoryTab(BuildContext context, String label, {bool isActive = false}) {
    return InkWell(
      onTap: () {
        Widget targetScreen;
        switch (label) {
          case 'Child':
            targetScreen = const LibraryChildScreen();
            break;
          case 'Humanities':
            targetScreen = const LibraryHumanitiesScreen();
            break;
          case 'Education':
            targetScreen = const LibraryEducationScreen();
            break;
          case 'Fiction':
          default:
            targetScreen = const LibraryFictionScreen();
        }

        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => targetScreen),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isActive ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isActive ? Colors.blue : Colors.black87,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

// Halaman detail buku sementara
class BookDetailScreen extends StatelessWidget {
  final Map<String, String> book;
  const BookDetailScreen({required this.book, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(book['title'] ?? 'Detail Buku')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Image.asset(book['image']!, height: 200),
            const SizedBox(height: 16),
            Text(
              book['title']!,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text('Penulis: ${book['author']}'),
            const SizedBox(height: 8),
            Text('Kategori: ${book['category']}'),
          ],
        ),
      ),
    );
  }
}
