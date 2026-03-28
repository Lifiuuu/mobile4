import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile4/features/mahasiswa/data/models/mahasiswa_model.dart';
import 'package:mobile4/features/mahasiswa/data/repositories/mahasiswa_repository.dart';
import 'package:mobile4/core/network/dio_client.dart';
import 'package:mobile4/core/services/local_storage_service.dart';

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

// LocalStorageService Provider
final localStorageServiceProvider = Provider<LocalStorageService>((ref) {
  return LocalStorageService();
}); // Provider

// Provider semua data user yang disimpan
final savedUsersProvider = FutureProvider<List<Map<String, String>>>((ref) async {
  final storage = ref.watch(localStorageServiceProvider);
  return storage.getSavedUsers();
});

// Provider untuk membaca saved user dari local storage
final savedUserProvider = FutureProvider<Map<String, String?>>((ref) async {
  final storage = ref.watch(localStorageServiceProvider);
  final userId = await storage.getUserId();
  final username = await storage.getUsername();
  final token = await storage.getToken();
  return {'userId': userId, 'username': username, 'token': token};
});

class MahasiswaNotifier extends StateNotifier<AsyncValue<List<MahasiswaModel>>> {
  final MahasiswaRepository _repository;
  final LocalStorageService _storage;

  MahasiswaNotifier(this._repository, this._storage) : super(const AsyncValue<List<MahasiswaModel>>.loading()) {
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

    /// Simpan mahasiswa yang dipilih ke local storage (tanpa menghapus yang lama)
  Future<void> saveSelectedDosen(MahasiswaModel mahasiswa) async {
    await _storage.addUserToSavedList(
      username: mahasiswa.nama,
      userId: mahasiswa.nim,
    );
  }

  /// Hapus user tertentu dari list
  Future<void> removeSavedUser(String userId) async {
    await _storage.removeSavedUser(userId);
  }

  /// Hapus semua user dari list
  Future<void> clearSavedUsers() async {
    await _storage.clearSavedUsers();
  }
}


final mahasiswaNotifierProvider = StateNotifierProvider.autoDispose<MahasiswaNotifier, AsyncValue<List<MahasiswaModel>>>((ref) {
  final repository = ref.watch(mahasiswaRepositoryProvider);
  final storage = ref.watch(localStorageServiceProvider);
  return MahasiswaNotifier(repository, storage);
});