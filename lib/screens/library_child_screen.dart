import 'package:flutter/material.dart';

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
      },
      {
        'image': 'assets/belajar_membaca.png',
        'category': 'Aktivitas anak pintar',
        'title': 'Belajar Membaca',
        'author': 'Amazing Kids',
      },
      {
        'image': 'assets/berhitung.png',
        'category': 'Untuk anak usia 2-5 tahun',
        'title': 'Belajar Berhitung & mengenal angka',
        'author': 'Zahra, S.Pd.',
      },
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFB4D9F8),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header "LIBRARY"
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
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Gambar Buku
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

                        // Info Buku
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

                        // Panah kanan
                        const Icon(
                          Icons.arrow_forward_ios,
                          size: 16,
                          color: Colors.green,
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),

      // Bottom navigation bar tetap tampil
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1, // index 1 = Library
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          // Navigasi ke halaman lain jika perlu
          Navigator.pop(context); // balik ke halaman utama kalau ditekan lagi
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

  // Widget untuk tab kategori
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
