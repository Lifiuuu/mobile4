class ProfileModel {
  final String nama;
  final String role;
  final String email;

  ProfileModel({
    required this.nama,
    required this.role,
    required this.email,
  });

  // Fungsi ini opsional untuk sekarang, tapi sangat berguna 
  // nanti kalau datanya mau diambil dari database atau API
  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      nama: json['nama'] ?? '',
      role: json['role'] ?? '',
      email: json['email'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nama': nama,
      'role': role,
      'email': email,
    };
  }
}