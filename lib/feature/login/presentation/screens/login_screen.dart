import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:practiceexams/common/app_bar.dart';
import 'package:practiceexams/core/di/dependency_configuration.dart';
import 'package:practiceexams/core/resources/dimens.dart';
import 'package:practiceexams/core/resources/string_resources.dart';
import 'package:practiceexams/feature/login/data/repositories/login_repository.dart';
import 'package:practiceexams/feature/login/domain/repositories/login_repository_impl.dart';
import 'package:practiceexams/routing/routes.dart';
import '../bloc/login_bloc.dart';
import '../bloc/login_event.dart';
import '../bloc/login_state.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return BlocProvider(
      create: (_) => getIt<LoginBloc>(),
      child: BlocListener<LoginBloc, LoginState>(
        listenWhen: (prev, curr) => curr.isSuccess && !prev.isSuccess,
        listener: (context, state) {
          context.go(BaseRoutes.dashboard);
        },
        child: Scaffold(
            appBar: const CustomAppBar(
              title: 'Login',
              showBack: false,
              showHome: false,
            ),
          body: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: BlocBuilder<LoginBloc, LoginState>(
                builder: (context, state) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        "Welcome Back",
                        style: Theme.of(context).textTheme.headlineSmall,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 24),

                      // Email Field
                      TextField(
                        style: const TextStyle(fontSize: 16),
                        onChanged: (value) =>
                            context.read<LoginBloc>().add(LoginEmailChanged(value)),
                        decoration: const InputDecoration(
                          labelText: "Email",
                          labelStyle: TextStyle(fontSize: 16),
                          border: OutlineInputBorder(),
                          contentPadding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Password Field
                      TextField(
                        obscureText: true,
                        style: const TextStyle(fontSize: 16),
                        onChanged: (value) =>
                            context.read<LoginBloc>().add(LoginPasswordChanged(value)),
                        decoration: const InputDecoration(
                          labelText: "Password",
                          labelStyle: TextStyle(fontSize: 16),
                          border: OutlineInputBorder(),
                          contentPadding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                        ),
                      ),
                      const SizedBox(height: 8),

                      // Forgot Password
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {
                            // TODO: Navigate to forgot password
                          },
                          style: TextButton.styleFrom(
                            foregroundColor: colorScheme.secondary,
                          ),
                          child: const Text("Forgot Password?"),
                        ),
                      ),

                      const SizedBox(height: 16),

                      // Login Button
                      state.isSubmitting
                          ? const Center(child: CircularProgressIndicator())
                          : ElevatedButton(
                        onPressed: () => context.read<LoginBloc>().add(LoginSubmitted()),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: colorScheme.primary,
                          foregroundColor: colorScheme.onPrimary,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                        child: const Text("Login"),
                      ),
                      const SizedBox(height: 12),

                      // Login result
                      if (state.isSuccess)
                        const Text(
                          "Login successful",
                          style: TextStyle(color: Colors.green),
                          textAlign: TextAlign.center,
                        ),
                      if (state.isFailure || state.errorMessage != null)
                        Text(
                          state.errorMessage ?? "Login failed",
                          style: const TextStyle(color: Colors.red),
                          textAlign: TextAlign.center,
                        ),

                      const SizedBox(height: 24),

                      // Register Link
                      Center(
                        child: TextButton(
                          onPressed: () {
                            context.go(BaseRoutes.registration);
                          },
                          style: TextButton.styleFrom(
                            foregroundColor: colorScheme.secondary,
                          ),
                          child: const Text("Don't have an account? Register"),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
