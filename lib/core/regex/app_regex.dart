class AppRegex {
  static final RegExp emailRegex = RegExp(
    r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$',
  );
  static final RegExp passwordRegex = RegExp(r'^(?=.*[A-Z])(?=.*[!@#$&*]).*$');

  static String? validatePassword(String? password) {
    if (password?.isEmpty ?? true) {
      return 'Password is required';
    } else if (password!.length < 8) {
      return 'Password must be at least 8 characters';
    } else if (passwordRegex.hasMatch(password) == false) {
      return 'Password must contain at least one uppercase letter and one special character (!@#\$&*)';
    }
    return null;
  }
}
