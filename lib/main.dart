import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Services
import 'services/api_service.dart';
import 'services/auth_service.dart';
import 'services/review_service.dart';
import 'services/user_service.dart';

// ViewModels
import 'viewmodels/auth_viewmodel.dart';
import 'viewmodels/dashboard_viewmodel.dart';
import 'viewmodels/topic_viewmodel.dart';
import 'viewmodels/profile_viewmodel.dart';

// Core
import 'core/theme.dart';
import 'core/router.dart';
import 'core/constants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize services (Singleton pattern)
    final apiService = ApiService();
    final authService = AuthService(apiService);
    final reviewService = ReviewService(apiService);
    final userService = UserService(apiService);

    return MultiProvider(
      providers: [
        // Provide services
        Provider<ApiService>.value(value: apiService),
        Provider<AuthService>.value(value: authService),
        Provider<ReviewService>.value(value: reviewService),
        Provider<UserService>.value(value: userService),

        // Provide ViewModels with ChangeNotifierProvider for state management
        ChangeNotifierProvider<AuthViewModel>(
          create: (_) => AuthViewModel(authService)..checkAuthStatus(),
        ),
        ChangeNotifierProvider<DashboardViewModel>(
          create: (_) => DashboardViewModel(reviewService),
        ),
        ChangeNotifierProvider<TopicViewModel>(
          create: (_) => TopicViewModel(reviewService),
        ),
        ChangeNotifierProvider<ProfileViewModel>(
          create: (_) => ProfileViewModel(userService),
        ),
      ],
      child: Consumer<AuthViewModel>(
        builder: (context, authViewModel, child) {
          return MaterialApp.router(
            title: AppConstants.appName,
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: ThemeMode.dark, // Use dark theme by default
            routerConfig: AppRouter.createRouter(
              isAuthenticated: authViewModel.isAuthenticated,
            ),
          );
        },
      ),
    );
  }
}
