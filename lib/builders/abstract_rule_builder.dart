import 'package:fluent_validation/fluent_validation.dart';

/// Contém uma lista de regras para comparar
class AbstractRuleBuilder<E> {
  AbstractRuleBuilder({
    required this.expression,
  });

  /// A expressão para obter o resultado da verificação da regra
  final dynamic Function(E e) expression;

  String? _message;

  /// A lista de regras para verificar
  final List<ValidationResult Function(dynamic)> rules = <ValidationResult Function(dynamic)>[];

  /// Change the error message
  void withMessage(String message) {
    _message = message;
  }

  /// Verifica se o objeto é nulo
  AbstractRuleBuilder isNull() {
    return must((dynamic dyn) => dyn == null, "O valor deve ser nulo");
  }

  /// Verifica se o objeto não é nulo
  AbstractRuleBuilder notNull() {
    return must((dynamic dyn) => dyn != null, "O valor não deve ser nulo");
  }

  /// Verifica se o objeto é uma string e não está vazio
  AbstractRuleBuilder notEmpty() {
    return must((dynamic dyn) => dyn is String && dyn.isNotEmpty, "A string não deve estar vazia");
  }

  /// Verifica se o objeto é uma string e está vazio
  AbstractRuleBuilder empty() {
    return must((dynamic dyn) => dyn is String && dyn.isEmpty, "String deve estar vazia");
  }

  /// Verifica se o objeto não é igual a outro
  AbstractRuleBuilder notEqual(dynamic obj) {
    return must((dynamic dyn) => dyn != obj, "O valor não deve ser igual");
  }

  /// Verifica se o objeto é igual a outro
  AbstractRuleBuilder equal(dynamic obj) {
    return must((dynamic dyn) => dyn == obj, "O valor deve ser igual");
  }

  /// Verifica se o objeto é uma String e está entre dois comprimentos
  AbstractRuleBuilder length(int min, int max) {
    return must(
        (dynamic dyn) => dyn is String && dyn.length >= min && dyn.length <= max, "A string deve ter entre $min e $max caracteres de comprimento");
  }

  /// Verifica se o objeto é uma String e tem pelo menos um comprimento mínimo
  AbstractRuleBuilder minLength(int min) {
    return must((dynamic dyn) => dyn is String && dyn.length >= min, "A string deve ter mais ou igual a $min caracteres");
  }

  /// Verifica se o objeto é uma String e está abaixo de um comprimento máximo
  AbstractRuleBuilder maxLength(int max) {
    return must((dynamic dyn) => dyn is String && dyn.length <= max, "A string deve ter menos ou igual a $max caracteres");
  }

  /// Verifica se o objeto é um número e menor que outro valor
  AbstractRuleBuilder lessThan(int min) {
    return must((dynamic dyn) => dyn is num && dyn < min, "O número deve ser inferior a $min");
  }

  /// Verifica se o objeto é um número e é menor ou igual a outro valor
  AbstractRuleBuilder lessThanOrEqual(int min) {
    return must((dynamic dyn) => dyn is num && dyn <= min, "O número deve ser menor ou igual a $min");
  }

  /// Verifica se o objeto é um número e é maior que outro número
  AbstractRuleBuilder greaterThan(int max) {
    return must((dynamic dyn) => dyn is num && dyn > max, "O número deve ser maior que $max");
  }

  /// Verifica se o objeto é um número e é maior ou igual a outro número
  AbstractRuleBuilder greaterThanOrEqual(int max) {
    return must((dynamic dyn) => dyn is num && dyn >= max, "O número deve ser maior ou igual a $max");
  }

  /// Verifica se o objeto é uma String e um E-mail válido
  AbstractRuleBuilder isValidEmail() {
    return must((dynamic dyn) => dyn is String && CommonRegex.emailValidator.hasMatch(dyn), "String deve ser um endereço de e-mail válido");
  }

  /// Verifica se o objeto é uma String e um Telefone válido
  AbstractRuleBuilder isValidPhone() {
    return must((dynamic dyn) => dyn is String && CommonRegex.numberValidator.hasMatch(dyn), "String deve ser um número de telefone válido");
  }

  /// Verifica se o objeto é uma String e um CEP válido
  AbstractRuleBuilder isValidCep() {
    return must((dynamic dyn) => dyn is String && CommonRegex.cepValidator.hasMatch(dyn), "A string deve ser um CEP válido");
  }

  /// Verifica se o objeto é uma String e um CPF válido
  AbstractRuleBuilder isValidCpf() {
    return must((dynamic dyn) => dyn is String && CommonRegex.cpfValidator.hasMatch(dyn), "String deve ser um CPF válido");
  }

  /// Verifica se o objeto é uma String e um CNPJ válido
  AbstractRuleBuilder isValidCnpj() {
    return must((dynamic dyn) => dyn is String && CommonRegex.cnpjValidator.hasMatch(dyn), "String deve ser um CNPJ válido");
  }

  /// Verifica se o objeto é uma String e um CPF ou CNPJ válido
  AbstractRuleBuilder isValidCpfCnpj() {
    return must((dynamic dyn) => dyn is String && CommonRegex.cpfCnpjValidator.hasMatch(dyn), "A string deve ser um CPF ou CNPJ válido");
  }

  /// Cria uma nova regra, passando uma expressão e uma mensagem e retornando um booleano
  AbstractRuleBuilder must(bool Function(dynamic dyn) validator, String message) {
    rules.add((dynamic param) => ValidationResult(hasError: !validator(param), messages: <String>[_message ?? message]));
    return this;
  }
}
