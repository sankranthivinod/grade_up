import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:practiceexams/common/app_bar.dart';
import 'package:practiceexams/core/resources/dimens.dart';
import 'package:practiceexams/core/resources/string_resources.dart';
import 'package:practiceexams/feature/registration/domain/repositories/registration_repository_impl.dart';
import 'package:practiceexams/feature/registration/presentation/bloc/registration_bloc.dart';
import 'package:practiceexams/feature/registration/presentation/bloc/registration_event.dart';
import 'package:practiceexams/feature/registration/presentation/bloc/registration_state.dart';
import 'package:practiceexams/routing/routes.dart';

class RegistrationScreen extends StatelessWidget {
  const RegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => RegisterBloc(
        registrationRepository: RegistrationRepositoryImpl(),
      ),
      child: const _RegisterForm(),
    );
  }
}

class _RegisterForm extends StatelessWidget {
  const _RegisterForm({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final state = context.watch<RegisterBloc>().state;

    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Registration',
        showBack: true,
        showHome: false,
        homeRoute: BaseRoutes.login,
      ),      body: SafeArea(
        child: BlocListener<RegisterBloc, RegisterState>(
          listener: (context, state) {
            if (state.isFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.errorMessage ?? StringRes.registrationFailed)),
              );
            } else if (state.isSuccess) {
              context.go(BaseRoutes.dashboard);
            }
          },
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    "Create Your Account",
                    style: Theme.of(context).textTheme.headlineSmall,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),

                  _buildTextField(
                    label: StringRes.name,
                    onChanged: (v) =>
                        context.read<RegisterBloc>().add(NameChanged(name: v)),
                  ),
                  _buildTextField(
                    label: StringRes.email,
                    onChanged: (v) =>
                        context.read<RegisterBloc>().add(EmailChanged(email: v)),
                  ),
                  _buildTextField(
                    label: StringRes.phone,
                    keyboardType: TextInputType.phone,
                    onChanged: (v) =>
                        context.read<RegisterBloc>().add(PhoneChanged(phone: v)),
                  ),
                  _buildTextField(
                    label: StringRes.password,
                    obscure: true,
                    onChanged: (v) =>
                        context.read<RegisterBloc>().add(PasswordChanged(password: v)),
                  ),
                  _buildTextField(
                    label: StringRes.confirmPassword,
                    obscure: true,
                    onChanged: (v) => context
                        .read<RegisterBloc>()
                        .add(ConfirmPasswordChanged(confirmPassword: v)),
                  ),

                  const SizedBox(height: 8),
                  Text(
                    StringRes.studentClass,
                    style: const TextStyle(fontSize: 16),
                  ),
                  DropdownButton<String>(
                    isExpanded: true,
                    value: state.studentClass,
                    onChanged: (value) {
                      if (value != null) {
                        context.read<RegisterBloc>().add(ClassChanged(studentClass: value));
                      }
                    },
                    items: StringRes.classList
                        .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                        .toList(),
                  ),

                  const SizedBox(height: 24),
                  state.isSubmitting
                      ? const Center(child: CircularProgressIndicator())
                      : SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => context.read<RegisterBloc>().add(RegisterSubmitted()),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: colorScheme.primary,
                        foregroundColor: colorScheme.onPrimary,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: const Text(StringRes.signUp),
                    ),
                  ),
                  const SizedBox(height: 20),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(StringRes.alreadyHaveAccount),
                      TextButton(
                        onPressed: () => context.go(BaseRoutes.login),
                        style: TextButton.styleFrom(
                          foregroundColor: colorScheme.secondary,
                        ),
                        child: Text(StringRes.signIn),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    bool obscure = false,
    TextInputType keyboardType = TextInputType.text,
    required Function(String) onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextField(
        obscureText: obscure,
        keyboardType: keyboardType,
        onChanged: onChanged,
        style: const TextStyle(fontSize: 16),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(fontSize: 16),
          border: const OutlineInputBorder(),
          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        ),
      ),
    );
  }
}
