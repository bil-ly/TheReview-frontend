import 'package:flutter/material.dart';

class TopicScreen extends StatefulWidget {
  final String topicId;

  const TopicScreen({super.key, required this.topicId});

  @override
  State<TopicScreen> createState() => _TopicScreenState();
}

class _TopicScreenState extends State<TopicScreen> {
  String _selectedFilter = 'All';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('Results for "Eiffel Tower"'),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Overall Rating Header
            Container(
              padding: const EdgeInsets.all(24),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.star,
                    color: Color(0xFFFFA726),
                    size: 32,
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    '4.3',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      'overall',
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.white.withOpacity(0.7),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                'Based on 1,482 reviews from 3 sources',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white.withOpacity(0.6),
                ),
              ),
            ),
            const SizedBox(height: 24),
            // Source Cards
            SizedBox(
              height: 120,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  _SourceCard(
                    name: 'Google',
                    rating: 4.2,
                    icon: Icons.g_mobiledata,
                    backgroundColor: const Color(0xFF2A3544),
                  ),
                  const SizedBox(width: 12),
                  _SourceCard(
                    name: 'TripAdvisor',
                    rating: 4.5,
                    icon: Icons.flight,
                    backgroundColor: const Color(0xFF2A3544),
                  ),
                  const SizedBox(width: 12),
                  _SourceCard(
                    name: 'Twitter',
                    rating: null,
                    sentiment: '78%',
                    icon: Icons.flutter_dash,
                    backgroundColor: const Color(0xFF2A3544),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            // Filter Tabs
            Container(
              color: const Color(0xFF1A2332),
              child: Row(
                children: [
                  _TabButton(
                    label: 'All',
                    isSelected: _selectedFilter == 'All',
                    onTap: () {
                      setState(() {
                        _selectedFilter = 'All';
                      });
                    },
                  ),
                  _TabButton(
                    label: 'Google',
                    isSelected: _selectedFilter == 'Google',
                    onTap: () {
                      setState(() {
                        _selectedFilter = 'Google';
                      });
                    },
                  ),
                  _TabButton(
                    label: 'TripAdvisor',
                    isSelected: _selectedFilter == 'TripAdvisor',
                    onTap: () {
                      setState(() {
                        _selectedFilter = 'TripAdvisor';
                      });
                    },
                  ),
                  _TabButton(
                    label: 'Twitter',
                    isSelected: _selectedFilter == 'Twitter',
                    onTap: () {
                      setState(() {
                        _selectedFilter = 'Twitter';
                      });
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Reviews List
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  _ReviewItem(
                    authorName: 'Sarah Jennings',
                    source: 'Google',
                    timeAgo: '2 days ago',
                    rating: 5,
                    content:
                        'The view from the top is absolutely breathtaking, especially at sunset. Be prepared for long queues, but it is worth the wait. A must-see in Paris!',
                  ),
                  const SizedBox(height: 16),
                  _ReviewItem(
                    authorName: '@travel_bug',
                    source: 'Twitter',
                    timeAgo: '5 days ago',
                    sentiment: 'Positive',
                    content:
                        'Just visited the #EiffelTower! ✨ An iconic landmark that lives up to the hype. Magical experience. #Paris #travel',
                  ),
                  const SizedBox(height: 16),
                  _ReviewItem(
                    authorName: 'Mike R.',
                    source: 'Google',
                    timeAgo: '1 week ago',
                    rating: 2,
                    content:
                        'The structure is impressive, but the crowds are overwhelming. It was difficult to enjoy the experience with so many people pushing and shoving. Maybe go during the off-season...',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 80),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: const Color(0xFF00B8D4),
        child: const Icon(Icons.share, color: Colors.white),
      ),
    );
  }
}

class _SourceCard extends StatelessWidget {
  final String name;
  final double? rating;
  final String? sentiment;
  final IconData icon;
  final Color backgroundColor;

  const _SourceCard({
    required this.name,
    this.rating,
    this.sentiment,
    required this.icon,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: const BoxDecoration(
              color: Color(0xFF3A4554),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: Colors.white,
              size: 24,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            name,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          if (rating != null)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.star,
                  color: Color(0xFFFFA726),
                  size: 16,
                ),
                const SizedBox(width: 4),
                Text(
                  rating!.toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          if (sentiment != null)
            Text(
              sentiment!,
              style: const TextStyle(
                color: Color(0xFF4CAF50),
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
        ],
      ),
    );
  }
}

class _TabButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _TabButton({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color:
                    isSelected ? const Color(0xFF00B8D4) : Colors.transparent,
                width: 3,
              ),
            ),
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: isSelected ? const Color(0xFF00B8D4) : Colors.white.withOpacity(0.6),
              fontSize: 14,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}

class _ReviewItem extends StatelessWidget {
  final String authorName;
  final String source;
  final String timeAgo;
  final int? rating;
  final String? sentiment;
  final String content;

  const _ReviewItem({
    required this.authorName,
    required this.source,
    required this.timeAgo,
    this.rating,
    this.sentiment,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF2A3544),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: const Color(0xFF3A4554),
                child: Text(
                  authorName[0].toUpperCase(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      authorName,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      timeAgo,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.5),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Rating or Sentiment
          if (rating != null)
            Row(
              children: List.generate(
                5,
                (index) => Icon(
                  index < rating! ? Icons.star : Icons.star_border,
                  color: const Color(0xFFFFA726),
                  size: 18,
                ),
              ),
            ),
          if (sentiment != null)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFF4CAF50).withOpacity(0.2),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(
                sentiment!,
                style: const TextStyle(
                  color: Color(0xFF4CAF50),
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          const SizedBox(height: 12),
          Text(
            content,
            style: TextStyle(
              color: Colors.white.withOpacity(0.9),
              fontSize: 14,
              height: 1.5,
            ),
          ),
          if (content.length > 150) ...[
            const SizedBox(height: 8),
            GestureDetector(
              onTap: () {},
              child: const Text(
                'Read more',
                style: TextStyle(
                  color: Color(0xFF00B8D4),
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
