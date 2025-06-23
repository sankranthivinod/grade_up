
import 'package:practiceexams/feature/dashboard/domain/entities/quiz_list_entity.dart';

class QuizListModel extends QuizListEntity {
  QuizListModel({required List<String> quizNames})
      : super(quizNames: quizNames);

  factory QuizListModel.fromJson(Map<String, dynamic> json) {
    return QuizListModel(
      quizNames: List<String>.from(json['unattempted_quizzes'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'unattempted_quizzes': quizNames,
    };
  }
}
