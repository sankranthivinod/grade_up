import 'package:sqflite/sqflite.dart';
import 'package:practiceexams/feature/exam/data/models/question_model.dart';
import 'package:practiceexams/feature/exam/data/models/quiz_model.dart';

class QuizDao {
  final Database db;

  QuizDao(this.db);

  Future<void> insertQuizWithQuestions(QuizModel quiz) async {
    await db.insert(
      'Quiz',
      {
        'quizName': quiz.quizName,
        'duration': quiz.duration,
        'category': quiz.category,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    for (var q in quiz.questions) {
      await db.insert(
        'Question',
        {
          'quizName': quiz.quizName,
          'question': q.question,
          'correctAnswer': q.correctAnswer,
          'incorrectAnswers': q.incorrectAnswers, // This is a String
          'explanation': q.explanation,
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }

  Future<QuizModel?> getQuizByName(String quizName) async {
    final quizResult = await db.query(
      'Quiz',
      where: 'quizName = ?',
      whereArgs: [quizName],
    );

    if (quizResult.isEmpty) return null;

    final quizRow = quizResult.first;

    final questionRows = await db.query(
      'Question',
      where: 'quizName = ?',
      whereArgs: [quizName],
    );

    final questions = questionRows.map((row) {
      return QuestionModel(
        question: row['question'] as String,
        correctAnswer: row['correctAnswer'] as String,
        incorrectAnswers: row['incorrectAnswers'] as String,
        explanation: row['explanation'] as String,
      );
    }).toList();

    return QuizModel(
      quizName: quizRow['quizName'] as String,
      duration: quizRow['duration'] as int,
      category: quizRow['category'] as String,
      questions: questions,
    );
  }
}
