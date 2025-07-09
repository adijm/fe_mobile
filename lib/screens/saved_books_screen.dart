import 'package:flutter/material.dart';

class SavedBooksScreen extends StatelessWidget {
  const SavedBooksScreen({Key? key}) : super(key: key);

  // Data contoh buku
  final List<Map<String, String>> books = const [
    {
      'title': 'Rahasia Pelangi',
      'image': 'rahasia_pelangi.jpg',
    },
    {
      'title': 'Aku Belajar Akhlak',
      'image': 'akhlak.jpg',
    },
    {
      'title': 'Sapiens',
      'image': 'sapiens.jpg',
    },
    {
      'title': 'The Hobbit',
      'image': 'the_hobbit.jpg',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Saved Books'),
        centerTitle: true,
        backgroundColor: const Color(0xFFB3D7F3),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          itemCount: books.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Dua kolom
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 0.65,
          ),
          itemBuilder: (context, index) {
            return BookCard(
              title: books[index]['title']!,
              imagePath: books[index]['image']!,
            );
          },
        ),
      ),
    );
  }
}

class BookCard extends StatelessWidget {
  final String title;
  final String imagePath;

  const BookCard({
    Key? key,
    required this.title,
    required this.imagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.asset(
            imagePath,
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          top: 8,
          right: 8,
          child: Container(
            width: 20,
            height: 20,
            decoration: const BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(4),
                bottomLeft: Radius.circular(4),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
