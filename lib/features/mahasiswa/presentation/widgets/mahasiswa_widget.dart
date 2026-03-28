import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile4/features/mahasiswa/presentation/providers/mahasiswa_provider.dart';
import 'package:mobile4/features/mahasiswa/data/models/mahasiswa_model.dart';

class ModernMahasiswaCard extends StatelessWidget {
  final MahasiswaModel mahasiswa;
  final VoidCallback? onSave;

  const ModernMahasiswaCard({
    super.key, 
    required this.mahasiswa, 
    this.onSave
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: CircleAvatar(
          radius: 25,
          backgroundColor: Theme.of(context).primaryColor.withOpacity(0.2),
          child: Text(
            (mahasiswa.nama.isNotEmpty ? mahasiswa.nama[0].toUpperCase() : ''),
            style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold),
          ),
        ),
        title: Text(mahasiswa.nama, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text('NIM: ${mahasiswa.nim}'),
            Text('Email: ${mahasiswa.email}'),
          ],
        ),
        // UBAH BAGIAN INI: Ganti panah menjadi tombol Save
        trailing: IconButton(
          icon: const Icon(Icons.save_outlined),
          color: Theme.of(context).primaryColor,
          tooltip: 'Simpan ke Local Storage',
          onPressed: onSave,
        ),
      ),
    );
  }
}


class SavedMahasiswaSection extends ConsumerWidget {
  final AsyncValue<List<Map<String, String>>> savedUsers;
  final WidgetRef ref;

  const SavedMahasiswaSection({super.key, required this.savedUsers, required this.ref});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.storage_rounded, size: 16),
              const SizedBox(width: 6),
              const Text(
                'Data Tersimpan di Local Storage',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              savedUsers.maybeWhen(
                data: (users) => users.isNotEmpty
                    ? TextButton.icon(
                        onPressed: () async {
                          await ref.read(mahasiswaNotifierProvider.notifier).clearSavedUsers();
                          ref.invalidate(savedUsersProvider);
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Semua data tersimpan dihapus')),
                            );
                          }
                        },
                        icon: const Icon(Icons.delete_sweep_outlined, size: 14, color: Colors.red),
                        label: const Text('Hapus Semua', style: TextStyle(fontSize: 12, color: Colors.red)),
                      )
                    : const SizedBox.shrink(),
                orElse: () => const SizedBox.shrink(),
              ),
            ],
          ),
          const SizedBox(height: 8),
          
          savedUsers.when(
            loading: () => const LinearProgressIndicator(),
            error: (e, s) => const Text('Gagal membaca data tersimpan', style: TextStyle(color: Colors.red, fontSize: 12)),
            data: (users) {
              if (users.isEmpty) {
                return Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.info_outline, size: 16, color: Colors.grey.shade400),
                      const SizedBox(width: 8),
                      Text('Belum ada data. Tap ikon save untuk menyimpan.', style: TextStyle(fontSize: 12, color: Colors.grey.shade500)),
                    ],
                  ),
                );
              }
              return Container(
                decoration: BoxDecoration(
                  color: Colors.blue.shade50, // Ubah warna jadi biru agar beda dengan Dosen
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.blue.shade200),
                ),
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: users.length,
                  separatorBuilder: (_, __) => Divider(height: 1, color: Colors.blue.shade100, indent: 12, endIndent: 12),
                  itemBuilder: (context, index) {
                    final user = users[index];
                    return ListTile(
                      dense: true,
                      leading: CircleAvatar(
                        radius: 14,
                        backgroundColor: Colors.blue.shade100,
                        child: Text('${index + 1}', style: TextStyle(fontSize: 11, color: Colors.blue.shade700, fontWeight: FontWeight.bold)),
                      ),
                      title: Text(user['username'] ?? '-'),
                      subtitle: Text(
                        'NIM: ${user['user_id']} • ${_formatDate(user['saved_at'] ?? '')}',
                        style: const TextStyle(fontSize: 11),
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.close, size: 16, color: Colors.red),
                        onPressed: () async {
                          await ref.read(mahasiswaNotifierProvider.notifier).removeSavedUser(user['user_id'] ?? '');
                          ref.invalidate(savedUsersProvider);
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('${user['username']} dihapus')),
                            );
                          }
                        },
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  String _formatDate(String isoString) {
    if (isoString.isEmpty) return '-';
    try {
      final date = DateTime.parse(isoString);
      return '${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute}';
    } catch (e) {
      return isoString;
    }
  }
}