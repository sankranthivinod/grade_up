import 'package:practiceexams/feature/exam/data/models/question_model.dart';
import 'package:practiceexams/feature/exam/domain/entities/quiz_entity.dart';

class QuizModel extends QuizEntity {
  QuizModel({
    required super.quizName,
    required super.duration,
    required super.category,
    required super.questions,
  });

  factory QuizModel.fromJson(Map<String, dynamic> json) {
    return QuizModel(
      quizName: json['quizName'],
      duration: json['duration'],
      category: json['category'],
      questions: (json['questions'] as List)
          .map((q) => QuestionModel.fromJson(q))
          .toList(),
    );
  }
}
