import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile4/core/network/api_client.dart';
import 'package:mobile4/features/mahasiswa_aktif/data/models/mahasiswa_aktif_model.dart';

class MahasiswaAktifRepository {
// http version
  // final http.Client _client;
  // MahasiswaAktifRepository(this._client);

  //dio version
  final Dio dio;
  MahasiswaAktifRepository(this.dio);

  /// Ambil data dari endpoint `/posts` (jsonplaceholder)
  Future<List<MahasiswaAktifModel>> getList() async {
    // HTTP version
  //   try {
  //     final uri = Uri.parse('$baseUrl/posts');

  //     final response = await _client.get(uri);

  //     if (response.statusCode == 200) {
  //       final List data = jsonDecode(response.body);
  //       return data.map((item) => MahasiswaAktifModel.fromJson(item)).toList();
  //     } else {
  //       throw Exception('Gagal mengambil data. Status: ${response.statusCode}');
  //     }
  //   } catch (e) {
  //     throw Exception('Terjadi kesalahan: $e');
  //   }
  // }

  // Dio version  
    try {
      final response = await dio.get('/posts');
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map((json) => MahasiswaAktifModel.fromJson(json)).toList();
      } else {
        throw Exception('gagal memuat data mahasiswa aktif');
      }
    } catch (e) {
      throw Exception('Error fetching mahasiswa aktif: $e');
    }
  }
}

//dio version
final mahasiswaAktifRepoProvider = Provider((ref) {
  final dio = ref.watch(dioProvider);
  return MahasiswaAktifRepository(dio);
});

//http version
// final mahasiswaAktifRepoProvider = Provider((ref) { 
//   final client = ref.watch(httpClientProvider);
//   return MahasiswaAktifRepository(client);
// });
