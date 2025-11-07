class AppConstants {
  // API Configuration
  static const String apiBaseUrl = 'http://localhost:8000/api';
  static const int apiTimeoutSeconds = 30;

  // App Information
  static const String appName = 'ReviewApp';
  static const String appVersion = '1.0.0';

  // Pagination
  static const int itemsPerPage = 20;

  // Storage Keys
  static const String authTokenKey = 'auth_token';
  static const String userDataKey = 'user_data';
  static const String themeKey = 'theme_mode';

  // Routes
  static const String welcomeRoute = '/';
  static const String loginRoute = '/login';
  static const String registerRoute = '/register';
  static const String dashboardRoute = '/dashboard';
  static const String topicRoute = '/topic';
  static const String profileRoute = '/profile';
  static const String settingsRoute = '/settings';
  static const String searchRoute = '/search';

  // Social Auth Providers
  static const List<String> socialProviders = ['google', 'linkedin', 'twitter'];

  // Review Sources
  static const List<String> reviewSources = [
    'Google',
    'TripAdvisor',
    'Twitter',
    'LinkedIn',
  ];

  // Validation
  static const int minPasswordLength = 8;
  static const int maxPasswordLength = 128;
  static const int minNameLength = 2;
  static const int maxNameLength = 100;
}
