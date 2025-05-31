class TeacherPeriodModel {
  final int period;
  final String startTime;
  final String endTime;
  final String subject;
  final String classId;
  final String className;

  TeacherPeriodModel({
    required this.period,
    required this.startTime,
    required this.endTime,
    required this.subject,
    required this.classId,
    required this.className,
  });

  factory TeacherPeriodModel.fromJson(Map<String, dynamic> json) {
    return TeacherPeriodModel(
      period: json['period'],
      startTime: json['startTime'],
      endTime: json['endTime'],
      subject: json['subject'],
      classId: json['classId'],
      className: json['className'],
    );
  }
}
