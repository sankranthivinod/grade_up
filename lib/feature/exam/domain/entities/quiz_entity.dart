import 'package:practiceexams/feature/exam/domain/entities/question_entity.dart';

class QuizEntity {
  final String quizName;
  final int duration;
  final String category;
  final List<QuestionEntity> questions;

  QuizEntity({
    required this.quizName,
    required this.duration,
    required this.category,
    required this.questions,
  });
}