// 1. lib/features/mahasiswa/data/models/mahasiswa_model.dart
class MahasiswaModel {
  final String nama;
  final String nim;
  final String email;
  final String prodi;

  MahasiswaModel({required this.nama, required this.nim, required this.email, required this.prodi});

  factory MahasiswaModel.fromJson(Map<String, dynamic> json) {
    return MahasiswaModel(
      nama: json['nama'] ?? '',
      nim: json['nim'] ?? '',
      email: json['email'] ?? '',
      prodi: json['prodi'] ?? '',
    );
  }
}