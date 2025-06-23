class QuestionEntity {
  final String question;
  final String correctAnswer;
  final String incorrectAnswers; // keep as raw string or split into List<String>
  final String explanation;

  QuestionEntity({
    required this.question,
    required this.correctAnswer,
    required this.incorrectAnswers,
    required this.explanation,
  });
}