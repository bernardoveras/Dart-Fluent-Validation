import 'package:fluent_validation/factories/abstract_validator.dart';
import 'package:fluent_validation/models/validation_result.dart';
import 'package:test/test.dart';

import 'models/test_user.dart';

void main() {
  test('lessThan validator returns errors correctly', () => TestLessThanValidator().runTest());
  test('isNotNull validator returns errors correctly', () => TestNotNullValidator().runTest());
  test('isNull validator returns errors correctly', () => TestUserNullValidator().runTest());
  test('isValidEmailAddress validator returns errors correctly', () => TestUserEmailValidator().runTest());
  test('isValidPhoneNumber validator returns errors correctly', () => TestUserPhoneValidator().runTest());
  test('isValidUKPostCode validator returns errors correctly', () => TestUserCepValidator().runTest());
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
    ruleFor((TestUser user) => user.email).isValidEmailAddress().withMessage('Invalid e-mail');
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
    ruleFor((TestUser user) => user.cellphone).isValidPhoneNumber().withMessage('Invalid phone');
  }

  void runTest() {
    final TestUser testUser = TestUser( cellphone: '(21) 98359-7649');
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
    ruleFor((TestUser user) => user.cep).isValidUKPostCode().withMessage('Invalid Cep');
  }

  void runTest() {
    final TestUser testUser = TestUser( cep: '23082-030');
    final TestUser testUserTwo = TestUser( cep: '12313');

    final ValidationResult validationResult = validate(testUser);
    final ValidationResult validationResultTwo = validate(testUserTwo);

    expect(validationResult.hasError, isFalse);
    expect(validationResultTwo.hasError, isTrue);
    expect(validationResultTwo.messages[0], 'Invalid Cep');
  }
}