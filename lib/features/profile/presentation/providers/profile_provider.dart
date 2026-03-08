import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile4/features/profile/data/models/profile_model.dart';
import 'package:mobile4/features/profile/data/repositories/profile_repository.dart';

final profileRepoProvider = Provider((ref) => ProfileRepository());

class ProfileNotifier extends StateNotifier<AsyncValue<ProfileModel>> {
  final ProfileRepository _repo;
  ProfileNotifier(this._repo) : super(const AsyncValue<ProfileModel>.loading()) {
    loadData();
  }

  Future<void> loadData() async {
    state = const AsyncValue<ProfileModel>.loading();
    try {
      final data = await _repo.getProfile();
      state = AsyncValue.data(data);
    } catch (e, s) { state = AsyncValue.error(e, s); }
  }
}

final profileNotifierProvider = StateNotifierProvider.autoDispose<ProfileNotifier, AsyncValue<ProfileModel>>((ref) {
  return ProfileNotifier(ref.watch(profileRepoProvider));
});