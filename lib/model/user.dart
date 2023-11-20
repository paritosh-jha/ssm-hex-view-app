class User {
  final String name;
  final String phone;
  final String vehicleNum;
  final String email;
  final String emergencyContact1;
  final String emergencyContact2;

  User({
    required this.vehicleNum,
    this.emergencyContact1 = '12345678',
    this.emergencyContact2 = '987654321',
    required this.name,
    required this.phone,
    required this.email,
  });
}
