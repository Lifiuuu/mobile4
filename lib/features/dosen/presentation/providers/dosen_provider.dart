import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile4/core/network/api_client.dart';
import 'package:mobile4/features/dosen/data/models/dosen_model.dart';
import 'package:mobile4/features/dosen/data/repositories/dosen_repository.dart';

//http version
// final dosenRepositoryProvider = Provider<DosenRepository>((ref) {
//   final client = ref.watch(httpClientProvider); // Ambil http.Client dari core
//   return DosenRepository(client);
// });

// dio version
final dosenRepositoryProvider = Provider<DosenRepository>((ref) {
  // Ambil instance Dio dari core
  final dio = ref.watch(dioProvider); 
  // Masukkan dio ke dalam DosenRepository
  return DosenRepository(dio); 
});

// StateNotifier untuk mengelola state dosen
class DosenNotifier extends StateNotifier<AsyncValue<List<DosenModel>>> {
  final DosenRepository _repository;

  DosenNotifier(this._repository) : super(const AsyncValue.loading()) {
    loadDosenList();
  }

  /// Load data dosen dalam bentuk list
  Future<void> loadDosenList() async {
    state = const AsyncValue.loading();
    try {
      final data = await _repository.getDosenList();
      state = AsyncValue.data(data);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  /// Refresh data dosen dalam bentuk list
  Future<void> refresh() async {
    await loadDosenList();
  }
}


final dosenNotifierProvider = StateNotifierProvider.autoDispose<DosenNotifier, AsyncValue<List<DosenModel>>>((ref) {
  final repository = ref.watch(dosenRepositoryProvider);
  return DosenNotifier(repository);
});