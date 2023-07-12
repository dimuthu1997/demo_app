import 'dart:core';

class EmailValidator {
  static bool validate(
    String email,
  ) {
    if (!RegExp(r'\S+@\S+\.\S+').hasMatch(email)) {
      return false;
    }

    // the email is valid
    return true;
  }
}
