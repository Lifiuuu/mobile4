// 1. lib/features/mahasiswa/data/models/mahasiswa_model.dart
class MahasiswaModel {
  final String nama;
  final String nim;
  final String email;

  MahasiswaModel({required this.nama, required this.nim, required this.email});

  factory MahasiswaModel.fromJson(Map<String, dynamic> json) {
    
    // Support both the app's original keys and jsonplaceholder keys
    final nama = json['nama'] ?? json['name'] ?? '';
    final nim = (json['nim'] ?? json['id'] ?? json['postId'])?.toString() ?? '';
    final email = json['email'] ?? 'email';

    return MahasiswaModel(
      nama: nama,
      nim: nim,
      email: email,
    );
  }
}