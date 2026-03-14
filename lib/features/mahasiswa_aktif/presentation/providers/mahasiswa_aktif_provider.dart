import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile4/core/network/http_client.dart';
import 'package:mobile4/features/mahasiswa_aktif/data/models/mahasiswa_aktif_model.dart';
import 'package:mobile4/features/mahasiswa_aktif/data/repositories/mahasiswa_aktif_repository.dart';
import 'package:mobile4/core/network/api_client.dart';

final mahasiswaAktifRepoProvider = Provider((ref) {
// http version
//   final client = ref.watch(httpClientProvider);
//   return MahasiswaAktifRepository(client);
// });

// dio version
  final dio = ref.watch(dioProvider);
  return MahasiswaAktifRepository(dio);
});

class MahasiswaAktifNotifier extends StateNotifier<AsyncValue<List<MahasiswaAktifModel>>> {
  final MahasiswaAktifRepository _repo;
  MahasiswaAktifNotifier(this._repo) : super(const AsyncValue<List<MahasiswaAktifModel>>.loading()) {
    loadData();
  }

  Future<void> loadData() async {
    state = const AsyncValue<List<MahasiswaAktifModel>>.loading();
    try {
      final data = await _repo.getList();
      state = AsyncValue.data(data);
    } catch (e, s) { state = AsyncValue.error(e, s); }
  }
  Future<void> refresh() async => await loadData();
}

final mahasiswaAktifNotifierProvider = StateNotifierProvider.autoDispose<MahasiswaAktifNotifier, AsyncValue<List<MahasiswaAktifModel>>>((ref) {
  return MahasiswaAktifNotifier(ref.watch(mahasiswaAktifRepoProvider));
});