import 'package:flutter/material.dart';
import 'models/book_model.dart';
import '../services/api_service.dart';
import 'models/peminjaman_model.dart';

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
        isError = false;
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
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: const Text('Daftar Peminjaman Buku'),
        backgroundColor: const Color(0xFFB4D9F8),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
          color: Colors.blue,
        ),
      ),
      body:
          isLoading
              ? const Center(child: CircularProgressIndicator())
              : isError
              ? Center(child: Text('Gagal memuat data: $errorMessage'))
              : daftarPeminjaman.isEmpty
              ? const EmptyBorrowState()
              : ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: daftarPeminjaman.length,
                itemBuilder: (context, index) {
                  final item = daftarPeminjaman[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: BorrowBookCard(
                      book: item.buku,
                      status: item.status,
                      tanggalPinjam: item.tanggalPeminjaman,
                    ),
                  );
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
          Icon(Icons.menu_book_outlined, size: 72, color: Colors.grey),
          SizedBox(height: 24),
          Text(
            'Belum ada buku yang dipinjam',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              fontFamily: 'Serif',
            ),
          ),
          SizedBox(height: 12),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: Text(
              'Silakan pinjam buku dari halaman perpustakaan',
              style: TextStyle(
                fontSize: 14,
                color: Colors.black54,
                fontFamily: 'Serif',
              ),
              textAlign: TextAlign.center,
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
  final String tanggalPinjam;

  const BorrowBookCard({
    Key? key,
    required this.book,
    required this.status,
    required this.tanggalPinjam,
  }) : super(key: key);

  Color _getStatusColor() {
    switch (status.toLowerCase()) {
      case "disetujui":
        return Colors.green;
      case "dikembalikan":
        return Colors.grey;
      default:
        return Colors.orange;
    }
  }

  IconData _getStatusIcon() {
    switch (status.toLowerCase()) {
      case "disetujui":
        return Icons.check_circle_outline;
      case "dikembalikan":
        return Icons.undo;
      default:
        return Icons.pending_actions;
    }
  }

  String _formatTanggal(String rawDate) {
    try {
      final date = DateTime.parse(rawDate);
      return "${date.day} ${_namaBulan(date.month)} ${date.year}";
    } catch (_) {
      return rawDate;
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
    final tanggalFormatted = _formatTanggal(tanggalPinjam);

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
                  'Detail Buku',
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
                _buildIconRow(
                  Icons.access_time_outlined,
                  'Tanggal Pinjam',
                  tanggalFormatted,
                ),
                const SizedBox(height: 6),
                _buildStatusRow(),
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

  Widget _buildIconRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: 16, color: Colors.grey),
        const SizedBox(width: 6),
        SizedBox(
          width: 100,
          child: Text(label, style: const TextStyle(fontSize: 14)),
        ),
        Text(
          ': $value',
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
        ),
      ],
    );
  }

  Widget _buildStatusRow() {
    return Row(
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
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
        ),
      ],
    );
  }
}
