import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile4/features/dosen/presentation/providers/dosen_provider.dart';
import 'package:mobile4/features/dosen/presentation/widgets/dosen_widget.dart'; // Pastikan membuat DosenListView yang memuat ModernDosenCard

class DosenPage extends ConsumerWidget {
  const DosenPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dosenState = ref.watch(dosenNotifierProvider);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Data Dosen'),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh_rounded),
            onPressed: () {
              ref.invalidate(dosenNotifierProvider);
            },
            tooltip: 'Refresh',
          ),
        ],
      ),
      body: dosenState.when(
        loading: () => const Center(child: CircularProgressIndicator()), // Gantilah LoadingWidget()
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Gagal memuat data dosen: $error'),
              ElevatedButton(
                onPressed: () => ref.read(dosenNotifierProvider.notifier).refresh(),
                child: const Text('Retry'),
              )
            ],
          ),
        ), // Gantilah CustomErrorWidget()
        data: (dosenList) {
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: dosenList.length,
            itemBuilder: (context, index) {
              return ModernDosenCard(dosen: dosenList[index]);
            },
          );
        },
      ),
    );
  }
}