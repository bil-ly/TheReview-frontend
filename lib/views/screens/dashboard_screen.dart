import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;
  String _selectedFilter = 'All';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.dashboard_outlined),
          onPressed: () {},
        ),
        title: const Text('Dashboard'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Search for anything...',
                  hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.white.withOpacity(0.7),
                  ),
                  filled: true,
                  fillColor: const Color(0xFF2A3544),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                ),
                onTap: () {
                  // Navigate to search results
                  context.push('${AppConstants.topicRoute}/eiffel-tower');
                },
              ),
            ),
            // Trending Topics Header
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Trending Topics',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Trending Topics Cards
            SizedBox(
              height: 140,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  _TrendingTopicCard(
                    icon: Icons.music_note,
                    title: 'Music Fest 2024',
                    onTap: () {},
                  ),
                  const SizedBox(width: 12),
                  _TrendingTopicCard(
                    icon: Icons.lightbulb_outline,
                    title: 'Innovate Solutions',
                    onTap: () {},
                  ),
                  const SizedBox(width: 12),
                  _TrendingTopicCard(
                    icon: Icons.download_outlined,
                    title: 'Downtown Cafe',
                    onTap: () {},
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // Filter Chips
            SizedBox(
              height: 48,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  _FilterChip(
                    label: 'All',
                    isSelected: _selectedFilter == 'All',
                    onTap: () {
                      setState(() {
                        _selectedFilter = 'All';
                      });
                    },
                  ),
                  const SizedBox(width: 8),
                  _FilterChip(
                    label: 'Google',
                    isSelected: _selectedFilter == 'Google',
                    onTap: () {
                      setState(() {
                        _selectedFilter = 'Google';
                      });
                    },
                  ),
                  const SizedBox(width: 8),
                  _FilterChip(
                    label: 'Twitter',
                    isSelected: _selectedFilter == 'Twitter',
                    onTap: () {
                      setState(() {
                        _selectedFilter = 'Twitter';
                      });
                    },
                  ),
                  const SizedBox(width: 8),
                  _FilterChip(
                    label: 'LinkedIn',
                    isSelected: _selectedFilter == 'LinkedIn',
                    onTap: () {
                      setState(() {
                        _selectedFilter = 'LinkedIn';
                      });
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Review Cards
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  _ReviewCard(
                    companyName: 'DigitalOcean',
                    source: 'Google',
                    totalReviews: 1204,
                    positivePercent: 75,
                    neutralPercent: 15,
                    negativePercent: 10,
                    icon: Icons.cloud_outlined,
                    onTap: () {},
                  ),
                  const SizedBox(height: 12),
                  _ReviewCard(
                    companyName: 'Vercel',
                    source: 'Twitter',
                    totalReviews: 876,
                    positivePercent: 85,
                    neutralPercent: 10,
                    negativePercent: 5,
                    icon: Icons.flash_on_outlined,
                    onTap: () {},
                  ),
                  const SizedBox(height: 12),
                  _ReviewCard(
                    companyName: 'Stripe',
                    source: 'Google',
                    totalReviews: 2318,
                    positivePercent: 80,
                    neutralPercent: 12,
                    negativePercent: 8,
                    icon: Icons.payment_outlined,
                    onTap: () {},
                  ),
                ],
              ),
            ),
            const SizedBox(height: 80),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
          if (index == 2) {
            context.push(AppConstants.profileRoute);
          }
        },
        backgroundColor: const Color(0xFF1A2332),
        selectedItemColor: const Color(0xFF00B8D4),
        unselectedItemColor: Colors.white.withOpacity(0.5),
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard_outlined),
            activeIcon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_outline),
            activeIcon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

class _TrendingTopicCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _TrendingTopicCard({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 140,
        decoration: BoxDecoration(
          color: const Color(0xFF2A3544),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: const Color(0xFF3A4554),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: Colors.white.withOpacity(0.7),
                size: 28,
              ),
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _FilterChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF00B8D4) : const Color(0xFF2A3544),
          borderRadius: BorderRadius.circular(24),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

class _ReviewCard extends StatelessWidget {
  final String companyName;
  final String source;
  final int totalReviews;
  final int positivePercent;
  final int neutralPercent;
  final int negativePercent;
  final IconData icon;
  final VoidCallback onTap;

  const _ReviewCard({
    required this.companyName,
    required this.source,
    required this.totalReviews,
    required this.positivePercent,
    required this.neutralPercent,
    required this.negativePercent,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF2A3544),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: const Color(0xFF3A4554),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    icon,
                    color: Colors.white.withOpacity(0.7),
                    size: 24,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        companyName,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Source: $source',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.6),
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      totalReviews.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Total Reviews',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.6),
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Progress Bar
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: Row(
                children: [
                  if (positivePercent > 0)
                    Expanded(
                      flex: positivePercent,
                      child: Container(
                        height: 8,
                        color: const Color(0xFF4CAF50),
                      ),
                    ),
                  if (neutralPercent > 0)
                    Expanded(
                      flex: neutralPercent,
                      child: Container(
                        height: 8,
                        color: const Color(0xFFFFA726),
                      ),
                    ),
                  if (negativePercent > 0)
                    Expanded(
                      flex: negativePercent,
                      child: Container(
                        height: 8,
                        color: const Color(0xFFE53935),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            // Legend
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _LegendItem(
                  color: const Color(0xFF4CAF50),
                  label: '$positivePercent% Positive',
                ),
                _LegendItem(
                  color: const Color(0xFFFFA726),
                  label: '$neutralPercent% Neutral',
                ),
                _LegendItem(
                  color: const Color(0xFFE53935),
                  label: '$negativePercent% Negative',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _LegendItem extends StatelessWidget {
  final Color color;
  final String label;

  const _LegendItem({
    required this.color,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: TextStyle(
            color: Colors.white.withOpacity(0.8),
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
