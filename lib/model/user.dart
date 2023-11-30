class User {
  final String name;
  final String phone;
  final String email;
  final Map<String, String> vehicles;
  final Map<String, String> emergencyContacts;

  User({
    required this.emergencyContacts,
    required this.vehicles,
    required this.name,
    required this.phone,
    required this.email,
  });
}
