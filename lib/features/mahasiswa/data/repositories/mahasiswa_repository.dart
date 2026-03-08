import 'package:mobile4/features/mahasiswa/data/models/mahasiswa_model.dart';

class MahasiswaRepository {
  Future<List<MahasiswaModel>> getMahasiswaList() async {
    await Future.delayed(const Duration(seconds: 1));
    return [
      MahasiswaModel(nama: 'Andi Setiawan', nim: '1520001', email: 'andi@example.com', prodi: 'D4 Teknik Informatika'),
      MahasiswaModel(nama: 'Budi Raharjo', nim: '1520002', email: 'budi@example.com', prodi: 'D4 Teknik Informatika'),
      MahasiswaModel(nama: 'Citra Kirana', nim: '1520003', email: 'citra@example.com', prodi: 'D4 Teknik Informatika'),
    ];
  }
}