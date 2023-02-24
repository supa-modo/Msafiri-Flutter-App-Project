import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUpExceptions implements Exception {
  final String code;

  SignUpExceptions(this.code);

  static String generateErrorMessage(String code) {
    switch (code) {
      case 'invalid-phone-number':
        return 'Invalid phone number format';
      case 'too-many-requests':
        return 'Too many requests. Please try again later.';
      case 'session-expired':
        return 'Session expired. Please try again.';
      case 'invalid-verification-code':
        return 'Invalid verification code';
      case 'credential-already-in-use':
        return 'The phone number is already in use. Please try again with another number.';
      case 'network-request-failed':
        return 'Network error. Please try again later.';
      default:
        return 'An unknown error has occurred. Please try again later.';
    }
  }
}

class Services {
  static final Services instance = Services._();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Services._();

  Future<void> setPhoneNumber(String phoneNumber) async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final userRef = _firestore.collection('users').doc(uid);

    await userRef.set({'phoneNumber': phoneNumber}, SetOptions(merge: true));
  }
}
