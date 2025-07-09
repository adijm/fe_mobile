import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../screens/models/book_model.dart';
import 'book_details_page.dart';

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({super.key});

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  List<BookModel> _books = [];
  bool _loading = true;

  List<Map<String, dynamic>> _kategoriList = [];
  int? _selectedKategoriId;

  void _fetchKategori() async {
    try {
      final kategori = await ApiService.fetchKategoriBuku();
      if (!mounted) return;
      setState(() {
        _kategoriList = kategori;
        _selectedKategoriId = kategori.isNotEmpty ? kategori[0]['id'] : null;
      });

      if (_selectedKategoriId != null) {
        _fetchBooksByKategori(_selectedKategoriId!);
      }
    } catch (e) {
      print('Gagal memuat kategori: $e');
    }
  }

  void _fetchBooksByKategori(int kategoriId) async {
    try {
      final books = await ApiService.fetchBukuByKategori(kategoriId);
      if (!mounted) return;
      setState(() {
        _books = books;
        _loading = false;
        _selectedKategoriId = kategoriId;
      });
    } catch (e) {
      print('Gagal memuat buku kategori: $e');
    }
  }

  void _fetchBooks() async {
    try {
      final books = await ApiService.fetchBukuTerbaru();
      if (!mounted) return;
      setState(() {
        _books = books;
        _loading = false;
      });
    } catch (e) {
      print('Gagal memuat data: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchKategori();
  }

  List<BookModel> _filterBooks(List<BookModel> books) {
    final query = _searchQuery.toLowerCase();
    return books.where((book) {
      return book.title.toLowerCase().contains(query) ||
          book.author.toLowerCase().contains(query) ||
          book.categoryId.toLowerCase().contains(query);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final filteredBooks = _filterBooks(_books);

    return Scaffold(
      backgroundColor: const Color(0xFFB4D9F8),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
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

            // Kategori
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: _kategoriList.map((kategori) {
                    final isSelected = kategori['id'] == _selectedKategoriId;
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: GestureDetector(
                        onTap: () => _fetchBooksByKategori(kategori['id']),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: isSelected ? Colors.white : Colors.transparent,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            kategori['nama'],
                            style: TextStyle(
                              color: isSelected ? Colors.blue : Colors.black,
                              fontWeight:
                                  isSelected ? FontWeight.bold : FontWeight.normal,
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),

            // Search bar
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: TextField(
                  controller: _searchController,
                  onChanged: (value) {
                    setState(() {
                      _searchQuery = value;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: 'Search for books',
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 14,
                    ),
                    border: InputBorder.none,
                    suffixIcon: Icon(Icons.search, color: Colors.grey[600]),
                  ),
                ),
              ),
            ),

            // Daftar buku
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                ),
                child: _loading
                    ? const Center(child: CircularProgressIndicator())
                    : ListView.builder(
                        padding: const EdgeInsets.all(16),
                        itemCount: filteredBooks.length,
                        itemBuilder: (context, index) {
                          final book = filteredBooks[index];
                          final validCover = book.coverUrl.isNotEmpty;

                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => BookDetailsPage(book: book),
                                ),
                              );
                            },
                            child: Container(
                              margin: const EdgeInsets.only(bottom: 16),
                              decoration: BoxDecoration(
                                color: const Color(0xFFF7F4F5),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Row(
                                children: [
                                  // Cover buku
                                  Container(
                                    width: 100,
                                    height: 130,
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.horizontal(
                                        left: Radius.circular(16),
                                      ),
                                      image: validCover
                                          ? DecorationImage(
                                              image: NetworkImage(book.coverUrl),
                                              fit: BoxFit.cover,
                                            )
                                          : null,
                                      color: validCover ? null : Colors.grey[300],
                                    ),
                                    child: !validCover
                                        ? const Center(
                                            child: Icon(Icons.broken_image, size: 40),
                                          )
                                        : null,
                                  ),
                                  // Info buku
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            book.title,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            book.author,
                                            style: const TextStyle(color: Colors.grey),
                                          ),
                                          const SizedBox(height: 8),
                                          Text(
                                            "Stock: ${book.stock} copies",
                                            style: const TextStyle(
                                              fontSize: 12,
                                              color: Colors.black54,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
