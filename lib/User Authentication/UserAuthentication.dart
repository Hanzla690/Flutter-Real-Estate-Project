import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/FireStoreCollections.dart';
import 'package:flutter_project/Models/UserModel.dart';

class UserAuthentication {
  final FirebaseAuth auth = FirebaseAuth.instance;
  static late UserModel currentUser;

  Future<UserModel> signupWithEmail(
      {required String username,
      required String email,
      required String password}) async {
    // if (username.isEmpty || email.isEmpty || password.isEmpty) {
    //   debugPrint('null value');
    // }
    try {
      var authResult = await auth.createUserWithEmailAndPassword(
          email: email, password: password);

      currentUser =
          UserModel(id: authResult.user!.uid, email: email, username: username);
      await FireStoreCollections().createUser(currentUser);

    } catch (e) {
      debugPrint(e.toString());
    }
      return currentUser;
  }

  Future<UserModel> loginWithEmail({required String email, required String password}) async{
    try{
    var authResult = await auth.signInWithEmailAndPassword(email: email, password: password);
    currentUser = await FireStoreCollections().getUser(authResult.user!.uid);
    }catch(e){
      debugPrint(e.toString());
    }
    return currentUser;
  }
}
