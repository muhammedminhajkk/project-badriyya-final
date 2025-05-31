import 'package:hive/hive.dart';

part 'class_model.g.dart';

@HiveType(typeId: 0)
class ClassModel {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final List<dynamic> students;

  ClassModel({required this.id, required this.name, required this.students});

  factory ClassModel.fromJson(Map<String, dynamic> json) {
    return ClassModel(
      id: json['id'],
      name: json['name'],
      students: json['students'] ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'students': students};
  }
}
