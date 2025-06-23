import 'package:practiceexams/feature/exam/domain/entities/question_entity.dart';

class QuestionModel extends QuestionEntity {
  QuestionModel({
    required super.question,
    required super.correctAnswer,
    required super.incorrectAnswers,
    required super.explanation,
  });

  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    return QuestionModel(
      question: json['question'],
      correctAnswer: json['correctAnswer'],
      incorrectAnswers: json['incorrectAnswers'],
      explanation: json['explanation'],
    );
  }

  Map<String, dynamic> toJson() => {
    'question': question,
    'correctAnswer': correctAnswer,
    'incorrectAnswers': incorrectAnswers,
    'explanation': explanation,
  };
}
