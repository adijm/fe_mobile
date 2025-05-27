import 'package:flutter/material.dart';

class AccountScreen extends StatelessWidget {
  final String username;

  const AccountScreen({Key? key, required this.username}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[100],
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 24),

          // Judul "Account"
          const Text(
            'Account',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),

          const SizedBox(height: 16),

          // Avatar
          const CircleAvatar(
            radius: 40,
            backgroundImage: AssetImage('assets/account_profile.png'),
          ),

          const SizedBox(height: 8),

          // Username
          Text(
            '@$username',
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black87,
              fontWeight: FontWeight.w500,
            ),
          ),

          const SizedBox(height: 24),

          // Statistik
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStatCard(Icons.book, '2 Buku', 'Dipinjam'),
                _buildStatCard(Icons.check_circle, '1 Buku', 'Dikembalikan'),
                _buildStatCard(Icons.money_off, 'Rp 0', 'Denda'),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Menu
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
              ),
              child: ListView(
                padding: const EdgeInsets.symmetric(vertical: 12),
                children: const [
                  _AccountOption(icon: Icons.bookmark, label: 'Saved Books'),
                  _AccountOption(
                    icon: Icons.settings,
                    label: 'Account Setting',
                  ),
                  _AccountOption(icon: Icons.history, label: 'History'),
                  _AccountOption(icon: Icons.help, label: 'Help and Support'),
                  _AccountOption(icon: Icons.logout, label: 'Log Out'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(IconData icon, String count, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4)],
      ),
      child: Column(
        children: [
          Icon(icon, color: Colors.blue, size: 28),
          const SizedBox(height: 4),
          Text(
            count,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Text(label, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}

class _AccountOption extends StatelessWidget {
  final IconData icon;
  final String label;

  const _AccountOption({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: Colors.black54),
      title: Text(label, style: const TextStyle(color: Colors.black87)),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        size: 16,
        color: Colors.black38,
      ),
      onTap: () {
        // Tambah logika jika diperlukan
      },
    );
  }
}
