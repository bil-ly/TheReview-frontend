import '../models/review.dart';
import '../models/topic.dart';
import 'api_service.dart';

class ReviewService {
  final ApiService _apiService;

  ReviewService(this._apiService);

  Future<List<Topic>> getTrendingTopics() async {
    try {
      final response = await _apiService.get('/topics/trending');
      return (response as List)
          .map((json) => Topic.fromJson(json))
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch trending topics: $e');
    }
  }

  Future<Topic> getTopicById(String id) async {
    try {
      final response = await _apiService.get('/topics/$id');
      return Topic.fromJson(response);
    } catch (e) {
      throw Exception('Failed to fetch topic: $e');
    }
  }

  Future<List<Review>> getReviewsForTopic(
    String topicId, {
    ReviewSource? source,
  }) async {
    try {
      String endpoint = '/topics/$topicId/reviews';
      if (source != null) {
        endpoint += '?source=${source.name}';
      }

      final response = await _apiService.get(endpoint);
      return (response as List)
          .map((json) => Review.fromJson(json))
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch reviews: $e');
    }
  }

  Future<List<Topic>> searchTopics(String query) async {
    try {
      final response = await _apiService.get('/search?q=$query');
      return (response as List)
          .map((json) => Topic.fromJson(json))
          .toList();
    } catch (e) {
      throw Exception('Failed to search: $e');
    }
  }

  Future<Map<ReviewSource, List<Review>>> getReviewsBySource(
    String topicId,
  ) async {
    try {
      final response = await _apiService.get('/topics/$topicId/reviews/grouped');
      final Map<ReviewSource, List<Review>> result = {};

      (response as Map<String, dynamic>).forEach((key, value) {
        final source = ReviewSource.values.firstWhere(
          (s) => s.name == key,
          orElse: () => ReviewSource.google,
        );
        result[source] = (value as List)
            .map((json) => Review.fromJson(json))
            .toList();
      });

      return result;
    } catch (e) {
      throw Exception('Failed to fetch grouped reviews: $e');
    }
  }
}
