import 'package:mobile4/features/profile/data/models/profile_model.dart';

class ProfileRepository {
  Future<ProfileModel> getProfile() async {
    // Simulasi loading/delay dari internet selama 1 detik
    await Future.delayed(const Duration(seconds: 1));
    
    // Mengembalikan data dummy
    return ProfileModel(
      nama: 'Admin D4TI',
      role: 'Administrator Dashboard',
      email: 'admin.d4ti@vokasi.unair.ac.id'
    );
  }
}