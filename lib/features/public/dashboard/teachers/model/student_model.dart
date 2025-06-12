class PersonModel {
  final String id;
  final String firstName;
  final String lastName;
  final String role;

  PersonModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.role,
  });

  factory PersonModel.fromJson(Map<String, dynamic> json) {
    return PersonModel(
      id: json['id'] ?? '',
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      role: json['role'],
    );
  }
}
