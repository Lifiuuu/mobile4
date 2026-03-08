import 'package:mobile4/core/constants/app_constants.dart';
import 'package:mobile4/core/theme/app_theme.dart'; // gunakan AppTheme untuk konsistensi tampilan
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile4/features/dashboard/presentation/pages/dashboard_page.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConstants.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.light,
      home: const DashboardPage(),
    );
  }
}