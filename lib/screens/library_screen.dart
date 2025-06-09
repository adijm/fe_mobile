import 'package:flutter/material.dart';
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

  final List<Map<String, String>> allBooks = [
    {
      "imagePath": "assets/akhlak.jpg",
      "title": "Aku Belajar Akhlak",
      "author": "Nurul Hidayah",
      "genre": "Child",
      "year": "2020",
      "description": "Buku ini mengenalkan akhlak mulia pada anak-anak melalui cerita dan ilustrasi menarik.",
    },
    {
      "imagePath": "assets/social_contract.jpg",
      "title": "The Social Contract",
      "author": "Jean-Jacques Rousseau",
      "genre": "Humanities",
      "year": "1762",
      "description": "Karya filsafat politik klasik yang membahas perjanjian sosial dan dasar-dasar kekuasaan yang sah.",
    },
    {
      "imagePath": "assets/informatika.jpg",
      "title": "Informatika",
      "author": "Tim Kemdikbud",
      "genre": "Education",
      "year": "2021",
      "description": "Buku pelajaran resmi untuk mengenalkan dasar-dasar informatika dan pemrograman.",
    },
    {
      "imagePath": "assets/the_hobbit.jpg",
      "title": "The Hobbit",
      "author": "J.R.R. Tolkien",
      "genre": "Fiction",
      "year": "1937",
      "description": "Petualangan Bilbo Baggins dalam dunia Middle-earth yang penuh keajaiban dan bahaya.",
    },
  ];

  final List<Map<String, String>> recentlyViewed = [
    {
      "imagePath": "assets/sapiens.jpg",
      "title": "Sapiens",
      "author": "Yuval Noah Harari",
      "genre": "Humanities",
      "year": "2011",
      "description": "Buku tentang sejarah manusia dari zaman purba hingga modern.",
    },
    {
      "imagePath": "assets/seni_teater.jpg",
      "title": "Seni Teater",
      "author": "Rendra",
      "genre": "Education",
      "year": "2005",
      "description": "Pengantar seni teater dari perspektif budaya Indonesia.",
    },
    {
      "imagePath": "assets/aku_bisa_berhitung.jpg",
      "title": "Aku Bisa Berhitung",
      "author": "Dwi Rahayu",
      "genre": "Child",
      "year": "2018",
      "description": "Belajar berhitung untuk anak usia dini dengan metode menyenangkan.",
    },
    {
      "imagePath": "assets/perahu_kertas.jpg",
      "title": "Perahu Kertas",
      "author": "Dewi Lestari",
      "genre": "Fiction",
      "year": "2009",
      "description": "Kisah cinta dan pencarian jati diri remaja Indonesia.",
    },
  ];

  List<Map<String, String>> _filterBooks(List<Map<String, String>> books) {
    return books.where((book) {
      final lowerQuery = _searchQuery.toLowerCase();
      return book['title']!.toLowerCase().contains(lowerQuery) ||
          book['author']!.toLowerCase().contains(lowerQuery) ||
          book['genre']!.toLowerCase().contains(lowerQuery);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final filteredNewCollection = _filterBooks(allBooks);
    final filteredRecentBooks = _filterBooks(recentlyViewed);

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
                child: ListView(
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
                    _buildBookList(filteredNewCollection, isSimple: false),
                    const SizedBox(height: 24),
                    const Text(
                      'Recently Viewed',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    const SizedBox(height: 12),
                    _buildBookList(filteredRecentBooks, isSimple: true),
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

  Widget _buildBookList(List<Map<String, String>> books, {required bool isSimple}) {
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
                    imagePath: book['imagePath']!,
                    title: book['title']!,
                    author: book['author']!,
                    genre: book['genre']!,
                    year: book['year']!,
                    description: book['description']!,
                  ),
                ),
              );
            },
            child: Container(
              width: 150,
              margin: const EdgeInsets.only(right: 16),
              decoration: BoxDecoration(
                color: isSimple ? Colors.grey[300] : const Color.fromARGB(255, 247, 244, 245),
                borderRadius: BorderRadius.circular(20),
                image: isSimple
                    ? DecorationImage(
                        image: AssetImage(book['imagePath']!),
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
                              image: AssetImage(book['imagePath']!),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(book['genre']!, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                              Text(
                                book['title']!,
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
