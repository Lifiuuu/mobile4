// 4. lib/features/mahasiswa/presentation/widgets/mahasiswa_widget.dart
import 'package:flutter/material.dart';
import 'package:mobile4/features/mahasiswa/data/models/mahasiswa_model.dart';

class ModernMahasiswaCard extends StatelessWidget {
  final MahasiswaModel mahasiswa;
  const ModernMahasiswaCard({super.key, required this.mahasiswa});

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
            (mahasiswa.nama.isNotEmpty ? mahasiswa.nama[0] : ''),
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
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      ),
    );
  }
}

// 5. lib/features/mahasiswa/presentation/pages/mahasiswa_page.dart
