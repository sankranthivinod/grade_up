import 'package:flutter/material.dart';
import 'package:practiceexams/feature/exam/domain/entities/question_entity.dart';
import 'package:practiceexams/feature/exam/domain/entities/quiz_entity.dart';

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

    return Scaffold(
      appBar: AppBar(
        title: const Text('Summary'),
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
      ),
      body: ListView.builder(
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
                  Text('Your Answer: $selected',
                      style: TextStyle(
                          color: isCorrect ? Colors.green : Colors.red,
                          fontWeight: FontWeight.bold)),
                  if (!isCorrect)
                    Text('Correct Answer: $correct',
                        style: const TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold)),
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
    );
  }
}
