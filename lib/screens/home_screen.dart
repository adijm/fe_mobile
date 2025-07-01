import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:forumapp/screens/models/book_model.dart';
import 'borrow_screen.dart';
import 'library_screen.dart';
import 'account_screen.dart';
import 'book_details_page.dart';
import 'return_kosong.dart';
import '../services/api_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.userName});
  final String userName;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  late List<Widget> _pages;

  final TextEditingController _searchController = TextEditingController();
  List<dynamic> _recommendedBooks = [];
  bool _isLoading = true;
  String _searchTerm = '';

  @override
  void initState() {
    super.initState();
    _loadRecommendedBooks();

    BookModel dummyBook = BookModel(
      id: 1,
      coverUrl: 'assets/the_hobbit.jpg',
      categoryId: 'Fantasi',
      title: 'The Hobbit',
      author: 'J.R.R. Tolkien',
      publicationYear: '1937',
      description: 'Petualangan Bilbo Baggins mencari harta naga Smaug.',
    );

    // Jangan assign _buildHomeContent() di sini
    _pages = [
      Container(), // placeholder dulu
      const LibraryScreen(),
      BorrowScreen(book: dummyBook),
      const ReturnScreen(),
      AccountScreen(username: widget.userName),
    ];
  }

  Future<void> _loadRecommendedBooks() async {
    try {
      final books = await ApiService.fetchBukuTerbaru();
      print("DATA BUKU YANG DITERIMA: ${books.map((b) => b.title).toList()}");

      setState(() {
        _recommendedBooks = books;
        _isLoading = false;
      });
    } catch (e) {
      print('Error fetching books: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child:
            _selectedIndex == 0
                ? _buildHomeContent() // <-- panggil ulang setiap kali build
                : _pages[_selectedIndex],
      ),
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

  Widget _buildHomeContent() {
    final filteredBooks =
        _recommendedBooks.where((book) {
          return book.title.toLowerCase().contains(_searchTerm.toLowerCase());
        }).toList();

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
                    ),
                  ),
                ],
              ),
              const Icon(CupertinoIcons.bell, size: 28, color: Colors.green),
            ],
          ),
          const SizedBox(height: 20),
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
                    onChanged: (value) {
                      setState(() {
                        _searchTerm = value;
                      });
                    },
                    decoration: const InputDecoration(
                      hintText: "Search for books",
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () => setState(() => _selectedIndex = 2),
                child: _buildStatCard("📚", "0 Buku", "Sedang dipinjam"),
              ),
              GestureDetector(
                onTap: () => setState(() => _selectedIndex = 2),
                child: _buildStatCardIcon(
                  Icons.check_circle,
                  Colors.blue,
                  "0 Buku",
                  "Sudah dikembalikan",
                ),
              ),
              GestureDetector(
                onTap: () => setState(() => _selectedIndex = 2),
                child: _buildStatCard("📖", "0", "Total pinjaman"),
              ),
            ],
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "RECOMMEND",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  letterSpacing: 1.2,
                ),
              ),
              GestureDetector(
                onTap: () => setState(() => _selectedIndex = 1),
                child: const Text(
                  "See all >",
                  style: TextStyle(color: Colors.green),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _isLoading
              ? const Center(child: CircularProgressIndicator())
              : filteredBooks.isEmpty
              ? const Text("Tidak ada buku yang cocok.")
              : Column(
                children:
                    filteredBooks
                        .map((book) => _buildBookCardFromAPI(book))
                        .toList(),
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

  static Widget _buildStatCardIcon(
    IconData icon,
    Color color,
    String value,
    String label,
  ) {
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

  Widget _buildBookCardFromAPI(dynamic book) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder:
                (_) => BookDetailsPage(
                  imagePath: book.coverUrl,
                  title: book.title,
                  author: book.author,
                  genre: book.publisher,
                  year: book.publicationYear,
                  description: book.description,
                ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
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
              child: Image.network(
                book.coverUrl,
                width: 70,
                height: 100,
                fit: BoxFit.cover,
                errorBuilder:
                    (context, error, stackTrace) => Container(
                      width: 70,
                      height: 100,
                      color: Colors.grey[300],
                      child: const Icon(Icons.broken_image),
                    ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    book.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    book.author,
                    style: const TextStyle(fontSize: 14, color: Colors.black54),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "📖 Penerbit: ${book.publisher}",
                    style: const TextStyle(fontSize: 13),
                  ),
                  Text(
                    "📅 Tahun Terbit: ${book.publicationYear}",
                    style: const TextStyle(fontSize: 13),
                  ),
                  const SizedBox(height: 8),
                  // Text("📖 Deskripsi:\n${book.description}, style: const TextStyle(fontSize: 13)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
