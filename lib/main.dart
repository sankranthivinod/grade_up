import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'core/di/dependency_configuration.dart';
import 'grade_up_app.dart';

void main() {
  runApp(const _AppBootstrapper());
}

class _AppBootstrapper extends StatelessWidget {
  const _AppBootstrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initializeApp(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const MaterialApp(
            home: Scaffold(body: Center(child: CircularProgressIndicator())),
          );
        } else if (snapshot.hasError) {
          return MaterialApp(
            home: Scaffold(body: Center(child: Text('Error: ${snapshot.error}'))),
          );
        } else {
          return const GradeUpApp();
        }
      },
    );
  }

  Future<void> _initializeApp() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    await setupDependencies();
  }
}
