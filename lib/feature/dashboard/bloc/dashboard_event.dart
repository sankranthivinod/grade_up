abstract class DashboardEvent {}

class FetchExamTypes extends DashboardEvent {}

class SelectExamType extends DashboardEvent {
  final String type;
  SelectExamType(this.type);
}

class SelectExam extends DashboardEvent {
  final String exam;
  SelectExam(this.exam);
}

class BeginTest extends DashboardEvent {}
