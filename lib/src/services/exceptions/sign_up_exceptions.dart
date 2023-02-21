class SignUpWithEmailAndPassword_failure {
  final String message;

  const SignUpWithEmailAndPassword_failure(
      [this.message = 'An unknown error occured']);

  factory SignUpWithEmailAndPassword_failure.code(String code) {
    switch (code) {
      case 'weak-password':
        return SignUpWithEmailAndPassword_failure(
            'Please enter a stronger password');
      case 'invalid-email':
        return SignUpWithEmailAndPassword_failure(
            'Enter a valid email address');
      case 'email-already-in-use':
        return SignUpWithEmailAndPassword_failure(
            'The email entered has been registered with another account');
      case 'operation-not-allowed':
        return SignUpWithEmailAndPassword_failure(
            'Operation is not allowed, Please contact customer support');
      case 'user-disabled':
        return SignUpWithEmailAndPassword_failure(
            'This user has been disabled, Please contact customer support');
      default:
        return SignUpWithEmailAndPassword_failure('');
    }
  }
}
