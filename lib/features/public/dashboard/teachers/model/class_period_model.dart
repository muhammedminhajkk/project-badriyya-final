class ClassPeriodModel {
  // final String dayOfWeek;
  final int period;
  final String startTime;
  final String endTime;
  final String subject;
  final String teacherId;

  ClassPeriodModel({
    // required this.dayOfWeek,
    required this.period,
    required this.startTime,
    required this.endTime,
    required this.subject,
    required this.teacherId,
  });

  factory ClassPeriodModel.fromJson(Map<String, dynamic> json) {
    return ClassPeriodModel(
      // dayOfWeek: json['dayOfWeek'],
      period: json['period'],
      startTime: json['startTime'],
      endTime: json['endTime'],
      subject: json['subject'],
      teacherId: json['teacherId'],
    );
  }
}
