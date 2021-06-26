import 'package:fluent_validation/fluent_validation.dart';
import 'models/user.dart';
import 'validators/user_validator.dart';

void main() {
  final User validUser = User(name: "Bernardo", email: "bernardo@email", age: 15, address: "Rua X");

  final UserValidator userValidator = UserValidator();
  final ValidationResult validationResult = userValidator.validate(validUser);
  
  if (validationResult.hasError) {
    for (var item in validationResult.messages) {
      print('Error: $item');
    }
  }
}
