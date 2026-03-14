import 'package:flutter/material.dart';
import 'package:mobile4/core/constants/app_constants.dart';
import 'package:mobile4/features/dosen/data/models/dosen_model.dart';

class ModernDosenCard extends StatefulWidget {
  final DosenModel dosen;
  final VoidCallback? onTap;
  final List<Color>? gradientColors;

  const ModernDosenCard({
    super.key,
    required this.dosen,
    this.onTap,
    this.gradientColors,
  });

  @override
  State<ModernDosenCard> createState() => _ModernDosenCardState();
}

class _ModernDosenCardState extends State<ModernDosenCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.97,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final gradientColors =
        widget.gradientColors ??
        [
          Theme.of(context).primaryColor,
          Theme.of(context).primaryColor.withOpacity(0.7),
        ];

    return GestureDetector(
      onTapDown: (_) => _controller.forward(),
      onTapUp: (_) {
        _controller.reverse();
        widget.onTap?.call();
      },
      onTapCancel: () => _controller.reverse(),
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Container(
          margin: const EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.white, gradientColors[0].withOpacity(0.05)],
            ), // LinearGradient
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: gradientColors[0].withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ), // BoxShadow
            ],
            border: Border.all(
              color: gradientColors[0].withOpacity(0.1),
              width: 1,
            ), // Border.all
          ), // BoxDecoration
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                // Avatar with Gradient
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: gradientColors,
                    ), // LinearGradient
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: gradientColors[0].withOpacity(0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ), // BoxShadow
                    ],
                  ), // BoxDecoration
                  child: Center(
                    child: Text(
                      (widget.dosen.nama.isNotEmpty ? widget.dosen.nama[0].toUpperCase() : ''),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ), // TextStyle
                    ), // Text
                  ), // Center
                ), // Container
                const SizedBox(width: 16),

                // Dosen Information
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.dosen.nama,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          letterSpacing: -0.3,
                        ), // TextStyle
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ), // Text
                      const SizedBox(height: 8),
                      _buildInfoRow(
                        Icons.badge_outlined,
                        '@${widget.dosen.username}',
                      ),
                      const SizedBox(height: 4),
                      _buildInfoRow(Icons.email_outlined, widget.dosen.email),
                      const SizedBox(height: 4),
                      _buildInfoRow(
                        Icons.location_on_outlined,
                        '${widget.dosen.address.street}, ${widget.dosen.address.city}',
                      ),
                    ],
                  ), // Column
                ), // Expanded

                // Arrow Icon
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: gradientColors[0].withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ), // BoxDecoration
                  child: Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 16,
                    color: gradientColors[0],
                  ), // Icon
                ), // Container
              ],
            ), // Row
          ), // Padding
        ), // Container
      ), // ScaleTransition
    ); // GestureDetector
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 14, color: Colors.grey[600]),
        const SizedBox(width: 6),
        Expanded(
          child: Text(
            text,
            style: TextStyle(fontSize: 13, color: Colors.grey[700]),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ), // Text
        ), // Expanded
      ],
    ); // Row
  }
}

class DosenCard extends StatelessWidget {
  final DosenModel dosen;
  final VoidCallback? onTap;

  const DosenCard({
    super.key,
    required this.dosen,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: AppConstants.paddingMedium),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsetsGeometry.all(16),
          child: Row(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: Theme.of(context).primaryColor,
                child: Text(
                  (dosen.nama.isNotEmpty ? dosen.nama[0].toUpperCase() : ''),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ), // TextStyle
                ), // Text
              ), // CircleAvatar
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      dosen.nama,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ), // TextStyle
                    ), // Text
                    const SizedBox(height: 4),
                    Text(
                      '@${dosen.username}',
                      style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                    ), // Text
                    Text(
                      dosen.email,
                      style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                    ), // Text
                    Text(
                      '${dosen.address.street}, ${dosen.address.city}',
                      style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ), // Text
                  ],
                ), // Column
              ), // Expanded
              Icon(Icons.arrow_forward_ios_rounded, size: 16, color: Colors.grey[400]),
            ],
          ),
        ), // Padding
      ),  
    );
  }
}

class DosenEmptyState extends StatelessWidget {
  final VoidCallback? onrefresh;

  const DosenEmptyState({super.key, this.onrefresh});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              shape: BoxShape.circle,
            ), // BoxDecoration
            child: Icon(
              Icons.people_outline_rounded,
              size: 64,
              color: Colors.grey[400],
            ), //icon
          ), // Container
          const SizedBox(height: 24),
          Text(
            'Tidak ada data dosen',
            style: TextStyle(
              fontSize: 18, 
              fontWeight: FontWeight.w600,
              color: Colors.grey[400]
              ), // TextStyle
          ), // Text
          const SizedBox(height: 8),
          Text(
            'belum ada dosen yang terdaftar',
            style: TextStyle(fontSize: 14, color: Colors.grey[500]),
          ), // Text
          if (onrefresh != null) ...[
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: onrefresh,
              icon: const Icon(Icons.refresh),
              label: const Text('Refresh'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24, 
                  vertical: 12,
                ), // EdgeInsets.symmetric
              ), // ElevatedButton.styleFrom
            ), // ElevatedButton
          ],
        ],
      ), // Column
    ); // Center
  }
}

class DosenListView extends StatelessWidget {
  final List<DosenModel> dosenList;
  final VoidCallback onRefresh;
  final bool useModernCard;

  const DosenListView({
    super.key,
    required this.dosenList,
    required this.onRefresh,
    this.useModernCard = true,
  });

  @override
  Widget build(BuildContext context) {
   if (dosenList.isEmpty) {
      return DosenEmptyState(onrefresh: onRefresh);
    }

    return RefreshIndicator(
      onRefresh: () async => onRefresh(),
      child: ListView.builder(
        padding: const EdgeInsets.all(AppConstants.paddingMedium),
        itemCount: dosenList.length,
        itemBuilder: (context, index) {
          final dosen = dosenList[index];
          final gradientColors =
              AppConstants.dashboardGradients[index % 
                AppConstants.dashboardGradients.length];
          
          if (useModernCard) {
            return ModernDosenCard(
              dosen: dosen,
              gradientColors: gradientColors,
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Detail: ${dosen.nama}'),
                    behavior: SnackBarBehavior.floating,
                    duration: const Duration(seconds: 2),
                    ),
                 );
              },
            );
          } else {
            return DosenCard(
              dosen: dosen,
              onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Detail: ${dosen.nama}')
                    ),
                  );
                },
            );
          } 
        },
      ),
    );
  }
}