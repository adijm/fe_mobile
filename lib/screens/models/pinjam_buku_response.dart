import 'peminjaman_model.dart';

class PinjamBukuResponse {
  final String status;
  final String message;
  final PeminjamanModel data;

  PinjamBukuResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory PinjamBukuResponse.fromJson(Map<String, dynamic> json) {
    return PinjamBukuResponse(
      status: json['status'],
      message: json['message'],
      data: PeminjamanModel.fromJson(json['data']),
    );
  }
}
