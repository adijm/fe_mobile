import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  final String userName;
  const HomeScreen({super.key, required this.userName});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();

  final List<Map<String, String>> _allBooks = [
    {
      'image': 'assets/the_hobbit.jpg',
      'title': 'The Hobbit',
      'author': 'J.R.R. Tolkien',
      'genre': 'Fantasi, Petualangan',
      'year': '1937',
      'description': 'Perjalanan seru Bilbo Baggins bersama para kurcaci untuk mencari kembali harta karun dari naga Smaug.',
    },
    {
      'image': 'assets/perahu_kertas.jpg',
      'title': 'Perahu Kertas',
      'author': 'Dee Lestari',
      'genre': 'Drama, Romansa',
      'year': '2009',
      'description': 'Mengisahkan kisah cinta remaja antara Kugy dan Keenan yang penuh lika-liku dan pencarian jati diri.',
    },
    {
      'image': 'assets/laskar_pelangi.jpg',
      'title': 'Laskar Pelangi',
      'author': 'Andrea Hirata',
      'genre': 'Drama, Inspiratif',
      'year': '2005',
      'description': 'Kisah inspiratif anak-anak desa Gantong yang penuh semangat untuk menuntut ilmu.',
    },
  ];

  String _searchTerm = '';

  @override
  Widget build(BuildContext context) {
    final filteredBooks = _allBooks.where((book) {
      return book['title']!.toLowerCase().contains(_searchTerm.toLowerCase());
    }).toList();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Hello,", style: TextStyle(fontSize: 20, color: Colors.grey[700])),
              Text(
                widget.userName,
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(30),
                ),
                child: TextField(
                  controller: _searchController,
                  onChanged: (value) {
                    setState(() {
                      _searchTerm = value;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: 'Search for books',
                    border: InputBorder.none,
                    suffixIcon: Icon(Icons.search, color: Colors.grey[600]),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  'assets/banner.png',
                  height: 150,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text("RECOMMEND", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  Text("See all >", style: TextStyle(color: Colors.grey)),
                ],
              ),
              const SizedBox(height: 16),
              ...filteredBooks.map((book) => _buildBookCard(book)).toList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBookCard(Map<String, String> book) {
    return Container(
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
            child: Image.asset(
              book['image']!,
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
                Text("${book['title']} -", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                Text(book['author']!, style: const TextStyle(fontSize: 14, color: Colors.black54)),
                const SizedBox(height: 8),
                Text("\u{1F4D6} Genre  : ${book['genre']}", style: const TextStyle(fontSize: 13)),
                Text("\u{1F4C5} Tahun Terbit : ${book['year']}", style: const TextStyle(fontSize: 13)),
                const SizedBox(height: 8),
                Text("\u{1F4D6} Deskripsi :\n${book['description']}", style: const TextStyle(fontSize: 13)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
