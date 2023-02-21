import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:project_x/src/features/screens/home_screen/home_screen.dart';
import 'package:project_x/src/features/screens/sign_in_screen/sign_in.dart';
import 'package:project_x/src/services/exceptions/sign_up_exceptions.dart';

class Auth_repository extends GetxController {
  static Auth_repository get instance => Get.find();

  final _auth = FirebaseAuth.instance;
  late final Rx<User?> firebaseUser;

  @override
  void onReady() {
    firebaseUser = Rx<User?>(_auth.currentUser);
    firebaseUser.bindStream(_auth.userChanges());
    ever(firebaseUser, _setInitialScreen);
  }

  _setInitialScreen(User? user) {
    user == null
        ? Get.offAll(() => SignInScreen())
        : Get.offAll(() => HomeScreen());
  }

  void _handleAuthStateChanges(User? user) {
    if (user != null) {
      Get.offAll(() => const HomeScreen());
    } else {
      Get.offAll(() => const SignInScreen());
    }
  }

  Future<void> createUserWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      final result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      _auth.authStateChanges().listen(_handleAuthStateChanges);
    } on FirebaseAuthException catch (e) {
      final ex = SignUpWithEmailAndPassword_failure.code(e.code);
      print('FIREBASE AUTH EXCEPTION - ${ex.message}');
       throw ex;
    } catch (_) {
      const ex = SignUpWithEmailAndPassword_failure();
      print('EXCEPTION - ${ex.message}');
      throw ex;
    }
  }

  Future<void> loginUserWithEmailAndPassword(
      String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
    } catch (_) {}
  }

  Future<void> logout() async => await _auth.signOut();
}
