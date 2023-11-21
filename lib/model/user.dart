class User {
  final String name;
  final String phone;
  final Map<String,String> vehicles;
  final String email;
  final String emergencyContact1;
  final String emergencyContact2;

  User({
    required this.vehicles,
    required this.emergencyContact1,
    required this.emergencyContact2,
    required this.name,
    required this.phone,
    required this.email,
  });
}
