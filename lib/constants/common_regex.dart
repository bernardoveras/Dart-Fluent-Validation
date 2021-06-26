class CommonRegex {
  /// Matches e-mail
  static final RegExp emailValidator = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  /// Matches Telefone - (00) 00000-0000
  static final RegExp numberValidator = RegExp(r"^\([1-9]{2}\) (?:[2-8]|9[1-9])[0-9]{3}\-[0-9]{4}$");

  /// Matches CEP
  static final RegExp cepValidator = RegExp(r"[0-9]{5}-[0-9]{3}");

  /// Matches CPF
  static final RegExp cpfValidator = RegExp(r'[0-9]{3}\.?[0-9]{3}\.?[0-9]{3}\-?[0-9]{2}');

  /// Matches CNPJ
  static final RegExp cnpjValidator = RegExp(r'[0-9]{2}\.?[0-9]{3}\.?[0-9]{3}\/?[0-9]{4}\-?[0-9]{2}');

  /// Matches CPF and CNPJ
  static final RegExp cpfCnpjValidator = RegExp(r'(^\d{3}\.\d{3}\.\d{3}\-\d{2}$)|(^\d{2}\.\d{3}\.\d{3}\/\d{4}\-\d{2}$)');
}
