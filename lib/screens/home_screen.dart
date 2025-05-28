import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:forumapp/screens/models/book_model.dart';
import 'borrow_screen.dart';
import 'library_screen.dart';
import 'account_screen.dart';

class HomeScreen extends StatefulWidget {
  final String userName;

  const HomeScreen({Key? key, required this.userName}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  late List<Widget> _pages;

@override
void initState() {
  super.initState();

  // Dummy Book untuk testing
  Book dummyBook = Book(
    id: 1,
    image: 'assets/the_hobbit.jpg',
    category: 'Fantasi',
    title: 'The Hobbit',
    author: 'J.R.R. Tolkien',
    description: 'Petualangan Bilbo Baggins mencari harta naga Smaug.',
  );

  _pages = [
    _buildHomeContent(),
    const LibraryScreen(),
    BorrowScreen(book: dummyBook), // ✅ sudah benar
    AccountScreen(username: widget.userName),
  ];
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(child: _pages[_selectedIndex]),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
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

  Widget _buildHomeContent() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Greeting and Notification Icon
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Hello,",
                    style: TextStyle(fontSize: 20, color: Colors.black87),
                  ),
                  Text(
                    widget.userName,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              const Icon(CupertinoIcons.bell, size: 28, color: Colors.green),
            ],
          ),
          const SizedBox(height: 20),

          // Search Bar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(30),
            ),
            child: Row(
              children: const [
                Icon(Icons.search, color: Colors.grey),
                SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Search for books",
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Book Summary Cards
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildStatCard("📚", "0 Buku", "Sedang dipinjam"),
              _buildStatCard("✅", "0 Buku", "Sudah dikembalikan"),
              _buildStatCard("📖", "0", "Total pinjaman"),
            ],
          ),
          const SizedBox(height: 30),

          // Recommend Section
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                "RECOMMEND",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  letterSpacing: 1.2,
                ),
              ),
              Text("See all >", style: TextStyle(color: Colors.green)),
            ],
          ),
          const SizedBox(height: 16),

          _buildBookCard(
            imagePath: 'assets/the_hobbit.jpg',
            title: 'The Hobbit',
            author: 'J.R.R. Tolkien',
            genre: 'Fantasi, Petualangan',
            year: '1937',
            description:
                'Petualangan Bilbo Baggins bersama kurcaci mencari harta naga Smaug.',
          ),
          const SizedBox(height: 16),
          _buildBookCard(
            imagePath: 'assets/perahu_kertas.jpg',
            title: 'Perahu Kertas',
            author: 'Dee Lestari',
            genre: 'Drama, Romansa',
            year: '2009',
            description: 'Kisah cinta remaja Kugy dan Keenan.',
          ),
          const SizedBox(height: 16),
          _buildBookCard(
            imagePath: 'assets/habibie_ainun.jpg',
            title: 'Habibie & Ainun',
            author: 'B.J. Habibie',
            genre: 'Biografi, Romansa',
            year: '2010',
            description: 'Kisah cinta sejati Presiden ke-3 RI.',
          ),
          const SizedBox(height: 16),
          _buildBookCard(
            imagePath: 'assets/planet_luna.jpg',
            title: 'Planet Luna',
            author: 'Ray Antariska Yasmin',
            genre: 'Fantasi, Remaja',
            year: '2021',
            description: 'Luna menemukan jati diri lewat dunia imajinasi.',
          ),
        ],
      ),
    );
  }

  static Widget _buildStatCard(String emoji, String value, String label) {
    return Container(
      width: 100,
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F7FA),
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(1, 2)),
        ],
      ),
      child: Column(
        children: [
          Text(emoji, style: const TextStyle(fontSize: 24)),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }

  static Widget _buildBookCard({
    required String imagePath,
    required String title,
    required String author,
    required String genre,
    required String year,
    required String description,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey[300]!),
      ),
      padding: const EdgeInsets.all(12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              imagePath,
              width: 70,
              height: 100,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "$title -",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  author,
                  style: const TextStyle(fontSize: 14, color: Colors.black54),
                ),
                const SizedBox(height: 8),
                Text(
                  "📖 Genre  : $genre",
                  style: const TextStyle(fontSize: 13),
                ),
                Text(
                  "📅 Tahun Terbit : $year",
                  style: const TextStyle(fontSize: 13),
                ),
                const SizedBox(height: 8),
                Text(
                  "📖 Deskripsi :\n$description",
                  style: const TextStyle(fontSize: 13),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
