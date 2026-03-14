import 'package:http/http.dart' as http;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile4/core/constants/app_constants.dart';

const String baseUrl = AppConstants.baseUrl;

// 1. BUAT CUSTOM CLIENT (INTERCEPTOR ALA HTTP)
class CustomHttpClient extends http.BaseClient {
  final http.Client _inner = http.Client();

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    // === INI YANG DIPINDAH KE CORE ===
    
    // a. Otomatis tambah Header ke semua request
    request.headers['Accept'] = 'application/json';
    request.headers['Content-Type'] = 'application/json'; // Tambahan bagus untuk POST

    // b. Otomatis jalankan fungsi Print (Logging) sebelum ngirim
    print('========================================');
    print('🚀 REQUEST: ${request.method} ${request.url}');
    
    // Kirim requestnya
    final response = await _inner.send(request);

    // c. Otomatis jalankan fungsi Print (Logging) saat balasan datang
    print('✅ RESPONSE STATUS: ${response.statusCode}');
    print('========================================');
    
    return response;
  }
}

// 2. PROVIDER YANG MENYEDIAKAN CUSTOM CLIENT
final httpClientProvider = Provider<http.Client>((ref) {
  return CustomHttpClient(); // Gunakan client buatan kita, bukan http.Client() biasa
});