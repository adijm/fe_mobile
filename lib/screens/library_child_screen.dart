import 'package:flutter/material.dart';
import 'book_details_page.dart';
import 'models/book_model.dart';

class LibraryChildScreen extends StatelessWidget {
  const LibraryChildScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Book> books = [
      Book(
        id: 1,
        image: 'assets/dongeng_anak.png',
        category: 'Seri Binatang',
        title: 'Dongeng Anak Terlengkap',
        author: 'Kak Thifa',
        description: 'Buku dongeng menarik dengan pesan moral untuk anak-anak.',
      ),
      Book(
        id: 2,
        image: 'assets/belajar_membaca.png',
        category: 'Aktivitas anak pintar',
        title: 'Belajar Membaca',
        author: 'Amazing Kids',
        description:
            'Membantu anak-anak belajar membaca dengan cara menyenangkan.',
      ),
      Book(
        id: 3,
        image: 'assets/berhitung.png',
        category: 'Untuk anak usia 2-5 tahun',
        title: 'Belajar Berhitung & mengenal angka',
        author: 'Zahra, S.Pd.',
        description:
            'Kenalkan angka dan hitungan dasar dengan ilustrasi menarik.',
      ),
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
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                        builder: (context) => BookDetailsPage(
                          book: book,
                          currentUserId: 1, // GANTI dengan ID user yang login
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
                              book.image,
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
                                  book.category,
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 13,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  book.title,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  book.author,
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
          BottomNavigationBarItem(
            icon: Icon(Icons.library_books),
            label: 'Library',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Borrow'),
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
    return Container(
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
    );
  }
}
