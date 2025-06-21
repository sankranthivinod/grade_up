import 'package:flutter/material.dart';
import '../routing/app_router.dart';
import 'core/resources/string_resources.dart';
import 'core/styles/theme.dart';
class GradeUpApp extends StatelessWidget {
  const GradeUpApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: StringRes.appTitle,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.system,
      routerConfig: AppRouter.router, // Using GoRouter's configuration
    );
  }
}
