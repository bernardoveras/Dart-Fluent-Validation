class CommonRegex {
  /// Matches email addresses
  static final RegExp emailValidator = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  /// Matches phone numbers addresses - (00) 00000-0000
  static final RegExp numberValidator =
      RegExp(r"^\([1-9]{2}\) (?:[2-8]|9[1-9])[0-9]{3}\-[0-9]{4}$");

  /// Matches national insurance numbers in the UK
  static final RegExp ninValidator =
      RegExp(r"^\s*[a-zA-Z]{2}(?:\s*\d\s*){6}[a-zA-Z]?\s*$");

  /// Matches UK post codes
  static final RegExp postCodeValidator = RegExp(
      r"[0-9]{5}-[0-9]{3}");
}