abstract class ExamEvent {}

class StartExamEvent extends ExamEvent {
  final String email;
  final String quizName;

  StartExamEvent(this.email, this.quizName);
}
class LoadExamEvent extends ExamEvent {
  final String quizName;

  LoadExamEvent(this.quizName);
}