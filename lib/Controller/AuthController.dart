import 'package:e_book/Config/Messages.dart';
import 'package:e_book/Pages/Homepage/HomePage.dart';
import 'package:e_book/Pages/WelcomePage/WelcomePage.dart'; // Import WelcomePage
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:logger/logger.dart';

class AuthController extends GetxController {
  RxBool isLoading = false.obs;
  final auth = FirebaseAuth.instance;
  final logger = Logger();

  void loginWithEmail() async {
    isLoading.value = true;
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      final userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      successMessage('Login Success');
      Get.offAll(const HomePage());
    } catch (ex) {
      logger.e(ex);
      errorMessage("Error! Try Again");
    }
    isLoading.value = false;
  }

  void signout() async {
    await auth.signOut();
    successMessage('Logout');
    Get.offAll(const WelcomePage()); // Ganti menjadi WelcomePage()
  }

  Future<void> loginWithEmailAndPassword(String email, String password) async {
    isLoading.value = true;
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      successMessage('Login Success');
      Get.offAll(const HomePage());
    } on FirebaseAuthException catch (e) {
      logger.e('Failed with error code: ${e.code}');
      logger.e(e.message);
      errorMessage(e.code);
    }
    isLoading.value = false;
  }

  Future<void> signupWithEmailPassword(String email, String password) async {
    isLoading.value = true;
    try {
      await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      successMessage('SignUp Success');
      Get.offAll(const HomePage());
    } on FirebaseAuthException catch (e) {
      logger.e('Failed with error code: ${e.code}');
      logger.e(e.message);
      errorMessage(e.code);
    }
    isLoading.value = false;
  }
}
