import 'package:flutter/material.dart';

class AccountSettingScreen extends StatefulWidget {
  const AccountSettingScreen({super.key});

  @override
  State<AccountSettingScreen> createState() => _AccountSettingScreenState();
}

class _AccountSettingScreenState extends State<AccountSettingScreen> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFCCE7FF),
      appBar: AppBar(
        backgroundColor: const Color(0xFFCCE7FF),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Account Setting',
          style: TextStyle(color: Colors.black87),
        ),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          children: [
            const SizedBox(height: 10),
            CircleAvatar(
              radius: 40,
              backgroundColor: Colors.grey[200],
              backgroundImage: const AssetImage('assets/images/account_profile.png'), // Ganti sesuai asetmu
            ),
            const SizedBox(height: 10),
            const Text(
              '@tania19',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 24),
            buildTextFieldLabel('Password'),
            buildTextField(_passwordController, 'Enter New Password'),
            const SizedBox(height: 16),
            buildTextFieldLabel('Email'),
            buildTextField(_emailController, 'Enter New Email'),
            const SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2196F3),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                elevation: 4,
              ),
              onPressed: () {
                // Tambahkan aksi perubahan
              },
              child: const Text('Change', style: TextStyle(fontSize: 16)),
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                // Tambahkan aksi hapus akun
              },
              child: const Text(
                'Delete account',
                style: TextStyle(color: Colors.red, fontSize: 14),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTextFieldLabel(String label) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        label,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget buildTextField(TextEditingController controller, String hint) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hint,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24),
        ),
      ),
    );
  }
}
