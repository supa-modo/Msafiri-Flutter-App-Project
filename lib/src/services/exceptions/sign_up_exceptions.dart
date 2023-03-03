class SignUpWithEmailAndPassword_failure {
  final String message;

  const SignUpWithEmailAndPassword_failure(
      [this.message = 'An unknown error occured']);

  factory SignUpWithEmailAndPassword_failure.code(String code) {
    switch (code) {
      case 'weak-password':
        return const SignUpWithEmailAndPassword_failure(
            'Please enter a stronger password');
      case 'invalid-email':
        return const SignUpWithEmailAndPassword_failure(
            'Enter a valid email address');
      case 'email-already-in-use':
        return const SignUpWithEmailAndPassword_failure(
            'The email entered has been registered with another account');
      case 'operation-not-allowed':
        return const SignUpWithEmailAndPassword_failure(
            'Operation is not allowed, Please contact customer support');
      case 'user-disabled':
        return const SignUpWithEmailAndPassword_failure(
            'This user has been disabled, Please contact customer support');
      default:
        return const SignUpWithEmailAndPassword_failure();
    }
  }
}

class LoginWithGoogle_failure {
  final String message;

  const LoginWithGoogle_failure([this.message = 'An unknown error occurred']);

  factory LoginWithGoogle_failure.code(String code) {
    switch (code) {
      case 'account-exists-with-different-credential':
        return const LoginWithGoogle_failure(
            'An account with the same email already exists. Try signing in with a different provider.');
      case 'invalid-credential':
        return const LoginWithGoogle_failure(
            'The provided credential is invalid. Please try again.');
      case 'operation-not-allowed':
        return const LoginWithGoogle_failure(
            'Google sign-in is currently disabled. Please contact customer support.');
      case 'user-disabled':
        return const LoginWithGoogle_failure(
            'This user has been disabled. Please contact customer support.');
      case 'user-not-found':
        return const LoginWithGoogle_failure(
            'No user was found with the provided credentials.');
      case 'wrong-password':
        return const LoginWithGoogle_failure(
            'The password provided is incorrect.');
      default:
        return const LoginWithGoogle_failure();
    }
  }
}
