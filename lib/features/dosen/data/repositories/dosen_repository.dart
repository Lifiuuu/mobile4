import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile4/features/dosen/data/models/dosen_model.dart';
import 'package:mobile4/core/network/dio_client.dart';


class DosenRepository {
// http version
  // final http.Client _client;
  // DosenRepository(this._client);

//dio version
  final Dio dio;
  DosenRepository(this.dio);

  /// Mendapatkan daftar dosen
  Future<List<DosenModel>> getDosenList() async {
    //http version
  //   try {
  //     final uri = Uri.parse('$baseUrl/users');

  //     final response = await _client.get(uri);

  //     if (response.statusCode == 200) {
  //       final List data = jsonDecode(response.body);
  //       return data.map((item) => DosenModel.fromJson(item)).toList();
  //     } else {
  //       throw Exception('Gagal mengambil data. Status: ${response.statusCode}');
  //     }
  //   } catch (e) {
  //     throw Exception('Terjadi kesalahan: $e');
  //   }
  // }

  // Dio version
    try {
      final response = await dio.get('/users');
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map((json) => DosenModel.fromJson(json)).toList();
      } else {
        throw Exception('gagal memuat data dosen');
      }
    } catch (e) {
      throw Exception('Error fetching dosen list: $e');
    }
  }
}

// http version
// final dosenRepositoryProvider = Provider<DosenRepository>((ref) {
//   final client = ref.watch(httpClientProvider); // Ambil http.Client dari core
//   return DosenRepository(client);
// });

// // dio version
final dosenRepositoryProvider = Provider<DosenRepository>((ref) {
  final dio = ref.watch(dioProvider); // Meminjam mesin Dio dari Core
  return DosenRepository(dio);
});