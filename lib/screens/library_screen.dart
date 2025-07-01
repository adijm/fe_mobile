import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../screens/models/book_model.dart';
import 'book_details_page.dart';
import 'library_child_screen.dart';
import 'library_education_screen.dart';
import 'library_fiction_screen.dart';
import 'library_humanities_screen.dart';

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

  @override
  void initState() {
    super.initState();
    _fetchBooks();
  }

  void _fetchBooks() async {
    try {
      final books = await ApiService.fetchBukuTerbaru();
      setState(() {
        _books = books; // karena books sudah berisi List<BookModel>
        _loading = false;
      });
    } catch (e) {
      print('Gagal memuat data: $e');
    }
  }

  List<BookModel> _filterBooks(List<BookModel> books) {
    final query = _searchQuery.toLowerCase();
    return books.where((book) {
      return book.title.toLowerCase().contains(query) ||
          book.author.toLowerCase().contains(query) ||
          book.categoryId.toString().toLowerCase().contains(query);
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
                  _buildCategoryTab(context, label: 'Child', destination: const LibraryChildScreen()),
                  _buildCategoryTab(context, label: 'Humanities', destination: LibraryHumanitiesScreen()),
                  _buildCategoryTab(context, label: 'Education', destination: LibraryEducationScreen()),
                  _buildCategoryTab(context, label: 'Fiction', destination: LibraryFictionScreen()),
                ],
              ),
            ),
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
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                    border: InputBorder.none,
                    suffixIcon: Icon(Icons.search, color: Colors.grey[600]),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                ),
                child: _loading
                    ? const Center(child: CircularProgressIndicator())
                    : ListView(
                        padding: const EdgeInsets.all(16),
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text('New Collection', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                              Icon(Icons.more_vert),
                            ],
                          ),
                          const SizedBox(height: 12),
                          _buildBookList(filteredBooks, isSimple: false),
                        ],
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryTab(BuildContext context, {required String label, required Widget destination}) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => destination));
      },
      child: Text(
        label,
        style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildBookList(List<BookModel> books, {required bool isSimple}) {
    return SizedBox(
      height: isSimple ? 200 : 240,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: books.length,
        itemBuilder: (context, index) {
          final book = books[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => BookDetailsPage(
                    imagePath: book.coverUrl ?? '',
                    title: book.title,
                    author: book.author,
                    genre: book.categoryId ?? '',
                    year: book.publicationYear ?? '',
                    description: book.description ?? '',
                  ),
                ),
              );
            },
            child: Container(
              width: 150,
              margin: const EdgeInsets.only(right: 16),
              decoration: BoxDecoration(
                color: isSimple ? Colors.grey[300] : const Color(0xFFF7F4F5),
                borderRadius: BorderRadius.circular(20),
                image: isSimple
                    ? DecorationImage(
                        image: NetworkImage(book.coverUrl ?? ''),
                        fit: BoxFit.cover,
                      )
                    : null,
              ),
              child: !isSimple
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 120,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                            image: DecorationImage(
                              image: NetworkImage(book.coverUrl ?? ''),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(book.categoryId ?? '', style: const TextStyle(fontSize: 12, color: Colors.grey)),
                              Text(
                                book.title,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                              ),
                              const SizedBox(height: 4),
                              const Text(
                                "Remaining: 12 copies",
                                style: TextStyle(fontSize: 11, color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  : null,
            ),
          );
        },
      ),
    );
  }
}
