import 'package:shared_preferences/shared_preferences.dart';
import 'api_service.dart';

class AuthService {
  final ApiService _apiService;
  static const String _tokenKey = 'auth_token';

  AuthService(this._apiService);

  Future<String> login(String username, String password) async {
    try {
      final response = await _apiService.post('/auth/login', {
        'username': username,
        'password': password,
      });

      final token = response['access_token'];

      await _saveToken(token);
      _apiService.setAuthToken(token);

      return token;
    } catch (e) {
      throw Exception('Login failed: $e');
    }
  }

  Future<String> register({
    required String username,
    required String fullName,
    required String email,
    required String password,
  }) async {
    try {
      final response = await _apiService.post('/auth/register', {
        'username': username,
        'full_name': fullName,
        'email': email,
        'password': password,
      });

      final userId = response['user_id'];

      // After successful registration, auto-login the user
      await login(username, password);

      return userId;
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
