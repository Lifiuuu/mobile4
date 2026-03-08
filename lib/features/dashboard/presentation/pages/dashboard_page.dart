// lib/features/dashboard/presentation/pages/dashboard_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile4/core/constants/app_constants.dart';
import 'package:mobile4/core/theme/app_theme.dart';
import 'package:mobile4/core/widgets/common_widgets.dart'; // Pastikan membuat LoadingWidget dan CustomErrorWidget
import 'package:mobile4/features/dashboard/presentation/providers/dashboard_provider.dart';
import 'package:mobile4/features/dashboard/presentation/widgets/dashboard_widget.dart';
import 'package:mobile4/features/mahasiswa/presentation/pages/mahasiswa_page.dart';
import 'package:mobile4/features/mahasiswa_aktif/presentation/pages/mahasiswa_aktif_page.dart';
import 'package:mobile4/features/dosen/presentation/pages/dosen_page.dart';
import 'package:mobile4/features/profile/presentation/pages/profile_page.dart';

class DashboardPage extends ConsumerWidget {
  const DashboardPage({Key? key}) : super(key: key);

  IconData _getIconForStat(String title) {
    switch (title) {
      case 'Total Mahasiswa': 
        return Icons.school_rounded;
      case 'Mahasiswa Aktif': 
        return Icons.person_outline_rounded;
      case 'Dosen': 
        return Icons.people_outline_rounded;
      case 'Profile':
        return Icons.account_circle_rounded;
      default: 
        return Icons.analytics_outlined;
    }
  }

@override
  Widget build(BuildContext context, WidgetRef ref) {
    final dashboardState = ref.watch(dashboardNotifierProvider);
    final selectedIndex = ref.watch(selectedStatIndexProvider);

    return Scaffold(
      body: dashboardState.when(
        loading: () => const LoadingWidget(),
        error: (error, stack) => CustomErrorWidget(
          message: 'Gagal memuat data: ${error.toString()}',
          onRetry: () {
            ref.read(dashboardNotifierProvider.notifier).refresh();
          },
        ),
        data: (dashboardData) {
          return RefreshIndicator(
            onRefresh: () async {
              ref.invalidate(dashboardNotifierProvider);
            },
            child: CustomScrollView(
              slivers: [
                // Modern Header with Gradient (SUDAH DIPERBAIKI BLUR-NYA)
                SliverToBoxAdapter(
                  child: Container(
                    // 1. Container Luar HANYA untuk Shadow dan Warna Solid
                    decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor, // Warna dasar solid
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(32),
                        bottomRight: Radius.circular(32),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Theme.of(context).primaryColor.withOpacity(0.3),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    // 2. Bungkus dengan ClipRRect agar gradient mengikuti lengkungan radius
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(32),
                        bottomRight: Radius.circular(32),
                      ),
                      // 3. Container Dalam HANYA untuk Gradient dan Konten
                      child: Container(
                        color: AppTheme.primaryColor,
                        child: SafeArea(
                          bottom: false,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(24, 20, 24, 32),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Selamat Datang! 👋',
                                            style: TextStyle(
                                              color: Colors.white.withOpacity(0.9),
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          const SizedBox(height: 8),
                                          Text(
                                            dashboardData.userName,
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 28,
                                              fontWeight: FontWeight.bold,
                                              letterSpacing: -0.5,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(0.2),
                                        borderRadius: BorderRadius.circular(16),
                                        border: Border.all(
                                          color: Colors.white.withOpacity(0.3),
                                          width: 2,
                                        ),
                                      ),
                                      child: IconButton(
                                        icon: const Icon(
                                          Icons.notifications_outlined,
                                          color: Colors.white,
                                          size: 26,
                                        ),
                                        onPressed: () {},
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 12,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.15),
                                    borderRadius: BorderRadius.circular(16),
                                    border: Border.all(
                                      color: Colors.white.withOpacity(0.2),
                                      width: 1,
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.calendar_today_rounded,
                                        color: Colors.white.withOpacity(0.9),
                                        size: 18,
                                      ),
                                      const SizedBox(width: 12),
                                      Text(
                                        'Update: ${_formatDate(dashboardData.lastUpdate)}',
                                        style: TextStyle(
                                          color: Colors.white.withOpacity(0.9),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                // Stats Section with Modern Cards
                SliverPadding(
                  padding: const EdgeInsets.all(24),
                  sliver: SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Statistik',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                letterSpacing: -0.5,
                              ),
                            ),
                            TextButton.icon(
                              onPressed: () {
                                ref.invalidate(dashboardNotifierProvider);
                              },
                              icon: const Icon(Icons.refresh_rounded, size: 18),
                              label: const Text('Refresh'),
                              style: TextButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 8,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 16,
                            childAspectRatio: 1.1,
                          ),
                          itemCount: dashboardData.stats.length,
                          itemBuilder: (context, index) {
                            final stat = dashboardData.stats[index];
                            return ModernStatCard(
                              stats: stat,
                              icon: _getIconForStat(stat.title),
                              gradientColors: AppConstants.dashboardGradients[
                                  index % AppConstants.dashboardGradients.length],
                              isSelected: selectedIndex == index,
                              onTap: () {
                                ref.read(selectedStatIndexProvider.notifier).state = index;

                                final statTitle = stat.title;
                                Widget? targetPage;

                                switch (statTitle) {
                                  case 'Total Mahasiswa':
                                    targetPage = const MahasiswaPage();
                                    break;
                                  case 'Mahasiswa Aktif':
                                    targetPage = const MahasiswaAktifPage();
                                    break;
                                  case 'Dosen':
                                    targetPage = const DosenPage();
                                    break;
                                  case 'Profile':
                                    targetPage = const ProfilePage();
                                    break;
                                }

                                if (targetPage != null) {
                                  Navigator.push(
                                    context,
                                    _createRoute(targetPage),
                                  );
                                }
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),

                const SliverPadding(padding: EdgeInsets.only(bottom: 24)),
              ],
            ),
          );
        },
      ),
    );
  }

  // custome slide transisi waktu pindah page
  Route _createRoute(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.easeInOutCubic;
        var tween = Tween(
          begin: begin,
          end: end,
        ).chain(CurveTween(curve: curve)); // Tween
        var offsetAnimation = animation.drive(tween);

        return SlideTransition(position: offsetAnimation, child: child);
      },
      transitionDuration: const Duration(milliseconds: 400),
    ); // PageRouteBuilder
  }

  // conver tanggal update
  String _formatDate(DateTime date) {
    final months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'Mei',
      'Jun',
      'Jul',
      'Agu',
      'Sep',
      'Okt',
      'Nov',
      'Des',
    ];
    return '${date.day} ${months[date.month - 1]} ${date.year}, ${date.hour}:${date.minute.toString().padLeft(2, '0')}';
  }
}