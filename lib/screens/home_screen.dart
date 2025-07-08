import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:forumapp/screens/models/book_model.dart';
import 'borrow_screen.dart';
import 'library_screen.dart';
import 'account_screen.dart';
import 'book_details_page.dart';
import 'return_kosong.dart';
import 'notification_bottom_sheet.dart';

class HomeScreen extends StatefulWidget {
  final String userName;
  final int initialIndex;

  const HomeScreen({
    super.key,
    required this.userName,
    this.initialIndex = 0,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late int _selectedIndex;
  late List<Widget> _pages;

  TextEditingController _searchController = TextEditingController();
  String searchKeyword = '';
  List<Book> allBooks = [];
  List<Book> filteredBooks = [];

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;

    allBooks = [
      Book(
        id: 1,
        image: 'assets/the_hobbit.jpg',
        category: 'Fantasi',
        title: 'The Hobbit',
        author: 'J.R.R. Tolkien',
        description: 'Petualangan Bilbo Baggins bersama kurcaci mencari harta naga Smaug.',
      ),
      Book(
        id: 2,
        image: 'assets/perahu_kertas.jpg',
        category: 'Drama',
        title: 'Perahu Kertas',
        author: 'Dee Lestari',
        description: 'Kisah cinta remaja Kugy dan Keenan.',
      ),
      Book(
        id: 3,
        image: 'assets/habibie_ainun.jpg',
        category: 'Biografi',
        title: 'Habibie & Ainun',
        author: 'B.J. Habibie',
        description: 'Kisah cinta sejati Presiden ke-3 RI.',
      ),
      Book(
        id: 4,
        image: 'assets/planet_luna.jpg',
        category: 'Fantasi',
        title: 'Planet Luna',
        author: 'Ray Antariska Yasmin',
        description: 'Luna menemukan jati diri lewat dunia imajinasi.',
      ),
    ];

    filteredBooks = allBooks;

    _pages = [
      _buildHomeContent(),
      const LibraryScreen(),
      const BorrowScreen(book: null),
      const ReturnScreen(),
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
          BottomNavigationBarItem(icon: Icon(Icons.library_books), label: 'Library'),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Borrow'),
          BottomNavigationBarItem(icon: Icon(Icons.assignment_turned_in), label: 'Return'),
          BottomNavigationBarItem(icon: Icon(Icons.account_circle), label: 'Account'),
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
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Hello,", style: TextStyle(fontSize: 20, color: Colors.black87)),
                  Text(widget.userName, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                ],
              ),
              IconButton(
                icon: const Icon(CupertinoIcons.bell, size: 28, color: Colors.green),
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                    ),
                    builder: (_) => const NotificationBottomSheet(),
                  );
                },
              ),
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
              children: [
                const Icon(Icons.search, color: Colors.grey),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: const InputDecoration(
                      hintText: "Search for books",
                      border: InputBorder.none,
                    ),
                    onChanged: (value) {
                      setState(() {
                        searchKeyword = value.toLowerCase();
                        filteredBooks = allBooks.where((book) {
                          return book.title.toLowerCase().contains(searchKeyword);
                        }).toList();
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Stat Cards
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () => setState(() => _selectedIndex = 2),
                child: _buildStatCard("📚", "0 Buku", "Sedang dipinjam"),
              ),
              GestureDetector(
                onTap: () => setState(() => _selectedIndex = 2),
                child: _buildStatCardIcon(Icons.check_circle, Colors.blue, "0 Buku", "Sudah dikembalikan"),
              ),
              GestureDetector(
                onTap: () => setState(() => _selectedIndex = 2),
                child: _buildStatCard("📖", "0", "Total pinjaman"),
              ),
            ],
          ),
          const SizedBox(height: 30),

          // Recommend Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("RECOMMEND", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, letterSpacing: 1.2)),
              GestureDetector(
                onTap: () => setState(() => _selectedIndex = 1),
                child: const Text("See all >", style: TextStyle(color: Colors.green)),
              ),
            ],
          ),
          const SizedBox(height: 16),

          ...filteredBooks.map((book) => Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: _buildBookCard(
              imagePath: book.image,
              title: book.title,
              author: book.author,
              genre: book.category,
              year: 'Unknown',
              description: book.description,
            ),
          )),
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
          Text(value, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
          Text(label, textAlign: TextAlign.center, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }

  static Widget _buildStatCardIcon(IconData icon, Color color, String value, String label) {
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
          Icon(icon, size: 24, color: color),
          const SizedBox(height: 4),
          Text(value, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
          Text(label, textAlign: TextAlign.center, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildBookCard({
    required String imagePath,
    required String title,
    required String author,
    required String genre,
    required String year,
    required String description,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => BookDetailsPage(
              imagePath: imagePath,
              title: title,
              author: author,
              genre: genre,
              year: year,
              description: description,
            ),
          ),
        );
      },
      child: Container(
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
                  Text("$title -", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  Text(author, style: const TextStyle(fontSize: 14, color: Colors.black54)),
                  const SizedBox(height: 8),
                  Text("📖 Genre  : $genre", style: const TextStyle(fontSize: 13)),
                  Text("📅 Tahun Terbit : $year", style: const TextStyle(fontSize: 13)),
                  const SizedBox(height: 8),
                  Text("📖 Deskripsi :\n$description", style: const TextStyle(fontSize: 13)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
