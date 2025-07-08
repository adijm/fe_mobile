import 'package:flutter/material.dart';

class HelpSupportScreen extends StatelessWidget {
  const HelpSupportScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Help & Support'),
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
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            HelpOptionTile(
              title: 'How to Borrow a book',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const HelpDetailPage(
                      title: 'How to Borrow a book',
                      description:
                          'To borrow a book, go to the Library tab, tap on a book, and press the "Borrow" button. Make sure you’re logged in.',
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 12),
            HelpOptionTile(
              title: 'How to return a book',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const HelpDetailPage(
                      title: 'How to return a book',
                      description:
                          'To return a book, go to the Return tab. Tap the book you want to return and confirm the action.',
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 12),
            HelpOptionTile(
              title: 'How to mark a book as a favorite',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const HelpDetailPage(
                      title: 'How to mark a book as a favorite',
                      description:
                          'Open a book detail, then tap the heart icon to save it as your favorite.',
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class HelpOptionTile extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const HelpOptionTile({
    Key? key,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade400),
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        title: Text(title),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}

class HelpDetailPage extends StatelessWidget {
  final String title;
  final String description;

  const HelpDetailPage({
    Key? key,
    required this.title,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: const Color(0xFFB3D7F3),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Text(
          description,
          style: const TextStyle(fontSize: 16, height: 1.6),
        ),
      ),
    );
  }
}
