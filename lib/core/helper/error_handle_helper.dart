class ErrorHandleHelper {
  static String getCustomErrorMessage(String errorCode) {
    switch (errorCode) {
      case 'invalid-credential':
        return 'Incorrect email or password. Please try again.';
      case 'wrong-password':
        return 'The current password is incorrect.';
      case 'user-not-found':
        return 'No account found with this email.';
      case 'email-already-in-use':
        return 'This email address is already registered.';
      case 'weak-password':
        return 'The password entered is too weak. Try a longer combination.';
      case 'invalid-email':
        return 'Please enter a valid email address.';
      case 'user-disabled':
        return 'This user account has been disabled. Contact support.';
      case 'too-many-requests':
        return 'Too many attempts. Please try again later.';
      case 'requires-recent-login':
        return 'Please logout and login again, then retry.';
      case 'network-request-failed':
        return 'No internet connection. Please check your network.';
      default:
        return 'An unexpected authentication error occurred. Please try again.';
    }
  }
}
