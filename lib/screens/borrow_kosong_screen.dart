import 'package:flutter/material.dart';
import 'package:forumapp/screens/models/peminjaman_model.dart';
import 'package:forumapp/screens/models/book_model.dart';
import '../services/api_service.dart';

class BorrowScreen extends StatefulWidget {
  const BorrowScreen({Key? key}) : super(key: key);

  @override
  State<BorrowScreen> createState() => _BorrowScreenState();
}

class _BorrowScreenState extends State<BorrowScreen> {
  bool isLoading = true;
  bool isError = false;
  String errorMessage = '';
  List<PeminjamanModel> daftarPeminjaman = [];

  @override
  void initState() {
    super.initState();
    _fetchPeminjaman();
  }

  Future<void> _fetchPeminjaman() async {
    try {
      final list = await ApiService.fetchUserPeminjaman();
      setState(() {
        daftarPeminjaman = list;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
        isError = true;
        errorMessage = e.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Borrow'),
        centerTitle: true,
        backgroundColor: const Color(0xFFB3D7F3),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body:
          isLoading
              ? const Center(child: CircularProgressIndicator())
              : isError
              ? Center(child: Text('Error: $errorMessage'))
              : daftarPeminjaman.isEmpty
              ? const EmptyBorrowState()
              : ListView.builder(
                itemCount: daftarPeminjaman.length,
                padding: const EdgeInsets.all(16),
                itemBuilder: (context, index) {
                  final item = daftarPeminjaman[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: BorrowBookCard(book: item.buku, status: item.status),
                  );
                },
              ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 2,
        selectedItemColor: const Color(0xFF4CAF50),
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.library_books),
            label: 'Library',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book_outlined),
            label: 'Borrow',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Account',
          ),
        ],
        onTap: (index) {
          // Tambahkan navigasi sesuai kebutuhan
        },
      ),
    );
  }
}

class EmptyBorrowState extends StatelessWidget {
  const EmptyBorrowState({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(Icons.menu_book_outlined, size: 60, color: Colors.grey),
          SizedBox(height: 20),
          Text(
            'Belum terdapat koleksi pinjaman',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          SizedBox(height: 10),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 40.0),
            child: Text(
              'Kesempatan Anda untuk dapat lakukan peminjaman, pinjam sekarang juga',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, color: Colors.black54),
            ),
          ),
        ],
      ),
    );
  }
}

class BorrowBookCard extends StatelessWidget {
  final BookModel book;
  final String status;

  const BorrowBookCard({Key? key, required this.book, required this.status})
    : super(key: key);

  Color _getStatusColor() {
    switch (status) {
      case "Disetujui":
        return Colors.green;
      case "Dikembalikan":
        return Colors.grey;
      default:
        return Colors.orange;
    }
  }

  IconData _getStatusIcon() {
    switch (status) {
      case "Disetujui":
        return Icons.check_circle_outline;
      case "Dikembalikan":
        return Icons.undo;
      default:
        return Icons.pending_actions;
    }
  }

  String _namaBulan(int bulan) {
    const namaBulan = [
      "",
      "Januari",
      "Februari",
      "Maret",
      "April",
      "Mei",
      "Juni",
      "Juli",
      "Agustus",
      "September",
      "Oktober",
      "November",
      "Desember",
    ];
    return namaBulan[bulan];
  }

  @override
  Widget build(BuildContext context) {
    final tanggalPinjam = DateTime.now();
    final tanggalFormatted =
        "${tanggalPinjam.day} ${_namaBulan(tanggalPinjam.month)} ${tanggalPinjam.year}";

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2)),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: Image.network(
              book.coverUrl,
              width: 80,
              height: 120,
              fit: BoxFit.cover,
              errorBuilder:
                  (context, error, stackTrace) => Container(
                    width: 80,
                    height: 120,
                    color: Colors.grey[300],
                    child: const Icon(Icons.broken_image),
                  ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Book Details',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: Colors.green,
                  ),
                ),
                const SizedBox(height: 12),
                _buildRow('Judul', book.title),
                _buildRow('Penulis', book.author),
                _buildRow('Penerbit', book.publisher),
                _buildRow('Tahun', book.publicationYear),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(
                      Icons.access_time_outlined,
                      size: 16,
                      color: Colors.grey,
                    ),
                    const SizedBox(width: 6),
                    const SizedBox(
                      width: 100,
                      child: Text(
                        'Tanggal Pinjam',
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                    Text(
                      ': $tanggalFormatted',
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Icon(_getStatusIcon(), size: 16, color: Colors.grey),
                    const SizedBox(width: 6),
                    const SizedBox(
                      width: 100,
                      child: Text('Status', style: TextStyle(fontSize: 14)),
                    ),
                    Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        color: _getStatusColor(),
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      status,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          SizedBox(
            width: 80,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
            ),
          ),
          Expanded(child: Text(value, style: const TextStyle(fontSize: 14))),
        ],
      ),
    );
  }
}
