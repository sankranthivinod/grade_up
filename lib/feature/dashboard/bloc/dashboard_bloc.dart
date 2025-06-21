import 'package:flutter_bloc/flutter_bloc.dart';
import 'dashboard_event.dart';
import 'dashboard_state.dart';
import '../../../core/network/api_service.dart';
import '../../../core/di/dependency_configuration.dart'; // for sl

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final ApiService apiService = getIt<ApiService>();

  DashboardBloc() : super(DashboardState()) {
    on<FetchExamTypes>(_onFetchExamTypes);
    on<SelectExamType>(_onSelectExamType);
    on<SelectExam>(_onSelectExam);
    on<BeginTest>(_onBeginTest);
  }

  Future<void> _onFetchExamTypes(FetchExamTypes event, Emitter<DashboardState> emit) async {
    try {
      final types = await apiService.fetchUnattemptedQuizzes(category: "category", email: "email");
      emit(state.copyWith(examTypes: types));
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString()));
    }
  }

  Future<void> _onSelectExamType(SelectExamType event, Emitter<DashboardState> emit) async {
    emit(state.copyWith(selectedType: event.type, exams: [], isSubmitting: true));
    try {
      // final exams = await apiService.fetchQuizByName(event.type,"");
      // emit(state.copyWith(exams: exams, isSubmitting: false));
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString(), isSubmitting: false));
    }
  }

  void _onSelectExam(SelectExam event, Emitter<DashboardState> emit) {
    emit(state.copyWith(selectedExam: event.exam));
  }

  void _onBeginTest(BeginTest event, Emitter<DashboardState> emit) {
    // Placeholder for navigation or test logic
  }
}
