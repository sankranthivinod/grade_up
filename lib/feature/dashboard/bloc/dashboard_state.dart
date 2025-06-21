class DashboardState {
  final List<String> examTypes;
  final List<String> exams;
  final String? selectedType;
  final String? selectedExam;
  final bool isSubmitting;
  final String? errorMessage;

  DashboardState({
    this.examTypes = const [],
    this.exams = const [],
    this.selectedType,
    this.selectedExam,
    this.isSubmitting = false,
    this.errorMessage,
  });

  DashboardState copyWith({
    List<String>? examTypes,
    List<String>? exams,
    String? selectedType,
    String? selectedExam,
    bool? isSubmitting,
    String? errorMessage,
  }) {
    return DashboardState(
      examTypes: examTypes ?? this.examTypes,
      exams: exams ?? this.exams,
      selectedType: selectedType ?? this.selectedType,
      selectedExam: selectedExam ?? this.selectedExam,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      errorMessage: errorMessage,
    );
  }
}
