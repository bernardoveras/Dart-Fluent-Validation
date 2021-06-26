import 'package:fluent_validation/factories/abstract_validator.dart';
import 'package:fluent_validation/models/validation_result.dart';
import 'package:test/test.dart';

import 'models/test_user.dart';

void main() {
  test('lessThan validator returns errors correctly', () => TestLessThanValidator().runTest());
  test('isNotNull validator returns errors correctly', () => TestNotNullValidator().runTest());
  test('isNull validator returns errors correctly', () => TestUserNullValidator().runTest());
  test('isValidEmail validator returns errors correctly', () => TestUserEmailValidator().runTest());
  test('isValidPhone validator returns errors correctly', () => TestUserPhoneValidator().runTest());
  test('isValidCep validator returns errors correctly', () => TestUserCepValidator().runTest());
  test('isValidCpf validator returns errors correctly', () => TestUserCpfValidator().runTest());
  test('isValidCnpj validator returns errors correctly', () => TestUserCnpjValidator().runTest());
  test('isValidCpfCnpj validator returns errors correctly', () => TestUserCpfCnpjValidator().runTest());
}

class TestLessThanValidator extends AbstractValidator<TestUser> {
  TestLessThanValidator() {
    ruleFor((TestUser user) => user.age).lessThan(20).withMessage('message');
  }

  void runTest() {
    final TestUser testUser = TestUser(age: 18);
    final TestUser testUserTwo = TestUser(age: 24);

    final ValidationResult validationResult = validate(testUser);
    final ValidationResult validationResultTwo = validate(testUserTwo);

    expect(validationResult.hasError, isFalse);
    expect(validationResultTwo.hasError, isTrue);
  }
}

class TestNotNullValidator extends AbstractValidator<TestUser> {
  TestNotNullValidator() {
    ruleFor((TestUser user) => user.age).notNull();
  }

  void runTest() {
    final TestUser testUser = TestUser(age: null);
    final TestUser testUserTwo = TestUser(age: 24);

    final ValidationResult validationResult = validate(testUser);
    final ValidationResult validationResultTwo = validate(testUserTwo);

    expect(validationResult.hasError, isTrue);
    expect(validationResultTwo.hasError, isFalse);
  }
}

class TestUserNullValidator extends AbstractValidator<TestUser> {
  TestUserNullValidator() {
    ruleFor((TestUser user) => user.age).isNull();
  }

  void runTest() {
    final TestUser testUser = TestUser(age: null);
    final TestUser testUserTwo = TestUser(age: 24);

    final ValidationResult validationResult = validate(testUser);
    final ValidationResult validationResultTwo = validate(testUserTwo);

    expect(validationResult.hasError, isFalse);
    expect(validationResultTwo.hasError, isTrue);
  }
}

class TestUserEmailValidator extends AbstractValidator<TestUser> {
  TestUserEmailValidator() {
    ruleFor((TestUser user) => user.email).isValidEmail().withMessage('Invalid e-mail');
  }

  void runTest() {
    final TestUser testUser = TestUser(email: 'email@email.com');
    final TestUser testUserTwo = TestUser(email: 'email@email');

    final ValidationResult validationResult = validate(testUser);
    final ValidationResult validationResultTwo = validate(testUserTwo);

    expect(validationResult.hasError, isFalse);
    expect(validationResultTwo.hasError, isTrue);
    expect(validationResultTwo.messages[0], 'Invalid e-mail');
  }
}

class TestUserPhoneValidator extends AbstractValidator<TestUser> {
  TestUserPhoneValidator() {
    ruleFor((TestUser user) => user.cellphone).isValidPhone().withMessage('Invalid phone');
  }

  void runTest() {
    final TestUser testUser = TestUser(cellphone: '(21) 98359-7649');
    final TestUser testUserTwo = TestUser(cellphone: '123');

    final ValidationResult validationResult = validate(testUser);
    final ValidationResult validationResultTwo = validate(testUserTwo);

    expect(validationResult.hasError, isFalse);
    expect(validationResultTwo.hasError, isTrue);
    expect(validationResultTwo.messages[0], 'Invalid phone');
  }
}

class TestUserCepValidator extends AbstractValidator<TestUser> {
  TestUserCepValidator() {
    ruleFor((TestUser user) => user.cep).isValidCep().withMessage('Invalid Cep');
  }

  void runTest() {
    final TestUser testUser = TestUser(cep: '23082-030');
    final TestUser testUserTwo = TestUser(cep: '12313');

    final ValidationResult validationResult = validate(testUser);
    final ValidationResult validationResultTwo = validate(testUserTwo);

    expect(validationResult.hasError, isFalse);
    expect(validationResultTwo.hasError, isTrue);
    expect(validationResultTwo.messages[0], 'Invalid Cep');
  }
}

class TestUserCpfValidator extends AbstractValidator<TestUser> {
  TestUserCpfValidator() {
    ruleFor((TestUser user) => user.cpf).isValidCpf();
  }

  void runTest() {
    final TestUser testUser = TestUser(cpf: '090.343.577-24');
    final TestUser testUserTwo = TestUser(cep: '09023');
    final TestUser testUserThree = TestUser(cpf: '09034357724');

    final ValidationResult validationResult = validate(testUser);
    final ValidationResult validationResultTwo = validate(testUserTwo);
    final ValidationResult validationResultThree = validate(testUserThree);

    expect(validationResult.hasError, isFalse);
    expect(validationResultTwo.hasError, isTrue);
    expect(validationResultThree.hasError, isFalse);
  }
}

class TestUserCnpjValidator extends AbstractValidator<TestUser> {
  TestUserCnpjValidator() {
    ruleFor((TestUser user) => user.cnpj).isValidCnpj();
  }

  void runTest() {
    final TestUser testUser = TestUser(cnpj: '84.020.911/0001-70');
    final TestUser testUserTwo = TestUser(cnpj: '09023');
    final TestUser testUserThree = TestUser(cnpj: '85114254000193');

    final ValidationResult validationResultValid = validate(testUser);
    final ValidationResult validationResultFailedTwo = validate(testUserTwo);
    final ValidationResult validationResultValidThree = validate(testUserThree);

    expect(validationResultValid.hasError, isFalse);
    expect(validationResultFailedTwo.hasError, isTrue);
    expect(validationResultValidThree.hasError, isFalse);
  }
}

class TestUserCpfCnpjValidator extends AbstractValidator<TestUser> {
  TestUserCpfCnpjValidator() {
    ruleFor((TestUser user) => user.cpfCnpj).isValidCpfCnpj();
  }

  void runTest() {
    final TestUser testUser = TestUser(cpfCnpj: '090.343.577-24');
    final TestUser testUserThree = TestUser(cpfCnpj: '07.482.983/0001-99');

    final TestUser testUserFail = TestUser(cpfCnpj: '090');
    final TestUser testUserFailTwo = TestUser(cpfCnpj: '09034324');

    final ValidationResult validationResult = validate(testUser);
    final ValidationResult validationResultTwo = validate(testUserThree);

    final ValidationResult validationResultFail = validate(testUserFail);
    final ValidationResult validationResultFailTwo = validate(testUserFailTwo);

    expect(validationResult.hasError, isFalse);
    expect(validationResultTwo.hasError, isFalse);

    expect(validationResultFail.hasError, isTrue);
    expect(validationResultFailTwo.hasError, isTrue);
  }
}
