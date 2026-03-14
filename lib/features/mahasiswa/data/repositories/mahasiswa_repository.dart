import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import 'package:mobile4/features/mahasiswa/data/models/mahasiswa_model.dart';
import 'package:mobile4/core/network/api_client.dart';

class MahasiswaRepository {
  //http version
  // final http.Client _client;
  // MahasiswaRepository(this._client);

  //dio version
  final Dio dio;
  MahasiswaRepository(this.dio);

  /// Mengambil daftar mahasiswa dari endpoint `/comments` (jsonplaceholder)
  Future<List<MahasiswaModel>> getMahasiswaList() async {
  //http version
  //   try {
  //     final uri = Uri.parse('$baseUrl/comments');

  //     // CUKUP BEGINI SAJA! 
  //     // Header dan Print sudah diurus otomatis oleh CustomHttpClient di Core.
  //     final response = await _client.get(uri);

  //     if (response.statusCode == 200) {
  //       final List data = jsonDecode(response.body);
  //       return data.map((item) => MahasiswaModel.fromJson(item)).toList();
  //     } else {
  //       throw Exception('Gagal mengambil data. Status: ${response.statusCode}');
  //     }
  //   } catch (e) {
  //     throw Exception('Terjadi kesalahan: $e');
  //   }
  // }
    
  // Dio version
    try {
      final response = await dio.get('/comments');
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map((json) => MahasiswaModel.fromJson(json)).toList();
      } else {
        throw Exception('gagal memuat data mahasiswa');
      }
    } catch (e) {
      throw Exception('Error fetching mahasiswa list: $e');
    }
  }
}

//dio version
final mahasiswaRepositoryProvider = Provider<MahasiswaRepository>((ref) {
  final dio = ref.watch(dioProvider); // Ambil mesin Dio dari core
  return MahasiswaRepository(dio);
});

//http version
  // final mahasiswaRepositoryProvider = Provider<MahasiswaRepository>((ref) {
  //   final client = ref.watch(httpClientProvider); // Ambil http.Client dari core
  //   return MahasiswaRepository(client);
  // });