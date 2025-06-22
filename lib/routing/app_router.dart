import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:practiceexams/feature/dashboard/screens/dashboard_screen.dart';
import 'package:practiceexams/feature/login/presentation/screens/login_screen.dart';
import 'package:practiceexams/feature/registration/presentation/screens/registration_screen.dart';

import 'routes.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: BaseRoutes.root,
    routes: [
      // Redirect root to login
      GoRoute(
        path: BaseRoutes.root,
        redirect: (_, __) => BaseRoutes.login,
      ),

      // Login screen
      GoRoute(
        path: BaseRoutes.login,
        builder: (context, state) => const LoginScreen(),
      ),

      // Registration screen
      GoRoute(
        path: BaseRoutes.registration,
        builder: (context, state) => const RegistrationScreen(),
      ),

      // Dashboard screen
      GoRoute(
        path: BaseRoutes.dashboard,
        builder: (context, state) => const DashboardScreen(),
      ),
    ],
  );
}
