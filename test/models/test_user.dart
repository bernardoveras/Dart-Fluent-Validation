class TestUser {
  TestUser({
    required this.name,
    required this.email,
    required this.cellphone,
    this.age,
  });

  final String name;
  final String email;
  final String cellphone;
  final int? age;
}
