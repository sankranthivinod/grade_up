import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practiceexams/core/di/dependency_configuration.dart';
import 'package:practiceexams/core/resources/constants.dart';
import 'package:practiceexams/core/utils/secure_storage_util.dart';
import 'package:practiceexams/feature/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:practiceexams/feature/dashboard/presentation/bloc/dashboard_event.dart';
import 'package:practiceexams/feature/dashboard/presentation/bloc/dashboard_state.dart';
import 'package:practiceexams/feature/login/data/models/user_model.dart';
import 'package:practiceexams/feature/login/domain/dao/user_dao.dart';


class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  String? selectedSubject;
  String? selectedQuiz;
  List<String> quizList = [];
  UserModel? user;

  @override
  void initState() {
    super.initState();
    loadUserAndInitialize();
  }

  Future<void> loadUserAndInitialize() async {
    final userDao = getIt<UserDao>();
    final userList = await userDao.getUsers();
    if (userList.isNotEmpty) {
      setState(() {
        user = userList.first;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    if (user == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome back ${user!.name}',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 24),
            Text('Select type', style: TextStyle(color: colorScheme.onSurface)),
            DropdownButton<String>(
              value: selectedSubject,
              hint: const Text("Choose Subject"),
              isExpanded: true,
              items: user!.subjects.map((subj) {
                return DropdownMenuItem(value: subj, child: Text(subj));
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedSubject = value;
                  selectedQuiz = null;
                });
                context
                    .read<DashboardBloc>()
                    .add(DashboardLoadQuizzes(user!.email, value!));
              },
            ),
            const SizedBox(height: 24),
            Text('Select Exam From List',
                style: TextStyle(color: colorScheme.onSurface)),
            BlocConsumer<DashboardBloc, DashboardState>(
              listener: (context, state) {
                if (state is DashboardLoaded) {
                  setState(() {
                    quizList = state.quizList;
                  });
                }
              },
              builder: (context, state) {
                if (state is DashboardLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is DashboardError) {
                  return Text(state.message,
                      style: const TextStyle(color: Colors.red));
                }

                return DropdownButton<String>(
                  value: selectedQuiz,
                  isExpanded: true,
                  hint: const Text("Choose Quiz"),
                  items: quizList.map((q) {
                    return DropdownMenuItem(value: q, child: Text(q));
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedQuiz = value;
                    });
                  },
                );
              },
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: selectedQuiz != null
                  ? () {
                // TODO: Navigate to exam screen
                // context.go('/exam/${selectedQuiz}');
              }
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: selectedQuiz != null
                    ? colorScheme.tertiary
                    : colorScheme.surface,
                foregroundColor: colorScheme.onTertiary,
                shape: const StadiumBorder(),
                minimumSize: const Size.fromHeight(48),
              ),
              child: const Text('Begin Test'),
            ),
          ],
        ),
      ),
    );
  }
}