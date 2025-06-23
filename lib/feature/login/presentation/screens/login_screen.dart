import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
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
          appBar: AppBar(title: Text(StringRes.login)),
          body: Padding(
            padding: const EdgeInsets.all(Dimens.dp16),
            child: BlocBuilder<LoginBloc, LoginState>(
              builder: (context, state) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextField(
                      onChanged: (value) => context
                          .read<LoginBloc>()
                          .add(LoginEmailChanged(value)),
                      decoration: InputDecoration(labelText: StringRes.email),
                    ),
                    const SizedBox(height: Dimens.dp14),
                    TextField(
                      obscureText: true,
                      onChanged: (value) => context
                          .read<LoginBloc>()
                          .add(LoginPasswordChanged(value)),
                      decoration:
                      InputDecoration(labelText: StringRes.password),
                    ),
                    const SizedBox(height: Dimens.dp20),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          // TODO: Navigate to Forgot Password screen
                        },
                        style: TextButton.styleFrom(
                          foregroundColor: colorScheme.secondary,
                        ),
                        child: Text(StringRes.forgotPassword),
                      ),
                    ),
                    const SizedBox(height: Dimens.dp15),
                    state.isSubmitting
                        ? const Center(child: CircularProgressIndicator())
                        : ElevatedButton(
                      onPressed: () => context
                          .read<LoginBloc>()
                          .add(LoginSubmitted()),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: colorScheme.primary,
                        foregroundColor: colorScheme.onPrimary,
                      ),
                      child: Text(StringRes.login),
                    ),
                    const SizedBox(height: Dimens.dp15),
                    if (state.isSuccess)
                      Text(
                        StringRes.loginSuccess,
                        style: const TextStyle(color: Colors.green),
                        textAlign: TextAlign.center,
                      ),
                    if (state.isFailure || state.errorMessage != null)
                      Text(
                        state.errorMessage ?? StringRes.loginFailed,
                        style: const TextStyle(color: Colors.red),
                        textAlign: TextAlign.center,
                      ),
                    const Spacer(),
                    Center(
                      child: TextButton(
                        onPressed: () {
                          context.go(BaseRoutes.registration);
                        },
                        style: TextButton.styleFrom(
                          foregroundColor: colorScheme.secondary,
                        ),
                        child: Text(StringRes.registerLink),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
