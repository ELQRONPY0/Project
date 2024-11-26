class AppRegex {
  /// التحقق من صحة البريد الإلكتروني
  static bool isEmailValid(String email) {
    return RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    ).hasMatch(email);
  }

  /// التحقق من صحة كلمة المرور
  static bool isPasswordValid(String password) {
    return RegExp(
      r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[^a-zA-Z\d])[A-Za-z\d@$!%*?&^#()-_=+]{8,}$',
    ).hasMatch(password);
  }

  /// يحتوي على حرف صغير
  static bool hasLowerCase(String password) {
    return RegExp(r'[a-z]').hasMatch(password);
  }

  /// يحتوي على حرف كبير
  static bool hasUpperCase(String password) {
    return RegExp(r'[A-Z]').hasMatch(password);
  }

  /// يحتوي على رقم
  static bool hasNumber(String password) {
    return RegExp(r'\d').hasMatch(password);
  }

  /// يحتوي على رمز خاص
  static bool hasSpecialCharacter(String password) {
    return RegExp(r'[@$!%*?&]').hasMatch(password);
  }

  /// التحقق من صحة رقم الهاتف
  static bool isPhoneNumberValid(String phoneNumber) {
    return RegExp(r'^(010|011|012|015)[0-9]{8}$').hasMatch(phoneNumber);
  }

  /// يحتوي على الحد الأدنى للطول (8 أحرف)
  static bool hasMinLength(String password) {
    return password.length >= 8;
  }
}
