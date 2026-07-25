import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo/models/user_model.dart';
import 'package:todo/shared/network/firebase/firebase_functions.dart';

class MyProvider extends ChangeNotifier {
  UserModel? myUser;

  Future<void> initUser() async {
    User? firebaseUser = FirebaseAuth.instance.currentUser;
    if (firebaseUser != null) {
      myUser = await FirebaseFunctions.readUser(firebaseUser.uid);
      print("Loaded User: ${myUser?.name}");
      notifyListeners();
    }
  }

  void updateUser(UserModel? newUser) {
    myUser = newUser;
    notifyListeners();
  }
}
