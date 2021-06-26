import 'package:fluent_validation/fluent_validation.dart';

abstract class AbstractValidator<E> {
  /// A coleção de construtores de regras
  final List<AbstractRuleBuilder<E>> ruleBuilders = <AbstractRuleBuilder<E>>[];

  /// Cria um novo construtor para representar uma lista de regras.
  AbstractRuleBuilder<E> ruleFor(dynamic Function(E e) func) {
    final AbstractRuleBuilder<E> builder = AbstractRuleBuilder<E>(expression: func);
    ruleBuilders.add(builder);
    return builder;
  }

  /// Valida um objeto, retornando uma lista mesclada de resultados de validação.
  ValidationResult validate(E object, {bool ignorePassedMessages = true}) {
    final List<ValidationResult> results = <ValidationResult>[];
    for (final AbstractRuleBuilder<E> ruleBuilder in ruleBuilders) {
      final dynamic expressedValue = ruleBuilder.expression(object);
      for (final ValidationResult Function(dynamic) rule in ruleBuilder.rules) {
        final ValidationResult result = rule(expressedValue);
        results.add(result);
      }
    }

    return ValidationResult.merge(results, ignorePassedMessages);
  }
}
