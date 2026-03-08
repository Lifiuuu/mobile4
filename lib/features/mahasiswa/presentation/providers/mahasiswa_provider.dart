import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile4/features/mahasiswa/data/models/mahasiswa_model.dart';
import 'package:mobile4/features/mahasiswa/data/repositories/mahasiswa_repository.dart';

final mahasiswaRepositoryProvider = Provider<MahasiswaRepository>((ref) => MahasiswaRepository());

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
  return MahasiswaNotifier(ref.watch(mahasiswaRepositoryProvider));
});