import 'package:shared_preferences/shared_preferences.dart';
import '../models/user.dart';
import 'api_service.dart';

class AuthService {
  final ApiService _apiService;
  static const String _tokenKey = 'auth_token';

  AuthService(this._apiService);

  Future<User> login(String email, String password) async {
    try {
      final response = await _apiService.post('/auth/login', {
        'email': email,
        'password': password,
      });

      final token = response['token'];
      final userData = response['user'];

      await _saveToken(token);
      _apiService.setAuthToken(token);

      return User.fromJson(userData);
    } catch (e) {
      throw Exception('Login failed: $e');
    }
  }

  Future<User> register({
    required String fullName,
    required String email,
    required String password,
  }) async {
    try {
      final response = await _apiService.post('/auth/register', {
        'fullName': fullName,
        'email': email,
        'password': password,
      });

      final token = response['token'];
      final userData = response['user'];

      await _saveToken(token);
      _apiService.setAuthToken(token);

      return User.fromJson(userData);
    } catch (e) {
      throw Exception('Registration failed: $e');
    }
  }

  Future<void> logout() async {
    await _clearToken();
    _apiService.clearAuthToken();
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  Future<void> _saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
  }

  Future<void> _clearToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
  }

  Future<bool> isLoggedIn() async {
    final token = await getToken();
    return token != null;
  }
}
