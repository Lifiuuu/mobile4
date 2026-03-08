import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile4/features/profile/presentation/providers/profile_provider.dart';
import 'package:mobile4/features/profile/presentation/widgets/profile_widget.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(profileNotifierProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Profil Saya')),
      body: state.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text('Error: $error')),
        data: (profile) => Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const CircleAvatar(radius: 50, child: Icon(Icons.person, size: 50)),
              const SizedBox(height: 16),
              Text(profile.nama, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              const SizedBox(height: 32),
              
              // 2. Gunakan ProfileMenuWidget di sini
              ProfileMenuWidget(
                icon: Icons.badge_outlined,
                title: 'Role / Prodi',
                value: profile.role,
              ),
              ProfileMenuWidget(
                icon: Icons.email_outlined,
                title: 'Email',
                value: profile.email,
              ),
            ],
          ),
        ),
      ),
    );
  }
}