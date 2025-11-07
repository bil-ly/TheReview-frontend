import 'package:flutter/foundation.dart';
import '../models/topic.dart';
import '../models/review.dart';
import '../services/review_service.dart';

enum DashboardState { initial, loading, loaded, error }

class DashboardViewModel extends ChangeNotifier {
  final ReviewService _reviewService;

  DashboardState _state = DashboardState.initial;
  List<Topic> _trendingTopics = [];
  List<Topic> _searchResults = [];
  String? _errorMessage;
  ReviewSource? _selectedSource;

  DashboardViewModel(this._reviewService);

  DashboardState get state => _state;
  List<Topic> get trendingTopics => _trendingTopics;
  List<Topic> get searchResults => _searchResults;
  String? get errorMessage => _errorMessage;
  ReviewSource? get selectedSource => _selectedSource;

  Future<void> loadTrendingTopics() async {
    _state = DashboardState.loading;
    _errorMessage = null;
    notifyListeners();

    try {
      _trendingTopics = await _reviewService.getTrendingTopics();
      _state = DashboardState.loaded;
    } catch (e) {
      _state = DashboardState.error;
      _errorMessage = e.toString();
    }
    notifyListeners();
  }

  Future<void> search(String query) async {
    if (query.trim().isEmpty) {
      _searchResults = [];
      notifyListeners();
      return;
    }

    _state = DashboardState.loading;
    _errorMessage = null;
    notifyListeners();

    try {
      _searchResults = await _reviewService.searchTopics(query);
      _state = DashboardState.loaded;
    } catch (e) {
      _state = DashboardState.error;
      _errorMessage = e.toString();
    }
    notifyListeners();
  }

  void setSelectedSource(ReviewSource? source) {
    _selectedSource = source;
    notifyListeners();
  }

  List<Topic> getFilteredTopics() {
    if (_selectedSource == null) {
      return _trendingTopics;
    }

    return _trendingTopics.where((topic) {
      return topic.reviewsBySource?.containsKey(_selectedSource) ?? false;
    }).toList();
  }

  void clearSearch() {
    _searchResults = [];
    notifyListeners();
  }
}
