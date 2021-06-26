import '../../lib/factories/abstract_validator.dart';
import '../models/user.dart';

class UserValidator extends AbstractValidator<User> {
  UserValidator() {
    ruleFor((user) => user.age).greaterThanOrEqual(18);
    ruleFor((user) => user.name).notEmpty();
    ruleFor((user) => user.email).isValidEmailAddress();
    ruleFor((user) => user.address).notEmpty();
  }
}