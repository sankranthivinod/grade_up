import 'package:flutter/material.dart';
import 'package:practiceexams/common/app_bar.dart';
import 'package:practiceexams/feature/exam/domain/entities/question_entity.dart';
import 'package:practiceexams/feature/exam/domain/entities/quiz_entity.dart';
import 'package:practiceexams/routing/routes.dart';

class SummaryScreen extends StatelessWidget {
  final QuizEntity quiz;
  final Map<int, String> userAnswers;

  const SummaryScreen({
    super.key,
    required this.quiz,
    required this.userAnswers,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final total = quiz.questions.length;
    final correct = quiz.questions.asMap().entries.where(
          (entry) => userAnswers[entry.key] == entry.value.correctAnswer,
    ).length;

    final percentage = ((correct / total) * 100).toStringAsFixed(1);

    return Scaffold(
        appBar: const CustomAppBar(
          title: 'Summary',
          showBack: false,
          showHome: true,
            homeRoute: BaseRoutes.dashboard,
        ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            color: colorScheme.primaryContainer,
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Score: $correct / $total',
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  'Percentage: $percentage%',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: quiz.questions.length,
              itemBuilder: (context, index) {
                final question = quiz.questions[index];
                final selected = userAnswers[index];
                final correct = question.correctAnswer;

                final isCorrect = selected == correct;

                return Card(
                  margin: const EdgeInsets.only(bottom: 16),
                  elevation: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Q${index + 1}: ${question.question}',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Your Answer: $selected',
                          style: TextStyle(
                            color: isCorrect ? Colors.green : Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        if (!isCorrect)
                          Text(
                            'Correct Answer: $correct',
                            style: const TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        const SizedBox(height: 8),
                        Text(
                          'Explanation: ${question.explanation}',
                          style: const TextStyle(fontStyle: FontStyle.italic),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
