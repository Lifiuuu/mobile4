import 'package:mobile4/features/mahasiswa_aktif/data/models/mahasiswa_aktif_model.dart';

class MahasiswaAktifRepository {
  Future<List<MahasiswaAktifModel>> getList() async {
    await Future.delayed(const Duration(seconds: 1));
    return [
      MahasiswaAktifModel(nama: 'Andi Setiawan', nim: '1520001', status: 'KRS Disetujui'),
      MahasiswaAktifModel(nama: 'Budi Raharjo', nim: '1520002', status: 'Aktif'),
    ];
  }
}