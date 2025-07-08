import 'package:flutter/material.dart';
import 'library_child_screen.dart';
import 'library_humanities_screen.dart';
import 'library_fiction_screen.dart';
<<<<<<< HEAD
import 'home_screen.dart';
import 'book_details_page.dart'; 
=======
import 'book_details_page.dart';

>>>>>>> 153ef05725aa6a57bb07fa47fc7814b26d97626f
class LibraryEducationScreen extends StatelessWidget {
  const LibraryEducationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> books = [
      {
        'image': 'assets/informatika.jpg',
        'category': 'Teknologi Pendidikan',
        'title': 'Informatika',
        'author': 'Kemendikbud',
        'year': '2023',
        'description':
            'Buku ajar informatika dari Kemendikbud untuk pelajar tingkat dasar hingga menengah.',
      },
      {
        'image': 'assets/belajar_membaca.png',
        'category': 'Aktivitas Literasi Anak',
        'title': 'Belajar Membaca',
        'author': 'Amazing Kids',
        'year': '2021',
        'description':
            'Buku edukatif untuk meningkatkan kemampuan membaca anak-anak dengan metode menyenangkan.',
      },
      {
        'image': 'assets/berhitung.png',
        'category': 'Numerasi Anak',
        'title': 'Belajar Berhitung & mengenal angka',
        'author': 'Zahra, S.Pd.',
        'year': '2020',
        'description':
            'Mengenalkan angka dan logika berhitung dasar untuk anak-anak prasekolah.',
      },
      {
        'image': 'assets/kebersamaan_education.png',
        'category': 'Buku Tematik Terpadu',
        'title': 'Kebersamaan',
        'author': 'Kemendikbud',
        'year': '2022',
        'description':
            'Buku tematik SD yang mengajarkan nilai-nilai kebersamaan dan gotong royong.',
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
<<<<<<< HEAD
=======

            // Kategori Navigasi
>>>>>>> 153ef05725aa6a57bb07fa47fc7814b26d97626f
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildCategoryTab(context, 'Child'),
                  _buildCategoryTab(context, 'Humanities'),
                  _buildCategoryTab(context, 'Education', isActive: true),
                  _buildCategoryTab(context, 'Fiction'),
                ],
              ),
            ),
            const SizedBox(height: 16),
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
<<<<<<< HEAD
                            builder:
                                (_) => BookDetailsPage(
                                  imagePath: book['image']!,
                                  title: book['title']!,
                                  author: book['author']!,
                                  genre: book['category']!,
                                  year: book['year']!,
                                  description: book['description']!,
                                ),
=======
                            builder: (_) => BookDetailsPage(
                              imagePath: book['image']!,
                              title: book['title']!,
                              author: book['author']!,
                              genre: book['category']!,
                              year: '',           // kosong karena tidak ada datanya
                              description: '',    // kosong karena tidak ada datanya
                            ),
>>>>>>> 153ef05725aa6a57bb07fa47fc7814b26d97626f
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
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  width: 90,
                                  height: 120,
                                  color: Colors.grey.shade300,
                                  child: const Icon(Icons.broken_image, size: 40, color: Colors.grey),
                                );
                              },
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
<<<<<<< HEAD
=======

>>>>>>> 153ef05725aa6a57bb07fa47fc7814b26d97626f
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder:
                  (_) => HomeScreen(
                    userName:
                        'Guest', // Ganti nanti pakai user login jika tersedia
                    initialIndex: index,
                  ),
            ),
            (route) => false,
          );
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.library_books),
            label: 'Library',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Borrow'),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment_turned_in),
            label: 'Return',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Account',
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryTab(
    BuildContext context,
    String label, {
    bool isActive = false,
  }) {
    Widget targetScreen;
    switch (label) {
      case 'Child':
        targetScreen = const LibraryChildScreen();
        break;
      case 'Humanities':
        targetScreen = const LibraryHumanitiesScreen();
        break;
      case 'Fiction':
        targetScreen = const LibraryFictionScreen();
        break;
      case 'Education':
      default:
        targetScreen = const LibraryEducationScreen();
    }

    return InkWell(
      onTap: () {
<<<<<<< HEAD
=======
        Widget targetScreen;
        switch (label) {
          case 'Child':
            targetScreen = const LibraryChildScreen();
            break;
          case 'Humanities':
            targetScreen = const LibraryHumanitiesScreen();
            break;
          case 'Fiction':
            targetScreen = const LibraryFictionScreen();
            break;
          case 'Education':
          default:
            targetScreen = const LibraryEducationScreen();
        }

>>>>>>> 153ef05725aa6a57bb07fa47fc7814b26d97626f
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
