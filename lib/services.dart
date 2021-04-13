import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Services {
  static Future<bool> checkIfLoggedIn() async {
    bool isLoggedIn;
    await FirebaseAuth.instance.authStateChanges().listen((User user) {
      if (user == null)
        isLoggedIn = false;
      else {
        isLoggedIn = true;
      }
    });
    return isLoggedIn;
  }

  static Future<String> signUp(
    String email,
    String password,
    String name,
    String phoneNumber,
    String city,
    int vehicleCapacity,
  ) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    try {
      String docId = email.replaceAll("@", "").replaceAll(".", "");
      await firebaseFirestore.collection("deliverypersons").doc(docId).set({
        "city": city,
        "name": name,
        "phone": phoneNumber,
        "vehicleCapacity": vehicleCapacity,
      });
      await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return "user-created";
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        return e.code;
      } else
        return e.code;
    } catch (e) {
      return (e);
    }
  }

  static Future<String> signIn(
    String email,
    String password,
  ) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      return "login-success";
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return (e.code);
      } else if (e.code == 'wrong-password') {
        return (e.code);
      }
    } catch (e) {
      return e.code;
    }
  }
}
