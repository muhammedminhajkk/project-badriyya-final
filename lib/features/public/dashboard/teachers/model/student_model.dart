class PersonModel {
  final String id;
  final String firstName;
  final String lastName;

  PersonModel({
    required this.id,
    required this.firstName,
    required this.lastName,
  });

  factory PersonModel.fromJson(Map<String, dynamic> json) {
    return PersonModel(
      id: json['id'] ?? '',
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
    );
  }
}
