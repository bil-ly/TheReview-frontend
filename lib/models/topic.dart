import 'review.dart';

class Topic {
  final String id;
  final String name;
  final String? description;
  final String? iconUrl;
  final int totalReviews;
  final double? overallRating;
  final Map<ReviewSource, int>? reviewsBySource;
  final Map<ReviewSource, double>? ratingsBySource;
  final ReviewStats? stats;

  Topic({
    required this.id,
    required this.name,
    this.description,
    this.iconUrl,
    required this.totalReviews,
    this.overallRating,
    this.reviewsBySource,
    this.ratingsBySource,
    this.stats,
  });

  factory Topic.fromJson(Map<String, dynamic> json) {
    return Topic(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      iconUrl: json['iconUrl'] as String?,
      totalReviews: json['totalReviews'] as int,
      overallRating: (json['overallRating'] as num?)?.toDouble(),
      reviewsBySource: json['reviewsBySource'] != null
          ? (json['reviewsBySource'] as Map<String, dynamic>).map(
              (key, value) => MapEntry(
                ReviewSource.values.firstWhere((e) => e.name == key),
                value as int,
              ),
            )
          : null,
      ratingsBySource: json['ratingsBySource'] != null
          ? (json['ratingsBySource'] as Map<String, dynamic>).map(
              (key, value) => MapEntry(
                ReviewSource.values.firstWhere((e) => e.name == key),
                (value as num).toDouble(),
              ),
            )
          : null,
      stats: json['stats'] != null
          ? ReviewStats.fromJson(json['stats'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'iconUrl': iconUrl,
      'totalReviews': totalReviews,
      'overallRating': overallRating,
      'reviewsBySource': reviewsBySource?.map((k, v) => MapEntry(k.name, v)),
      'ratingsBySource': ratingsBySource?.map((k, v) => MapEntry(k.name, v)),
      'stats': stats?.toJson(),
    };
  }
}

class ReviewStats {
  final int positiveCount;
  final int neutralCount;
  final int negativeCount;

  ReviewStats({
    required this.positiveCount,
    required this.neutralCount,
    required this.negativeCount,
  });

  int get total => positiveCount + neutralCount + negativeCount;

  double get positivePercentage =>
      total > 0 ? (positiveCount / total) * 100 : 0;

  double get neutralPercentage =>
      total > 0 ? (neutralCount / total) * 100 : 0;

  double get negativePercentage =>
      total > 0 ? (negativeCount / total) * 100 : 0;

  factory ReviewStats.fromJson(Map<String, dynamic> json) {
    return ReviewStats(
      positiveCount: json['positiveCount'] as int,
      neutralCount: json['neutralCount'] as int,
      negativeCount: json['negativeCount'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'positiveCount': positiveCount,
      'neutralCount': neutralCount,
      'negativeCount': negativeCount,
    };
  }
}
