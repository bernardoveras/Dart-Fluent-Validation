class TestUser {
  TestUser({
    this.name = '',
    this.email = '',
    this.cellphone = '',
    this.cep = '',
    this.cpf = '',
    this.cnpj = '',
    this.cpfCnpj = '',
    this.age,
  });

  final String name;
  final String email;
  final String cpf;
  final String cnpj;
  final String cpfCnpj;
  final String cellphone;
  final String cep;
  final int? age;
}
