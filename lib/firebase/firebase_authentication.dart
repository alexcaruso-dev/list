import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthentication {

  Future<void> signInAnonymously() async {
    try {
      await FirebaseAuth.instance.signInAnonymously();
    } catch (e) {
      rethrow; // TODO: Handle auth failure error
    }
  }
}