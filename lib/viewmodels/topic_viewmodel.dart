import 'package:flutter/foundation.dart';
import '../models/topic.dart';
import '../models/review.dart';
import '../services/review_service.dart';

enum TopicState { initial, loading, loaded, error }

class TopicViewModel extends ChangeNotifier {
  final ReviewService _reviewService;

  TopicState _state = TopicState.initial;
  Topic? _currentTopic;
  List<Review> _reviews = [];
  ReviewSource? _selectedSource;
  String? _errorMessage;

  TopicViewModel(this._reviewService);

  TopicState get state => _state;
  Topic? get currentTopic => _currentTopic;
  List<Review> get reviews => _reviews;
  ReviewSource? get selectedSource => _selectedSource;
  String? get errorMessage => _errorMessage;

  Future<void> loadTopic(String topicId) async {
    _state = TopicState.loading;
    _errorMessage = null;
    notifyListeners();

    try {
      _currentTopic = await _reviewService.getTopicById(topicId);
      await loadReviews(topicId);
      _state = TopicState.loaded;
    } catch (e) {
      _state = TopicState.error;
      _errorMessage = e.toString();
    }
    notifyListeners();
  }

  Future<void> loadReviews(String topicId, {ReviewSource? source}) async {
    try {
      _reviews = await _reviewService.getReviewsForTopic(
        topicId,
        source: source,
      );
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  void setSelectedSource(ReviewSource? source) {
    _selectedSource = source;
    if (_currentTopic != null) {
      loadReviews(_currentTopic!.id, source: source);
    }
  }

  List<Review> getFilteredReviews() {
    if (_selectedSource == null) {
      return _reviews;
    }
    return _reviews.where((review) => review.source == _selectedSource).toList();
  }

  void clear() {
    _currentTopic = null;
    _reviews = [];
    _selectedSource = null;
    _state = TopicState.initial;
    notifyListeners();
  }
}
