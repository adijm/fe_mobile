import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ));
    _loadRecommendedBooks();
    _pages = [
      Container(),
      const LibraryScreen(),
      BorrowScreen(),
      const ReturnScreen(),
      AccountScreen(username: widget.userName),
    ];
  }

  Future<void> _loadRecommendedBooks() async {
    try {
      final books = await ApiService.fetchBukuTerbaru();
      setState(() {
        _recommendedBooks = books;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Ganti background jadi gradient lembut
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFB4D9F8), Color(0xFFFFFFFF)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child:
              _selectedIndex == 0 ? _buildHomeContent() : _pages[_selectedIndex],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        onTap: (i) => setState(() => _selectedIndex = i),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.library_books), label: 'Library'),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Borrow'),
          BottomNavigationBarItem(
              icon: Icon(Icons.assignment_turned_in), label: 'Return'),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle), label: 'Account'),
        ],
      ),
    );
  }

  Widget _buildHomeContent() {
    final filteredBooks = _recommendedBooks.where((book) {
      return book.title.toLowerCase().contains(_searchTerm.toLowerCase());
    }).toList();

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        // Greeting dengan stylized card
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.9),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 6,
                  offset: const Offset(0, 2)),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                const Text("Hello,",
                    style: TextStyle(fontSize: 20, color: Colors.black54)),
                Text(widget.userName,
                    style: const TextStyle(
                        fontSize: 22, fontWeight: FontWeight.bold)),
              ]),
              Container(
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child:
                      Icon(CupertinoIcons.bell, size: 28, color: Colors.green),
                ),
              )
            ],
          ),
        ),
        const SizedBox(height: 20),

        // Search bar dengan elevasi
        Material(
          elevation: 4,
          borderRadius: BorderRadius.circular(30),
          child: Container(
            height: 50,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration:
                BoxDecoration(borderRadius: BorderRadius.circular(30)),
            child: Row(children: [
              const Icon(Icons.search, color: Colors.grey),
              const SizedBox(width: 8),
              Expanded(
                child: TextField(
                  controller: _searchController,
                  onChanged: (v) => setState(() => _searchTerm = v),
                  decoration: const InputDecoration(
                      hintText: "Search for books", border: InputBorder.none),
                ),
              )
            ]),
          ),
        ),
        const SizedBox(height: 20),

        // Stat cards dengan icon besar
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildStatCardFancy(
                icon: Icons.book,
                label: "Sedang Dipinjam",
                value: "0",
                bgColor: Colors.green),
            _buildStatCardFancy(
                icon: Icons.check_circle_outline,
                label: "Sudah Dikembalikan",
                value: "0",
                bgColor: Colors.blue),
            _buildStatCardFancy(
                icon: Icons.history,
                label: "Total Pinjaman",
                value: "0",
                bgColor: Colors.orange),
          ],
        ),
        const SizedBox(height: 30),

        // Section NEW BOOKS
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("NEW BOOKS",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    letterSpacing: 1.2,
                    color: Colors.black87)),
            GestureDetector(
              onTap: () => setState(() => _selectedIndex = 1),
              child: const Text("See all >",
                  style: TextStyle(
                      color: Colors.green, fontWeight: FontWeight.w500)),
            )
          ],
        ),
        const SizedBox(height: 16),

        // Daftar buku vertikal
        _isLoading
            ? const Center(child: CircularProgressIndicator())
            : filteredBooks.isEmpty
                ? const Text("Tidak ada buku terbaru.",
                    style: TextStyle(color: Colors.black54))
                : ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: filteredBooks.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (ctx, i) =>
                        _buildVerticalBookCard(filteredBooks[i]),
                  ),
      ]),
    );
  }

  Widget _buildStatCardFancy({
    required IconData icon,
    required String label,
    required String value,
    required Color bgColor,
  }) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: bgColor.withOpacity(0.2),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Icon(icon, size: 30, color: bgColor),
          const SizedBox(height: 8),
          Text(value,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: bgColor)),
          const SizedBox(height: 4),
          Text(label,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 12, color: Colors.black54)),
        ]),
      ),
    );
  }

  Widget _buildVerticalBookCard(dynamic book) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => BookDetailsPage(book: book)));
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 4,
                offset: const Offset(0, 2))
          ],
        ),
        child: Row(children: [
          ClipRRect(
            borderRadius:
                const BorderRadius.horizontal(left: Radius.circular(12)),
            child: Image.network(book.coverUrl,
                width: 70,
                height: 100,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                      width: 70,
                      height: 100,
                      color: Colors.grey[300],
                      child: const Icon(Icons.broken_image),
                    )),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(book.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: Colors.black87)),
                    const SizedBox(height: 4),
                    Text(book.author,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontSize: 12, color: Colors.black54)),
                  ]),
            ),
          )
        ]),
      ),
    );
  }
}
