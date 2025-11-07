import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../views/screens/welcome_screen.dart';
import '../views/screens/login_screen.dart';
import '../views/screens/register_screen.dart';
import '../views/screens/dashboard_screen.dart';
import '../views/screens/topic_screen.dart';
import '../views/screens/profile_screen.dart';
import '../views/screens/settings_screen.dart';
import 'constants.dart';

class AppRouter {
  static GoRouter createRouter({required bool isAuthenticated}) {
    return GoRouter(
      initialLocation: isAuthenticated
          ? AppConstants.dashboardRoute
          : AppConstants.welcomeRoute,
      redirect: (BuildContext context, GoRouterState state) {
        final isOnWelcome = state.matchedLocation == AppConstants.welcomeRoute;
        final isOnLogin = state.matchedLocation == AppConstants.loginRoute;
        final isOnRegister = state.matchedLocation == AppConstants.registerRoute;

        // If not authenticated and trying to access protected routes
        if (!isAuthenticated && !isOnWelcome && !isOnLogin && !isOnRegister) {
          return AppConstants.welcomeRoute;
        }

        // If authenticated and on auth screens, redirect to dashboard
        if (isAuthenticated && (isOnWelcome || isOnLogin || isOnRegister)) {
          return AppConstants.dashboardRoute;
        }

        return null; // No redirect needed
      },
      routes: [
        GoRoute(
          path: AppConstants.welcomeRoute,
          builder: (context, state) => const WelcomeScreen(),
        ),
        GoRoute(
          path: AppConstants.loginRoute,
          builder: (context, state) => const LoginScreen(),
        ),
        GoRoute(
          path: AppConstants.registerRoute,
          builder: (context, state) => const RegisterScreen(),
        ),
        GoRoute(
          path: AppConstants.dashboardRoute,
          builder: (context, state) => const DashboardScreen(),
        ),
        GoRoute(
          path: '${AppConstants.topicRoute}/:id',
          builder: (context, state) {
            final id = state.pathParameters['id']!;
            return TopicScreen(topicId: id);
          },
        ),
        GoRoute(
          path: AppConstants.profileRoute,
          builder: (context, state) => const ProfileScreen(),
        ),
        GoRoute(
          path: AppConstants.settingsRoute,
          builder: (context, state) => const SettingsScreen(),
        ),
      ],
      errorBuilder: (context, state) => Scaffold(
        body: Center(
          child: Text('Page not found: ${state.uri}'),
        ),
      ),
    );
  }
}
