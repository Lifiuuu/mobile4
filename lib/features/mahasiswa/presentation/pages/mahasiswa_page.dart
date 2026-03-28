import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile4/features/mahasiswa/presentation/providers/mahasiswa_provider.dart';
import 'package:mobile4/features/mahasiswa/presentation/widgets/mahasiswa_widget.dart';

class MahasiswaPage extends ConsumerWidget {
  const MahasiswaPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(mahasiswaNotifierProvider);
    // 1. Pantau data local storage
    final savedUsers = ref.watch(savedUsersProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Data Mahasiswa'),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => ref.read(mahasiswaNotifierProvider.notifier).refresh(),
            tooltip: 'Refresh',
          )
        ],
      ),
      // 2. Gunakan Column untuk membagi layar
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // --- Bagian Atas: Local Storage ---
          SavedMahasiswaSection(savedUsers: savedUsers, ref: ref),

          // --- Judul Pembatas ---
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 8, 16, 4),
            child: Text(
              'Daftar Mahasiswa',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
          ),

          // --- Bagian Bawah: Data dari API ---
          Expanded(
            child: state.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, _) => Center(child: Text('Error: $error')),
              data: (list) => RefreshIndicator(
                onRefresh: () async => ref.read(mahasiswaNotifierProvider.notifier).refresh(),
                child: ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    final mahasiswa = list[index];
                    return ModernMahasiswaCard(
                      mahasiswa: mahasiswa,
                      // 3. Eksekusi fungsi simpan saat tombol ditekan
                      onSave: () async {
                        // Memanggil fungsi dari providermu
                        await ref.read(mahasiswaNotifierProvider.notifier).saveSelectedDosen(mahasiswa);
                        // Refresh data lokal agar UI langsung update
                        ref.invalidate(savedUsersProvider);
                        
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('${mahasiswa.nama} berhasil disimpan ke Local Storage'),
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                        }
                      },
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}