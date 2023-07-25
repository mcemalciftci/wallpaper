import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wallpaper/firebase/user_model.dart';
import 'package:wallpaper/screens/home_page.dart';
import 'package:wallpaper/screens/login_page.dart';

class AuthService {
  final userCollection = FirebaseFirestore.instance.collection("users");
  final firebaseAuth = FirebaseAuth.instance;

  Future<void> signUp(BuildContext context,
      {required String name, required String email, required String password}) async {
    final navigator = Navigator.of(context);
    try {
      final UserCredential userCredential =
          await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      if (userCredential.user != null) {
        registerUser(name: name, email: email, password: password);
        navigator.push(MaterialPageRoute(
          builder: (context) => LoginPage(),
        ));
      }
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(msg: e.message!, toastLength: Toast.LENGTH_LONG);
    }
  }

  Future<void> login(BuildContext context, {required String email, required String password}) async {
    final navigator = Navigator.of(context);

    try {
      final UserCredential userCredential =
          await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      if (userCredential.user != null) {
        navigator.push(MaterialPageRoute(
          builder: (context) => HomePage(),
        ));
      }
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(msg: e.message!, toastLength: Toast.LENGTH_LONG);
    }
  }

  Future<void> registerUser({required String name, required String email, required String password}) async {
  final currentUser = firebaseAuth.currentUser;
  if (currentUser != null) {
    await userCollection.doc(currentUser.uid).set({
      "email": email,
      "name": name,
      "password": password,
    });
  }
}


 Future<UserModel?> getCurrentUser() async {
  final currentUser = firebaseAuth.currentUser;
  if (currentUser != null) {
    final snapshot = await userCollection.doc(currentUser.uid).get();
    if (snapshot.exists) {
      final data = snapshot.data() as Map<String, dynamic>;
      return UserModel(name: data['name'], email: data['email']);
    }
  }
  return null;
}


}
