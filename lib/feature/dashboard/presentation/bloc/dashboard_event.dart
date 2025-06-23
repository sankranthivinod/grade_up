abstract class DashboardEvent {}

class DashboardLoadQuizzes extends DashboardEvent {
  final String email;
  final String subject;

  DashboardLoadQuizzes(this.email, this.subject);
}

