import '../../domain/entities/quiz_entity.dart';

abstract class ExamState {}

class ExamInitial extends ExamState {}

class ExamLoading extends ExamState {}

class ExamLoaded extends ExamState {
  final QuizEntity quiz;

  ExamLoaded(this.quiz);
}

class ExamError extends ExamState {
  final String message;

  ExamError(this.message);
}
