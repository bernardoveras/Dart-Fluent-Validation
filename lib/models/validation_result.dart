/// Retornado quando validate é chamado, contém erros em potencial com objetos validados.
class ValidationResult {
  ValidationResult({
    this.messages = const <String>[],
    this.hasError = false,
  });

  /// Cria um novo resultado de validação para representar um erro.
  factory ValidationResult.fromError(String message) {
    return ValidationResult(hasError: true, messages: <String>[message]);
  }

  /// Mescla uma coleção de resultados de validação.
  /// Usar `ignorePassedMessages` apenas manterá as mensagens em testes que falharam.
  factory ValidationResult.merge(
      List<ValidationResult> results, bool ignorePassedMessages) {
    return ValidationResult(
      hasError: results.any((ValidationResult result) => result.hasError),
      messages: results
          .expand((ValidationResult result) =>
              ignorePassedMessages && !result.hasError
                  ? <String>[]
                  : result.messages)
          .toList(),
    );
  }

  /// Mensagens que representam o erro que pode ocorrer
  final List<String> messages;

  /// Se o resultado desta ação foi um erro
  final bool hasError;
}