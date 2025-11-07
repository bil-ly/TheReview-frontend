enum ReviewSource {
  google,
  twitter,
  linkedin,
  tripAdvisor,
}

enum ReviewSentiment {
  positive,
  neutral,
  negative,
}

class Review {
  final String id;
  final String authorName;
  final String? authorUsername;
  final String? authorImageUrl;
  final ReviewSource source;
  final double? rating;
  final ReviewSentiment? sentiment;
  final String content;
  final DateTime createdAt;
  final String targetId;
  final String targetName;

  Review({
    required this.id,
    required this.authorName,
    this.authorUsername,
    this.authorImageUrl,
    required this.source,
    this.rating,
    this.sentiment,
    required this.content,
    required this.createdAt,
    required this.targetId,
    required this.targetName,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      id: json['id'] as String,
      authorName: json['authorName'] as String,
      authorUsername: json['authorUsername'] as String?,
      authorImageUrl: json['authorImageUrl'] as String?,
      source: ReviewSource.values.firstWhere(
        (e) => e.name == json['source'],
        orElse: () => ReviewSource.google,
      ),
      rating: (json['rating'] as num?)?.toDouble(),
      sentiment: json['sentiment'] != null
          ? ReviewSentiment.values.firstWhere(
              (e) => e.name == json['sentiment'],
              orElse: () => ReviewSentiment.neutral,
            )
          : null,
      content: json['content'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      targetId: json['targetId'] as String,
      targetName: json['targetName'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'authorName': authorName,
      'authorUsername': authorUsername,
      'authorImageUrl': authorImageUrl,
      'source': source.name,
      'rating': rating,
      'sentiment': sentiment?.name,
      'content': content,
      'createdAt': createdAt.toIso8601String(),
      'targetId': targetId,
      'targetName': targetName,
    };
  }

  String get timeAgo {
    final now = DateTime.now();
    final difference = now.difference(createdAt);

    if (difference.inDays > 365) {
      return '${(difference.inDays / 365).floor()} year${difference.inDays > 730 ? 's' : ''} ago';
    } else if (difference.inDays > 30) {
      return '${(difference.inDays / 30).floor()} month${difference.inDays > 60 ? 's' : ''} ago';
    } else if (difference.inDays > 7) {
      return '${(difference.inDays / 7).floor()} week${difference.inDays > 14 ? 's' : ''} ago';
    } else if (difference.inDays > 0) {
      return '${difference.inDays} day${difference.inDays > 1 ? 's' : ''} ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} hour${difference.inHours > 1 ? 's' : ''} ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} minute${difference.inMinutes > 1 ? 's' : ''} ago';
    } else {
      return 'Just now';
    }
  }
}
