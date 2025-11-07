import 'package:flutter/foundation.dart';
import '../models/user.dart';
import '../models/saved_item.dart';
import '../services/user_service.dart';

enum ProfileState { initial, loading, loaded, error }

class ProfileViewModel extends ChangeNotifier {
  final UserService _userService;

  ProfileState _state = ProfileState.initial;
  User? _currentUser;
  List<SavedItem> _savedItems = [];
  String? _errorMessage;

  ProfileViewModel(this._userService);

  ProfileState get state => _state;
  User? get currentUser => _currentUser;
  List<SavedItem> get savedItems => _savedItems;
  String? get errorMessage => _errorMessage;

  Future<void> loadProfile() async {
    _state = ProfileState.loading;
    _errorMessage = null;
    notifyListeners();

    try {
      _currentUser = await _userService.getCurrentUser();
      _state = ProfileState.loaded;
    } catch (e) {
      _state = ProfileState.error;
      _errorMessage = e.toString();
    }
    notifyListeners();
  }

  Future<void> loadSavedItems() async {
    try {
      _savedItems = await _userService.getSavedItems();
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  Future<bool> updateProfile({String? fullName, String? email}) async {
    _state = ProfileState.loading;
    notifyListeners();

    try {
      _currentUser = await _userService.updateProfile(
        fullName: fullName,
        email: email,
      );
      _state = ProfileState.loaded;
      notifyListeners();
      return true;
    } catch (e) {
      _state = ProfileState.error;
      _errorMessage = e.toString();
      notifyListeners();
      return false;
    }
  }

  Future<bool> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    try {
      await _userService.changePassword(
        currentPassword: currentPassword,
        newPassword: newPassword,
      );
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
      return false;
    }
  }

  Future<bool> saveItem({
    required String title,
    required SavedItemType type,
    String? query,
    String? topicId,
  }) async {
    try {
      final savedItem = await _userService.saveItem(
        title: title,
        type: type,
        query: query,
        topicId: topicId,
      );
      _savedItems.add(savedItem);
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
      return false;
    }
  }

  Future<bool> removeSavedItem(String id) async {
    try {
      await _userService.removeSavedItem(id);
      _savedItems.removeWhere((item) => item.id == id);
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
      return false;
    }
  }

  Future<bool> deleteAccount() async {
    try {
      await _userService.deleteAccount();
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
      return false;
    }
  }
}
