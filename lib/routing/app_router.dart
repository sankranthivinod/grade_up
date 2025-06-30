import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:practiceexams/core/di/dependency_configuration.dart';
import 'package:practiceexams/core/utils/secure_storage_util.dart';
import 'package:practiceexams/feature/dashboard/presentation/screens/dashboard_screen.dart';
import 'package:practiceexams/feature/exam/presentation/bloc/exam_bloc.dart';
import 'package:practiceexams/feature/exam/presentation/bloc/exam_event.dart';
import 'package:practiceexams/feature/exam/presentation/screens/exam_screen.dart';
import 'package:practiceexams/feature/exam/presentation/screens/summary_screen.dart';
import 'package:practiceexams/feature/login/presentation/screens/login_screen.dart';
import 'package:practiceexams/feature/registration/presentation/screens/registration_screen.dart';

import 'routes.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: BaseRoutes.login, // Avoid setting it to "/"
    redirect: (context, state) async {
      // Handle token check here
      if (state.fullPath == BaseRoutes.registration) return null;
      final token = await SecureStorageUtil.readToken();
      final loggingIn = state.fullPath == BaseRoutes.login;

      if (token == null && !loggingIn) return BaseRoutes.login;
      if (token != null && loggingIn) return BaseRoutes.dashboard;
      return null;
    },
    routes: [
      GoRoute(
        path: BaseRoutes.login,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: BaseRoutes.registration,
        builder: (context, state) => const RegistrationScreen(),
      ),
      GoRoute(
        path: BaseRoutes.dashboard,
        builder: (context, state) => const DashboardScreen(),
      ),
      GoRoute(
        path: BaseRoutes.exam,
        builder: (context, state) {
          final args = state.extra as Map<String, String>;
          final email = args['email']!;
          final quizName = args['quizName']!;

          return BlocProvider(
            create: (_) => getIt<ExamBloc>()..add(StartExamEvent(email, quizName)),
            child: ExamScreen(email: email, quizName: quizName),
          );
        },
      ),

      GoRoute(
        path: BaseRoutes.summary,
        builder: (context, state) {
          final args = state.extra as Map<String, dynamic>;
          return SummaryScreen(
            quiz: args['quiz'],
            userAnswers: args['userAnswers'],
          );
        },
      ),
    ],
  );
}