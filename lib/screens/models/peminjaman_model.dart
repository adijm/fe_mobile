import 'book_model.dart';
import 'user_model.dart';
import 'staff_model.dart';

class PeminjamanModel {
  final int id;
  final int bukuId;
  final int userId;
  final String tanggalPeminjaman;
  final String tenggatWaktu;
  final int jumlah;
  final String status;
  final int? staffId; // bisa null
  final BookModel buku;
  final UserModel user;
  final StaffModel? staff; // bisa null

  PeminjamanModel({
    required this.id,
    required this.bukuId,
    required this.userId,
    required this.tanggalPeminjaman,
    required this.tenggatWaktu,
    required this.jumlah,
    required this.status,
    required this.staffId,
    required this.buku,
    required this.user,
    required this.staff,
  });

  factory PeminjamanModel.fromJson(Map<String, dynamic> json) {
    return PeminjamanModel(
      id: json['id'],
      bukuId: json['buku_id'] ?? 0,
      userId: json['user_id'] ?? 0,
      tanggalPeminjaman: json['tanggal_peminjaman'] ?? '',
      tenggatWaktu: json['tenggat_waktu'] ?? '',
      jumlah: json['jumlah'] ?? 1,
      status: json['status'] ?? '',
      staffId: json['staff_id'], // bisa null
      buku: BookModel.fromJson(json['buku']),
      user: UserModel.fromJson(json['user']),
      staff: json['staff'] != null ? StaffModel.fromJson(json['staff']) : null,
    );
  }
}
