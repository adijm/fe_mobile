import 'package:flutter/material.dart';
import 'library_child_screen.dart';
import 'library_education_screen.dart';
import 'library_fiction_screen.dart';
import 'book_details_page.dart'; // ← tambahkan ini

class LibraryHumanitiesScreen extends StatelessWidget {
  const LibraryHumanitiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> books = [
      {
        'image': 'assets/social_contract.jpg',
        'category': 'Filsafat Politik',
        'title': 'The Social Contract',
        'author': 'Jean-Jacques Rousseau',
        'year': '1762',
        'description':
            'Karya klasik filsafat politik yang membahas hubungan antara individu dan negara serta konsep kontrak sosial.'
      },
      {
        'image': 'assets/orientalism_humanities.png',
        'category': 'Representasi Budaya',
        'title': 'Orientalism',
        'author': 'Edward W Said',
        'year': '1978',
        'description':
            'Buku penting dalam kajian post-kolonial yang mengkritik cara pandang Barat terhadap dunia Timur.'
      },
      {
        'image': 'assets/the_republic_human.png',
        'category': 'Noris Klasik',
        'title': 'The Republic',
        'author': 'Plato',
        'year': '380 SM',
        'description':
            'Dialog filsafat yang membahas keadilan, bentuk negara ideal, dan peran filsuf dalam pemerintahan.'
      },
      {
        'image': 'assets/sapiens.jpg',
        'category': 'Sejarah dan Peradaban',
        'title': 'Sapiens',
        'author': 'Yuval Noah Harari',
        'year': '2011',
        'description':
            'Sejarah ringkas umat manusia, dari zaman purba hingga era modern, dengan pendekatan interdisipliner.'
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
                  _buildCategoryTab(context, 'Humanities', isActive: true),
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

      // Bottom Navigation Bar
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
          case 'Education':
            targetScreen = const LibraryEducationScreen();
            break;
          case 'Fiction':
            targetScreen = const LibraryFictionScreen();
            break;
          case 'Humanities':
          default:
            targetScreen = const LibraryHumanitiesScreen();
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
