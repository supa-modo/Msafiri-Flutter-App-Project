import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:project_x/src/features/models/user_models.dart';
import 'package:project_x/src/features/screens/home_screen/home_screen.dart';
import 'package:project_x/src/features/screens/sign_in_screen/sign_in.dart';
import 'package:project_x/src/services/exceptions/sign_up_exceptions.dart';

import '../utils/show_snackbar.dart';
import 'user_repository.dart';

class AuthRepository extends GetxController {
  static AuthRepository get instance => Get.find();

  User? get currentUser => FirebaseAuth.instance.currentUser;

  final _auth = FirebaseAuth.instance;
  final _googleSignIn = GoogleSignIn();

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

  Future<void> signInWithGoogle() async {
    try {
      // Trigger the Google Authentication flow
      final googleUser = await _googleSignIn.signIn();

      if (googleUser != null) {
        // Obtain the GoogleAuth credential from the GoogleUser
        final googleAuth = await googleUser.authentication;

        // Create a new Firebase credential with the Google token
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        // Sign in with the Firebase credential
        await _auth.signInWithCredential(credential);

        // If the user doesn't already exist, create a new account with the
        // Google user's email address
        final user = _auth.currentUser;
        if (user != null && user.email == null) {
          await user.updateEmail(googleUser.email);
        }

        firebaseUser.value != null
            ? Get.offAll(() => const HomeScreen())
            : Get.offAll(() => const SignInScreen());
      }
    } on FirebaseAuthException catch (e) {
      final ex = LoginWithGoogle_failure.code(e.code);
      showSnackBar(Get.context!, ex.message);
      throw ex;
    } catch (e) {
      const ex = LoginWithGoogle_failure();
      showSnackBar(Get.context!, ex.message);
      throw ex;
    }
  }

  Future<void> logout() async => await _auth.signOut();

  final userRepo = Get.put(UserRepository());

  Future<void> createUser(UserModel user2) async {
    await userRepo.createUser(user2);
  }
}
