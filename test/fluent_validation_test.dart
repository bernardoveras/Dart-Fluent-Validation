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
}

class TestLessThanValidator extends AbstractValidator<TestUser> {
  TestLessThanValidator() {
    ruleFor((TestUser user) => user.age).lessThan(20).withMessage('message');
  }

  void runTest() {
    final TestUser testUser = TestUser(age: 18, name: 'Ryan', cellphone: '123', email: 'email@email.com');
    final TestUser testUserTwo = TestUser(age: 24, name: 'Ryan', cellphone: '123', email: 'email@email.com');

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
    final TestUser testUser = TestUser(age: null, name: 'Ryan', cellphone: '123', email: 'email@email.com');
    final TestUser testUserTwo = TestUser(age: 24, name: 'Ryan', cellphone: '123', email: 'email@email.com');

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
    final TestUser testUser = TestUser(age: null, name: 'Ryan', cellphone: '123', email: 'email@email.com');
    final TestUser testUserTwo = TestUser(age: 24, name: 'Ryan', cellphone: '123', email: 'email@email.com');

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
    final TestUser testUser = TestUser(age: 18, name: 'Ryan', cellphone: '123', email: 'email@email.com');
    final TestUser testUserTwo = TestUser(age: 24, name: 'Ryan', cellphone: '123', email: 'email@email');

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
    final TestUser testUser = TestUser(age: 18, name: 'Ryan', cellphone: '(21) 98359-7649', email: 'email@email.com');
    final TestUser testUserTwo = TestUser(age: 24, name: 'Ryan', cellphone: '123', email: 'email@email.com');

    final ValidationResult validationResult = validate(testUser);
    final ValidationResult validationResultTwo = validate(testUserTwo);

    expect(validationResult.hasError, isFalse);
    expect(validationResultTwo.hasError, isTrue);
    expect(validationResultTwo.messages[0], 'Invalid phone');
  }
}