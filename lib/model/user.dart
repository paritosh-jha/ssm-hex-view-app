class User {
  final String name;
  final String phone;
  final List<String> vehicleNum;
  final String email;
  final String emergencyContact1;
  final String emergencyContact2;

  User({
    required this.vehicleNum,
    required this.emergencyContact1,
    required this.emergencyContact2,
    required this.name,
    required this.phone,
    required this.email,
  });
}
