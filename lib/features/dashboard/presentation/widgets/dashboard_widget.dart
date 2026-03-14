import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile4/core/constants/app_constants.dart';
import 'package:mobile4/core/theme/app_theme.dart';
import 'package:mobile4/features/dashboard/data/models/dashboard_model.dart';

/// Widget untuk menampilkan statistik card
class StatCard extends StatelessWidget {
  final DashboardStats stats;
  final bool isSelected;
  final VoidCallback? onTap;

  const StatCard({
    super.key,
    required this.stats,
    this.isSelected = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: isSelected ? 8 : 2,
      color: isSelected ? AppTheme.primaryColor.withOpacity(0.2) : null,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
        child: Padding(
          padding: const EdgeInsets.all(AppConstants.paddingMedium),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                stats.title,
                style: TextStyle(
                  fontSize: 14, 
                  color: AppTheme.textSecondaryColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                stats.value,
                style: const TextStyle(
                  fontSize: 24, 
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textPrimaryColor,
                ),
              ),
              const SizedBox(height: 8),
           
            ],
          ),
        ),
      ),
    );
  }
}

class DashbardHeader extends ConsumerWidget {
  final String userName;

  const DashbardHeader({super.key, required this.userName});

      @override
      Widget build(BuildContext context, WidgetRef ref) {
        return Container(
          padding: const EdgeInsets.all(AppConstants.paddingLarge),
          decoration: BoxDecoration(
            color: AppTheme.primaryColor,
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(AppConstants.radiusLarge),
              bottomRight: Radius.circular(AppConstants.radiusLarge),
            ),
          ),
          child: SafeArea(
            child: Column (
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:[
                        const Text(
                        'Selamat Datang,',
                        style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ), // TextStyle
                    ), // Text
                    const SizedBox(height: 4),
                    Text(
                      userName,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ), // TextStyle
                    ), // Text
                  ],
                ), //column
                CircleAvatar(
                  radius: 24,
                  backgroundColor: Colors.white.withOpacity(0.2),
                  child: const Icon(
                    Icons.person,
                    color: Colors.white,
                    size: 28,
                  ), // Icon
                ), // CircleAvatar
              ],
            ), // Row
            const SizedBox(height: AppConstants.paddingMedium),
            Text(
              'Data Mahasiswa D4TI',
              style: TextStyle(
                color: Colors.white.withOpacity(0.8),
                fontSize: 14,
              ), 
            ),
          ],
        ),
      ),
    );
  }
}

/// Modern Stat Card with Gradient and Glass Morphism
class ModernStatCard extends StatefulWidget {
  final DashboardStats stats;
  final IconData icon;
  final List<Color> gradientColors;
  final bool isSelected;
  final VoidCallback? onTap;

  const ModernStatCard({
    super.key,
    required this.stats,
    required this.icon,
    required this.gradientColors,
    this.isSelected = false,
    this.onTap,
  });

  @override
  State<ModernStatCard> createState() => _ModernStatCardState();
}

class _ModernStatCardState extends State<ModernStatCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.95,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        setState(() => _isPressed = true);
        _controller.forward();
      },
      onTapUp: (_) {
        setState(() => _isPressed = false);
        _controller.reverse();
        widget.onTap?.call();
      },
      onTapCancel: () {
        setState(() => _isPressed = false);
        _controller.reverse();
      },
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Container(
          // 1. WADAH LUAR: Khusus untuk Shadow dan Warna Dasar
          decoration: BoxDecoration(
            color: AppTheme.primaryColor, // Wajib solid agar tidak blur
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: widget.gradientColors[0].withOpacity(0.3),
                blurRadius: widget.isSelected ? 20 : 12,
                offset: Offset(0, widget.isSelected ? 8 : 4),
              ),
            ],
          ),
          // 2. BUNGKUSAN: Agar gradien di dalam tidak keluar dari sudut melengkung
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            // 3. WADAH DALAM: Khusus untuk Gradien Warna dan Konten
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: widget.gradientColors, // Ini yang mengembalikan warnanya!
                ),
              ),
              child: Stack(
                children: [
                  // Background decoration circles
                  Positioned(
                    right: -20,
                    top: -20,
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withOpacity(0.1),
                      ),
                    ),
                  ),
                  Positioned(
                    left: -10,
                    bottom: -10,
                    child: Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withOpacity(0.1),
                      ),
                    ),
                  ),

                  // Content
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Icon
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(widget.icon, color: Colors.white, size: 24),
                        ),
                        const Spacer(),

                        // Value
                        Text(
                          widget.stats.value,
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            letterSpacing: -0.5,
                          ),
                        ),
                        const SizedBox(height: 4),

                        // Title
                        Text(
                          widget.stats.title,
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.white.withOpacity(0.9),
                            fontWeight: FontWeight.w500,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
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
    );
  }
}