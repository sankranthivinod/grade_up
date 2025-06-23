abstract class DashboardState {}

class DashboardInitial extends DashboardState {}

class DashboardLoading extends DashboardState {}

class DashboardLoaded extends DashboardState {
  final List<String> quizList;

  DashboardLoaded(this.quizList);
}

class DashboardError extends DashboardState {
  final String message;

  DashboardError(this.message);
}