import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:practiceexams/feature/exam/domain/entities/quiz_entity.dart';
import 'package:practiceexams/feature/exam/presentation/bloc/exam_bloc.dart';
import 'package:practiceexams/feature/exam/presentation/bloc/exam_event.dart';
import 'package:practiceexams/feature/exam/presentation/bloc/exam_state.dart';
import 'package:practiceexams/routing/routes.dart';

class ExamScreen extends StatefulWidget {
  final String quizName;
  final String email;

  const ExamScreen({
    super.key,
    required this.quizName,
    required this.email,
  });

  @override
  State<ExamScreen> createState() => _ExamScreenState();
}

class _ExamScreenState extends State<ExamScreen> {
  QuizEntity? _quiz;
  int _currentIndex = 0;
  Map<int, String> _selectedAnswers = {};
  Map<int, List<String>> _shuffledChoices = {};
  Timer? _timer;
  int _secondsLeft = 0;
  bool _timerStarted = false;

  @override
  void initState() {
    super.initState();
    context.read<ExamBloc>().add(StartExamEvent(widget.email, widget.quizName));
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void startTimer(int minutes) {
    if (_timerStarted) return;
    _timerStarted = true;
    _secondsLeft = minutes * 60;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsLeft <= 0) {
        timer.cancel();
        _goToSummary();
      } else {
        setState(() => _secondsLeft--);
      }
    });
  }

  void _goToSummary() {
    context.go(
      BaseRoutes.summary,
      extra: {
        'quiz': _quiz,
        'userAnswers': _selectedAnswers,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ExamBloc, ExamState>(
      listener: (context, state) {
        if (state is ExamLoaded) {
          setState(() {
            _quiz = state.quiz;

            _shuffledChoices = {
              for (int i = 0; i < state.quiz.questions.length; i++)
                i: [
                  state.quiz.questions[i].correctAnswer,
                  ...state.quiz.questions[i].incorrectAnswers.split('~').map((e) => e.trim())
                ]..shuffle()
            };
          });

          startTimer(state.quiz.duration);
        }
      },
      builder: (context, state) {
        if (_quiz == null || state is ExamLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final question = _quiz!.questions[_currentIndex];
        final selected = _selectedAnswers[_currentIndex];
        final choices = _shuffledChoices[_currentIndex]!;

        return Scaffold(
          appBar: AppBar(
            title: Text(_quiz!.quizName),
            actions: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Center(
                  child: Text(
                    _formatTime(_secondsLeft),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Q${_currentIndex + 1}: ${question.question}',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 20),
                ...choices.map((choice) => RadioListTile<String>(
                  value: choice,
                  groupValue: selected,
                  title: Text(
                    choice,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  onChanged: (val) {
                    setState(() {
                      _selectedAnswers[_currentIndex] = val!;
                    });
                  },
                )),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (_currentIndex > 0)
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _currentIndex--;
                          });
                        },
                        child: const Text("Previous"),
                      ),
                    if (_currentIndex < _quiz!.questions.length - 1)
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _currentIndex++;
                          });
                        },
                        child: const Text("Next"),
                      ),
                    if (_currentIndex == _quiz!.questions.length - 1)
                      ElevatedButton(
                        onPressed: _goToSummary,
                        child: const Text("Submit"),
                      ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  String _formatTime(int seconds) {
    final minutes = seconds ~/ 60;
    final sec = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${sec.toString().padLeft(2, '0')}';
  }
}
