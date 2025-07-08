import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SavedBooksScreen extends StatefulWidget {
  const SavedBooksScreen({Key? key}) : super(key: key);

  @override
  State<SavedBooksScreen> createState() => _SavedBooksScreenState();
}

class _SavedBooksScreenState extends State<SavedBooksScreen> {
  List<Map<String, String>> savedBooks = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchSavedBooks();
  }

  Future<void> fetchSavedBooks() async {
    try {
      final response = await http.get(Uri.parse('https://yourdomain.com/api/saved_books'));

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);

        setState(() {
          savedBooks = data.map<Map<String, String>>((book) {
            return {
              'title': book['title'],
              'image': book['image'], // Pastikan field image tersedia
            };
          }).toList();
          isLoading = false;
        });
      } else {
        setState(() {
          savedBooks = [];
          isLoading = false;
        });
      }
    } catch (e) {
      print('Fetch error: $e');
      setState(() {
        savedBooks = [];
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Saved Books'),
        centerTitle: true,
        backgroundColor: const Color(0xFFB3D7F3),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        elevation: 0,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : savedBooks.isEmpty
              ? const Center(
                  child: Text(
                    'Belum ada buku yang disimpan.',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GridView.builder(
                    itemCount: savedBooks.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 0.7,
                    ),
                    itemBuilder: (context, index) {
                      return BookCard(
                        title: savedBooks[index]['title']!,
                        imagePath: 'assets/images/${savedBooks[index]['image']!}',
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
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(2, 2)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
            child: Image.asset(
              imagePath,
              height: 150,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                height: 150,
                color: Colors.grey[300],
                child: const Center(child: Icon(Icons.broken_image)),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
