import 'package:flutter/material.dart';
import 'package:clean_seas_flutter/screens/seafoodGuide/endangered_species.dart';
import 'package:flutter_animate/flutter_animate.dart';

class EndangeredSpeciesDetailScreen extends StatelessWidget {
  final EndangeredSpecies endangeredSpecies;
  const EndangeredSpeciesDetailScreen(
      {super.key, required this.endangeredSpecies});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: const Color(0xFF0A1931),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            delegate: _SliverAppBarDelegate(
              expandedHeight: 300,
              imageUrl: endangeredSpecies.imageUrl,
              title: endangeredSpecies.name,
            ),
            pinned: true,
          ),
          SliverToBoxAdapter(
            child: Container(
              decoration: const BoxDecoration(
                color: Color(0xFFE6F7FF),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: _buildClassificationDetails(),
                  ),
                  const SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: _buildDescription(endangeredSpecies.longDescription),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildClassificationDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Classification',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color(0xFF0A1931),
          ),
        ).animate().fadeIn(duration: 500.ms).slideX(),
        const SizedBox(height: 15),
        _buildDetailRow('Scientific name', 'Hippocampus kuda'),
        _buildDetailRow('Class', 'Actinopterygii'),
        _buildDetailRow('Genus', 'Hippocampus'),
        _buildDetailRow('Phylum', 'Chordata'),
        _buildDetailRow('Domain', 'Eukaryota'),
        _buildDetailRow('Family', 'Syngnathidae'),
        _buildDetailRow('Kingdom', 'Animalia'),
      ],
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: Color(0xFF4A6572),
              fontSize: 16,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFF0A1931),
              fontSize: 16,
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 500.ms).slideX();
  }

  Widget _buildDescription(String description) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Description',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color(0xFF0A1931),
          ),
        ).animate().fadeIn(duration: 500.ms).slideX(),
        const SizedBox(height: 15),
        Text(
          description,
          style: const TextStyle(
            fontSize: 16,
            color: Color(0xFF4A6572),
            height: 1.5,
          ),
        ).animate().fadeIn(duration: 500.ms).slideY(),
      ],
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final double expandedHeight;
  final String imageUrl;
  final String title;

  _SliverAppBarDelegate({
    required this.expandedHeight,
    required this.imageUrl,
    required this.title,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final double progress = shrinkOffset / expandedHeight;
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.asset(
          imageUrl,
          fit: BoxFit.cover,
        ),
        Opacity(
          opacity: progress,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  const Color(0xFF0A1931).withOpacity(0.7),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          left: 16,
          right: 16,
          bottom: 16 + (1 - progress) * 32,
          child: Opacity(
            opacity: 1 - progress,
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                shadows: [
                  Shadow(
                    offset: Offset(1, 1),
                    blurRadius: 3,
                    color: Color(0xFF0A1931),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => kToolbarHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
