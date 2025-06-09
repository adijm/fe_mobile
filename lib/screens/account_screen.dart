import 'package:flutter/material.dart';
import 'saved_books_screen.dart';
import 'account_setting_screen.dart';
import 'history_screen.dart';
import 'help_support_screen.dart';

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
          const Text(
            'Account',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 16),
          const CircleAvatar(
            radius: 40,
            backgroundImage: AssetImage('assets/account_profile.png'),
          ),
          const SizedBox(height: 8),
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
                _buildStatCard(
                  context,
                  icon: Icons.book,
                  count: '2 Buku',
                  label: 'Dipinjam',
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const HistoryScreen()));
                  },
                ),
                _buildStatCard(
                  context,
                  icon: Icons.check_circle,
                  count: '1 Buku',
                  label: 'Dikembalikan',
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const HistoryScreen()));
                  },
                ),
                _buildStatCard(
                  context,
                  icon: Icons.money_off,
                  count: 'Rp 0',
                  label: 'Denda',
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const HistoryScreen()));
                  },
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Menu list
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
              ),
              child: ListView(
                padding: const EdgeInsets.symmetric(vertical: 12),
                children: [
                  _AccountOption(
                    icon: Icons.bookmark,
                    label: 'Saved Books',
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => const SavedBooksScreen()));
                    },
                  ),
                  _AccountOption(
                    icon: Icons.settings,
                    label: 'Account Setting',
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => const AccountSettingScreen()));
                    },
                  ),
                  _AccountOption(
                    icon: Icons.history,
                    label: 'History',
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => const HistoryScreen()));
                    },
                  ),
                  _AccountOption(
                    icon: Icons.help,
                    label: 'Help and Support',
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => const HelpSupportScreen()));
                    },
                  ),
                  _AccountOption(
                    icon: Icons.logout,
                    label: 'Log Out',
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                            contentPadding: const EdgeInsets.fromLTRB(24, 24, 24, 8),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(Icons.logout, size: 48, color: Colors.red),
                                const SizedBox(height: 16),
                                const Text(
                                  "Are you sure you want to\nLog Out?",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                                ),
                                const SizedBox(height: 24),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.red,
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                      ),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                        Navigator.pushNamedAndRemoveUntil(
                                          context,
                                          '/login',
                                          (route) => false,
                                        );
                                      },
                                      child: const Text("Yes, Log Out", style: TextStyle(color: Colors.white)),
                                    ),
                                    TextButton(
                                      onPressed: () => Navigator.of(context).pop(),
                                      child: const Text("Cancel", style: TextStyle(color: Colors.grey)),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(
    BuildContext context, {
    required IconData icon,
    required String count,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
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
            Text(count, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Text(label, style: const TextStyle(fontSize: 12)),
          ],
        ),
      ),
    );
  }
}

class _AccountOption extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _AccountOption({required this.icon, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: Colors.black54),
      title: Text(label, style: const TextStyle(color: Colors.black87)),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.black38),
      onTap: onTap,
    );
  }
}
