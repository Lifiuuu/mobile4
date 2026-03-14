import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile4/core/constants/app_constants.dart';

// Kita buat provider agar bisa di-watch oleh Repository di folder features
final dioProvider = Provider<Dio>((ref) {
  final dio = Dio(
    BaseOptions(
      // Ganti dengan URL pusat API kamu
      baseUrl: AppConstants.baseUrl, 
      
      // Durasi maksimal menunggu koneksi (10 detik)
      connectTimeout: const Duration(seconds: 10),
      
      // Durasi maksimal menunggu kiriman data dari server (10 detik)
      receiveTimeout: const Duration(seconds: 10),
      
      // Header standar untuk API JSON
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
    ),
  );

  // Menambahkan Interceptor untuk mempermudah Debugging
  // Ini akan memunculkan log di terminal setiap kali ada request/response
  dio.interceptors.add(
    LogInterceptor(
      requestBody: true,    // Lihat data yang kita kirim
      responseBody: true,   // Lihat data yang dikirim server
      requestHeader: false,
    ),
  );

  return dio;
});