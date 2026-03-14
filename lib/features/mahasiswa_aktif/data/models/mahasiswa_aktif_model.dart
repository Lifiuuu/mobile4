class MahasiswaAktifModel {
  final String nama;
  final String nim;
  final int status;

  MahasiswaAktifModel({required this.nama, required this.nim, required this.status});

  factory MahasiswaAktifModel.fromJson(Map<String, dynamic> json) {
    final nama = json['nama'] ?? json['title'] ?? json['name'] ?? '';
    final nim = (json['nim'] ?? json['id'])?.toString() ?? '';
    final status = json['status'] ?? json['userId'] ?? '';
    return MahasiswaAktifModel(nama: nama, nim: nim, status: status);
  }
}

