import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/di/dependency_configuration.dart';
import 'feature/login/presentation/bloc/login_bloc.dart';
import 'grade_up_app.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await setupDependencies();
  await Future.delayed(const Duration(seconds: 3));
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
          return BlocProvider<LoginBloc>.value(
            value: getIt<LoginBloc>(),
            child: const GradeUpApp(),
          );        }
      },
    );
  }

  Future<void> _initializeApp() async {
    // await Firebase.initializeApp();
    // await setupDependencies();
  }
}
