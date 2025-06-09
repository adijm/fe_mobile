import 'package:flutter/material.dart';

class HelpSupportScreen extends StatelessWidget {
  const HelpSupportScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Help & Support'),
        centerTitle: true,
        backgroundColor: const Color(0xFFB3D7F3), // Warna biru muda seperti gambar
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
          children: const [
            HelpOptionTile(title: 'How to Borrow a book'),
            SizedBox(height: 12),
            HelpOptionTile(title: 'How to return a book'),
            SizedBox(height: 12),
            HelpOptionTile(title: 'How to mark a book as a favorite'),
          ],
        ),
      ),
    );
  }
}

class HelpOptionTile extends StatelessWidget {
  final String title;

  const HelpOptionTile({Key? key, required this.title}) : super(key: key);

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
        onTap: () {
          // Tambahkan logika navigasi ke detail bantuan di sini jika diperlukan
        },
      ),
    );
  }
}
