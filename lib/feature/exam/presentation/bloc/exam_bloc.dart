import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:practiceexams/feature/exam/data/datasources/exam_remote_data_source.dart';
import 'package:practiceexams/feature/exam/domain/dao/quiz_dao.dart';
import 'package:practiceexams/feature/exam/presentation/bloc/exam_event.dart';
import 'package:practiceexams/feature/exam/presentation/bloc/exam_state.dart';

@injectable
class ExamBloc extends Bloc<ExamEvent, ExamState> {
  final ExamRemoteDataSource remoteDataSource;
  final QuizDao quizDao;

  ExamBloc(this.remoteDataSource, this.quizDao) : super(ExamInitial()) {
    on<StartExamEvent>(_onStartExam);
    on<LoadExamEvent>(_onLoadExam);
  }

  Future<void> _onStartExam(StartExamEvent event, Emitter<ExamState> emit) async {
    emit(ExamLoading());
    try {
      // Fetch quiz from API
      final quiz = await remoteDataSource.fetchQuizByName(event.email, event.quizName);

      // Store quiz in local DB
      await quizDao.insertQuizWithQuestions(quiz);

      // Trigger local loading
      add(LoadExamEvent(event.quizName));
    } catch (e) {
      emit(ExamError(e.toString()));
    }
  }

  Future<void> _onLoadExam(LoadExamEvent event, Emitter<ExamState> emit) async {
    emit(ExamLoading());
    try {
      final quiz = await quizDao.getQuizByName(event.quizName);
      if (quiz != null) {
        emit(ExamLoaded(quiz));
      } else {
        emit(ExamError("Quiz not found in local database."));
      }
    } catch (e) {
      emit(ExamError(e.toString()));
    }
  }
}
