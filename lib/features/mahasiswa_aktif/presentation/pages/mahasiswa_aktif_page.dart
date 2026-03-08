import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile4/features/mahasiswa_aktif/presentation/providers/mahasiswa_aktif_provider.dart';
import 'package:mobile4/features/mahasiswa_aktif/presentation/widgets/mahasiswa_aktif_widget.dart';

class MahasiswaAktifPage extends ConsumerWidget {
  const MahasiswaAktifPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(mahasiswaAktifNotifierProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Mahasiswa Aktif')),
      body: state.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text('Error: $error')),
        data: (list) => ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: list.length,
          itemBuilder: (context, index) {
            
            // 2. Sekarang kodenya jadi sangat pendek dan rapi!
            // Cukup panggil widget MahasiswaAktifCard dan lempar datanya
            return MahasiswaAktifCard(mahasiswa: list[index]);
            
          },
        ),
      ),
    );
  }
}