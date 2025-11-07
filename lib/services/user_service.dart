import '../models/user.dart';
import '../models/saved_item.dart';
import 'api_service.dart';

class UserService {
  final ApiService _apiService;

  UserService(this._apiService);

  Future<User> getCurrentUser() async {
    try {
      final response = await _apiService.get('/user/profile');
      return User.fromJson(response);
    } catch (e) {
      throw Exception('Failed to fetch user profile: $e');
    }
  }

  Future<User> updateProfile({
    String? fullName,
    String? email,
  }) async {
    try {
      final response = await _apiService.put('/user/profile', {
        if (fullName != null) 'fullName': fullName,
        if (email != null) 'email': email,
      });
      return User.fromJson(response);
    } catch (e) {
      throw Exception('Failed to update profile: $e');
    }
  }

  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    try {
      await _apiService.post('/user/change-password', {
        'currentPassword': currentPassword,
        'newPassword': newPassword,
      });
    } catch (e) {
      throw Exception('Failed to change password: $e');
    }
  }

  Future<void> deleteAccount() async {
    try {
      await _apiService.delete('/user/account');
    } catch (e) {
      throw Exception('Failed to delete account: $e');
    }
  }

  Future<List<SavedItem>> getSavedItems() async {
    try {
      final response = await _apiService.get('/user/saved');
      return (response as List)
          .map((json) => SavedItem.fromJson(json))
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch saved items: $e');
    }
  }

  Future<SavedItem> saveItem({
    required String title,
    required SavedItemType type,
    String? query,
    String? topicId,
  }) async {
    try {
      final response = await _apiService.post('/user/saved', {
        'title': title,
        'type': type.name,
        if (query != null) 'query': query,
        if (topicId != null) 'topicId': topicId,
      });
      return SavedItem.fromJson(response);
    } catch (e) {
      throw Exception('Failed to save item: $e');
    }
  }

  Future<void> removeSavedItem(String id) async {
    try {
      await _apiService.delete('/user/saved/$id');
    } catch (e) {
      throw Exception('Failed to remove saved item: $e');
    }
  }
}
