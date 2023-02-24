import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:project_x/src/features/screens/home_screen/home_screen.dart';
import 'package:project_x/src/features/screens/sign_in_screen/sign_in.dart';
import 'package:project_x/src/services/exceptions/sign_up_exceptions.dart';

class AuthRepository extends GetxController {
  static AuthRepository get instance => Get.find();

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

  Future<void> createUserWithEmailAndPassword(
      String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      firebaseUser.value != null
          ? Get.offAll(() => const HomeScreen())
          : Get.offAll(() => const SignInScreen());
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
