
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practiceexams/feature/dashboard/domain/usecases/fetch_quizzes_usecase.dart';
import 'package:practiceexams/feature/dashboard/presentation/bloc/dashboard_event.dart';
import 'package:practiceexams/feature/dashboard/presentation/bloc/dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final FetchQuizzesUseCase fetchQuizzesUseCase;

  DashboardBloc(this.fetchQuizzesUseCase) : super(DashboardInitial()) {
    on<DashboardLoadQuizzes>((event, emit) async {
      emit(DashboardLoading());
      try {
        final quizEntity = await fetchQuizzesUseCase(event.email, event.subject);
        emit(DashboardLoaded(quizEntity.quizNames));
      } catch (e) {
        emit(DashboardError(e.toString()));
      }
    });
  }
}