import '../../domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required int id,
    required String email,
    required String name,
    required String studentClass,
    required String phoneNumber,
    required String paymentStatus,
    required List<String> subjects,
  }) : super(
    id: id,
    email: email,
    name: name,
    studentClass: studentClass,
    phoneNumber: phoneNumber,
    paymentStatus: paymentStatus,
    subjects: subjects,
  );

  factory UserModel.fromJson(Map<String, dynamic> json) {
    final rawSubjects = json['subjects'];
    List<String> subjects;

    if (rawSubjects is List) {
      subjects = List<String>.from(rawSubjects); // API response
    } else if (rawSubjects is String) {
      subjects = rawSubjects.split(','); // Local DB string
    } else {
      subjects = [];
    }

    return UserModel(
      id: json['id'] is int ? json['id'] : int.tryParse(json['id'].toString()) ?? 0,
      email: json['email'],
      name: json['name'],
      studentClass: json['student_class'],
      phoneNumber: json['phone_number'],
      paymentStatus: json['payment_status'] ?? 'UNKNOWN',
      subjects: subjects,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'student_class': studentClass,
      'phone_number': phoneNumber,
      'payment_status': paymentStatus,
      'subjects': subjects.join(','), // store as CSV in DB
    };
  }
}
