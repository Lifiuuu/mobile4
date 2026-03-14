import 'package:flutter/material.dart';
import 'package:mobile4/features/mahasiswa_aktif/data/models/mahasiswa_aktif_model.dart';

class MahasiswaAktifCard extends StatelessWidget {
  final MahasiswaAktifModel mahasiswa;

  const MahasiswaAktifCard({super.key, required this.mahasiswa});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      color: Colors.green.shade50,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.green.withOpacity(0.3)), // Garis tepi warna hijau
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: const Icon(Icons.check_circle, color: Colors.green, size: 40),
        title: Text(
          mahasiswa.nama,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text('NIM: ${mahasiswa.nim}'),
            const SizedBox(height: 4),
            Text(
              'Status: ${mahasiswa.status}', 
              style: const TextStyle(color: Colors.green, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}