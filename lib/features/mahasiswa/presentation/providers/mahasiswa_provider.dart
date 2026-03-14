import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:mobile4/core/network/http_client.dart';
import 'package:mobile4/features/mahasiswa/data/models/mahasiswa_model.dart';
import 'package:mobile4/features/mahasiswa/data/repositories/mahasiswa_repository.dart';
import 'package:mobile4/core/network/api_client.dart';

//HTTP version
// final mahasiswaRepositoryProvider = Provider<MahasiswaRepository>((ref) {
//   final http.Client client = ref.watch(httpClientProvider);
//   return MahasiswaRepository(client);
// });

//Dio version
final mahasiswaRepositoryProvider = Provider<MahasiswaRepository>((ref) {
  final dio = ref.watch(dioProvider);
  return MahasiswaRepository(dio);
});

class MahasiswaNotifier extends StateNotifier<AsyncValue<List<MahasiswaModel>>> {
  final MahasiswaRepository _repository;
  MahasiswaNotifier(this._repository) : super(const AsyncValue<List<MahasiswaModel>>.loading()) {
    loadMahasiswaList();
  }

  Future<void> loadMahasiswaList() async {
    state = const AsyncValue<List<MahasiswaModel>>.loading();
    try {
      final data = await _repository.getMahasiswaList();
      state = AsyncValue.data(data);
    } catch (error, stack) {
      state = AsyncValue.error(error, stack);
    }
  }

  Future<void> refresh() async => await loadMahasiswaList();
}


final mahasiswaNotifierProvider = StateNotifierProvider.autoDispose<MahasiswaNotifier, AsyncValue<List<MahasiswaModel>>>((ref) {
  final repository = ref.watch(mahasiswaRepositoryProvider);
  return MahasiswaNotifier(repository);
});