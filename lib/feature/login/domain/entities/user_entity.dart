class UserEntity {
  final int id;
  final String email;
  final String name;
  final String studentClass;
  final String phoneNumber;
  final String paymentStatus;
  final List<String> subjects;

  const UserEntity({
    required this.id,
    required this.email,
    required this.name,
    required this.studentClass,
    required this.phoneNumber,
    required this.paymentStatus,
    required this.subjects,
  });
}
