class AttendanceStatusModel {
  final String id;
  final String date;
  final int period;
  final String updatedById;

  AttendanceStatusModel({
    required this.id,
    required this.date,
    required this.period,
    required this.updatedById,
  });

  factory AttendanceStatusModel.fromJson(Map<String, dynamic> json) {
    return AttendanceStatusModel(
      id: json['id'],
      date: json['date'],
      period: json['period'],
      updatedById: json['updatedById'],
    );
  }
}

class StudentAttendanceModel {
  final String id;
  final String firstName;
  final String lastName;
  final String studentId;
  final AttendanceStatusModel? attendance;

  StudentAttendanceModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.studentId,
    required this.attendance,
  });

  factory StudentAttendanceModel.fromJson(Map<String, dynamic> json) {
    return StudentAttendanceModel(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      studentId: json['studentId'],
      attendance:
          json['attendance'] != null
              ? AttendanceStatusModel.fromJson(json['attendance'])
              : null,
    );
  }
}
