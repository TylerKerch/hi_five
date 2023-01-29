import 'package:hi_five/services/auth_service.dart';

class SignupValidators {
  static Future<String?> validate(String password, String email) async {
    if (!validatePassword(password)) {
      return 'Password must have length >= 8, at least 1 digit, 1 letter, 1 special character';
    }else if((await AuthService.getAllEmails()).contains(email)){
      return 'Account already created with email';
    }
    return null;
  }

  static bool validatePassword(String password) {
    return password.length >= 8 &&
        password.contains(RegExp(r'\d')) &&
        password.contains(RegExp(r'\W')) &&
        password.contains(RegExp(r'[a-zA-Z]'));
  }
}