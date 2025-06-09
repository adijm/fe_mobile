import 'package:flutter/material.dart';
import 'library_fiction_screen.dart';
import 'library_humanities_screen.dart';
import 'library_education_screen.dart';
import 'book_details_page.dart';

class LibraryChildScreen extends StatelessWidget {
  const LibraryChildScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> books = [
      {
        'image': 'assets/dongeng_anak.png',
        'category': 'Seri Binatang',
        'title': 'Dongeng Anak Terlengkap',
        'author': 'Kak Thifa',
        'year': '2021',
        'description': 'Kumpulan dongeng anak dengan pesan moral yang baik dan ilustrasi menarik.'
      },
      {
        'image': 'assets/belajar_membaca.png',
        'category': 'Aktivitas anak pintar',
        'title': 'Belajar Membaca',
        'author': 'Amazing Kids',
        'year': '2020',
        'description': 'Buku edukatif untuk membantu anak belajar membaca secara menyenangkan.'
      },
      {
        'image': 'assets/berhitung.png',
        'category': 'Untuk anak usia 2-5 tahun',
        'title': 'Belajar Berhitung & mengenal angka',
        'author': 'Zahra, S.Pd.',
        'year': '2019',
        'description': 'Mengenalkan konsep angka dan berhitung dasar untuk anak usia dini.'
      },
      {
        'image': 'assets/akhlak.jpg',
        'category': 'Pendidikan Anak',
        'title': 'Akhlak',
        'author': 'Mutiara Sani',
        'year': '2022',
        'description': 'Buku pembelajaran akhlak untuk membentuk karakter positif pada anak.'
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

            // Kategori Navigasi
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildCategoryTab(context, 'Child', isActive: true),
                  _buildCategoryTab(context, 'Humanities'),
                  _buildCategoryTab(context, 'Education'),
                  _buildCategoryTab(context, 'Fiction'),
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

  // Widget untuk tab kategori dengan navigasi ke file yang sesuai
  Widget _buildCategoryTab(BuildContext context, String label, {bool isActive = false}) {
    return InkWell(
      onTap: () {
        Widget targetScreen;
        switch (label) {
          case 'Fiction':
            targetScreen = const LibraryFictionScreen();
            break;
          case 'Humanities':
            targetScreen = const LibraryHumanitiesScreen();
            break;
          case 'Education':
            targetScreen = const LibraryEducationScreen();
            break;
          default:
            targetScreen = const LibraryChildScreen(); // untuk "Child"
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
