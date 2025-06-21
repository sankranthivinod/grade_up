import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practiceexams/core/resources/dimens.dart';
import 'package:practiceexams/core/resources/string_resources.dart';

import '../../bloc/registration_bloc.dart';
import '../../bloc/registration_event.dart';
import '../../bloc/registration_state.dart';
import '../../repository/registration_repository.dart';


class RegistrationScreen extends StatelessWidget {
  const RegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => RegisterBloc(registrationRepository: RegistrationRepository()),
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
      body: SafeArea(
        child: BlocListener<RegisterBloc, RegisterState>(
          listener: (context, state) {
            if (state.isFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.errorMessage ?? StringRes.registrationFailed)),
              );
            } else if (state.isSuccess) {
              Navigator.pushReplacementNamed(context, '/dashboard');
            }
          },
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(Dimens.dp16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  StringRes.registrationHeading,
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: Dimens.dp20),

                _buildTextField(label: StringRes.name, onChanged: (v) => context.read<RegisterBloc>().add(NameChanged(name: v))),
                _buildTextField(label: StringRes.email, onChanged: (v) => context.read<RegisterBloc>().add(EmailChanged(email: v))),
                _buildTextField(
                  label: StringRes.phone,
                  keyboardType: TextInputType.phone,
                  onChanged: (v) => context.read<RegisterBloc>().add(PhoneChanged(phone: v)),
                ),
                _buildTextField(
                  label: StringRes.password,
                  obscure: true,
                  onChanged: (v) => context.read<RegisterBloc>().add(PasswordChanged(password: v)),
                ),
                _buildTextField(
                  label: StringRes.confirmPassword,
                  obscure: true,
                  onChanged: (v) => context.read<RegisterBloc>().add(ConfirmPasswordChanged(confirmPassword: v)),
                ),

                const Text(StringRes.studentClass),
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
                const SizedBox(height: Dimens.dp20),

                BlocBuilder<RegisterBloc, RegisterState>(
                  builder: (context, state) {
                    return state.isSubmitting
                        ? const Center(child: CircularProgressIndicator())
                        : SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () => context.read<RegisterBloc>().add(RegisterSubmitted()),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: colorScheme.primary,
                          foregroundColor: colorScheme.onPrimary,
                        ),
                        child: const Text(StringRes.signUp),
                      ),
                    );
                  },
                ),
                const SizedBox(height: Dimens.dp12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(StringRes.alreadyHaveAccount),
                    GestureDetector(
                      onTap: () => Navigator.pushNamed(context, '/login'),
                      child: Text(
                        StringRes.signIn,
                        style: TextStyle(color: colorScheme.secondary),
                      ),
                    ),
                  ],
                ),
              ],
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        const SizedBox(height: Dimens.dp12),
        TextField(
          obscureText: obscure,
          keyboardType: keyboardType,
          onChanged: onChanged,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          ),
        ),
        const SizedBox(height: Dimens.dp14),
      ],
    );
  }
}
