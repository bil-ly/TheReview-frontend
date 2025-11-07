import 'package:flutter/foundation.dart';
import '../models/user.dart';
import '../services/auth_service.dart';

enum AuthState { initial, loading, authenticated, unauthenticated, error }

class AuthViewModel extends ChangeNotifier {
  final AuthService _authService;

  AuthState _state = AuthState.initial;
  User? _currentUser;
  String? _errorMessage;

  AuthViewModel(this._authService);

  AuthState get state => _state;
  User? get currentUser => _currentUser;
  String? get errorMessage => _errorMessage;
  bool get isAuthenticated => _state == AuthState.authenticated;

  Future<void> checkAuthStatus() async {
    _state = AuthState.loading;
    notifyListeners();

    try {
      final isLoggedIn = await _authService.isLoggedIn();
      if (isLoggedIn) {
        _state = AuthState.authenticated;
      } else {
        _state = AuthState.unauthenticated;
      }
    } catch (e) {
      _state = AuthState.unauthenticated;
    }
    notifyListeners();
  }

  Future<bool> login(String email, String password) async {
    _state = AuthState.loading;
    _errorMessage = null;
    notifyListeners();

    try {
      _currentUser = await _authService.login(email, password);
      _state = AuthState.authenticated;
      notifyListeners();
      return true;
    } catch (e) {
      _state = AuthState.error;
      _errorMessage = e.toString();
      notifyListeners();
      return false;
    }
  }

  Future<bool> register({
    required String fullName,
    required String email,
    required String password,
  }) async {
    _state = AuthState.loading;
    _errorMessage = null;
    notifyListeners();

    try {
      _currentUser = await _authService.register(
        fullName: fullName,
        email: email,
        password: password,
      );
      _state = AuthState.authenticated;
      notifyListeners();
      return true;
    } catch (e) {
      _state = AuthState.error;
      _errorMessage = e.toString();
      notifyListeners();
      return false;
    }
  }

  Future<void> logout() async {
    await _authService.logout();
    _currentUser = null;
    _state = AuthState.unauthenticated;
    notifyListeners();
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}
