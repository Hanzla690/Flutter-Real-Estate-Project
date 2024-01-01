import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_project/FireStoreCollections.dart';
import 'package:flutter_project/Models/UserModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserAuthentication {
  final FirebaseAuth auth = FirebaseAuth.instance;
  static late UserModel currentUser;

  Future<String> signupWithEmail(
      {required String username,
      required String email,
      required String password}) async {
    try {
      var authResult = await auth.createUserWithEmailAndPassword(
          email: email, password: password);

      currentUser =
          UserModel(id: authResult.user!.uid, email: email, username: username);
      await FireStoreCollections().createUser(currentUser);
    } on FirebaseAuthException catch (e) {
      return e.message.toString();
    }
    return "";
  }

  Future<String> loginWithEmail(
      {required String email, required String password}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      var authResult = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      currentUser = await FireStoreCollections().getUser(authResult.user!.uid);
      prefs.setBool('isLoggedIn', true);
      prefs.setString('userID', currentUser.id);
    } on FirebaseAuthException catch (e) {
      return e.message.toString();
    }
    return "";
  }

}
