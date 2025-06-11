import 'package:flutter/material.dart';
import 'library_child_screen.dart';
import 'library_humanities_screen.dart';
import 'library_education_screen.dart';
import 'book_details_page.dart';

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
        'year': '2005',
        'description': 'Cerita inspiratif tentang perjuangan anak-anak di Belitung.'
      },
      {
        'image': 'assets/the_hobbit.jpg',
        'category': 'Fantasi Dunia Tengah',
        'title': 'The Hobbit',
        'author': 'J.R.R. Tolkien',
        'year': '1937',
        'description': 'Petualangan hobbit Bilbo Baggins di dunia Middle-earth.'
      },
      {
        'image': 'assets/rahasia_pelangi.jpg',
        'category': 'Fiksi anak',
        'title': 'Rahasia Pelangi',
        'author': 'Riawany Elita',
        'year': '2018',
        'description': 'Kisah persahabatan dan keajaiban pelangi.'
      },
      {
        'image': 'assets/perahu_kertas.jpg',
        'category': 'Fiksi dewasa',
        'title': 'Perahu Kertas',
        'author': 'Amelia',
        'year': '2009',
        'description': 'Cerita romantis tentang mimpi dan cinta anak muda.'
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
            // Tab Kategori
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
                            builder: (_) => BookDetailsPage(
                              imagePath: book['image']!,
                              title: book['title']!,
                              author: book['author']!,
                              genre: book['category']!,
                              year: book['year']!,
                              description: book['description']!,
                            ),
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
                          const Icon(
                            Icons.arrow_forward_ios,
                            size: 16,
                            color: Colors.green,
                          ),
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
          BottomNavigationBarItem(icon: Icon(Icons.library_books), label: 'Library'),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Borrow'),
          BottomNavigationBarItem(icon: Icon(Icons.assignment_turned_in), label: 'Return'),
          BottomNavigationBarItem(icon: Icon(Icons.account_circle), label: 'Account'),
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
        Navigator.pushReplacement(
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
