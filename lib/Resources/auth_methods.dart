import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sqqlsoical/Resources/storage_methods.dart';
import 'package:sqqlsoical/screens/FeedScreen/feedscreen.dart';
import 'package:sqqlsoical/screens/LoginPage/loginpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sqqlsoical/models/user.dart' as model;
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:page_transition/page_transition.dart';

import '../utils/utils.dart';


class AuthMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User get user => _auth.currentUser!;

  // get user details
  Future<model.User> getUserDetails() async {
    User currentUser = _auth.currentUser!;

    DocumentSnapshot documentSnapshot =
    await _firestore.collection('users').doc(currentUser.uid).get();

    return model.User.fromSnap(documentSnapshot);
  }

  // Signing Up User

  Future<String> signUpUser(
      {
    required String email,
    required String password,
    required String username,
    required String bio,
    required Uint8List file,
        required String phonenumber,
  }) async {
    String res = "Some error Occurred";
    try {
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          username.isNotEmpty ||
          bio.isNotEmpty ||
          file != null) {
        // registering user in auth with email and password
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
        final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;
        final credential = GoogleAuthProvider.credential(
            accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);

        UserCredential userCredential =
        await _auth.signInWithCredential(credential);
        User? user = userCredential.user;


        String photoUrl =
        await StorageMethods().uploadImageToStorage('profilePics', file, false);

        model.User _user = model.User(
          username: username,
          uid: cred.user!.uid,
          photoUrl: photoUrl,
          email: email,
          bio: bio,
          //phonenumber:phonenumber
       //   phone: getPhone,
          followers: [],
          following: [],
        );

        // adding user in our database
        await _firestore
            .collection("users")
            .doc(cred.user!.uid)
            .set(_user.toJson()).whenComplete(() {
          res = "success";
        });


      } else {
        res = "Please enter all the fields";
      }
    } catch (err) {
      return err.toString();
    }
    return res;
  }

  // logging in user
   loginUser({

    required String email,
    required String password,
  }) async {
    String res = "Some error Occurred";
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        // logging in user with email and password
        await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        ).whenComplete((){
          res = "success";
        });

      } else {
        res = "Please enter all the fields";
        return  const SnackBar(content: Text("Please try again"));
      }
    } catch (err) {
      return err.toString();
    }
    return res;
  }

  Future<bool> signInWithGoogle(BuildContext context) async {
    bool result = false;
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth =
      await googleUser?.authentication;
      final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);

      UserCredential userCredential =
      await _auth.signInWithCredential(credential);
      User? user = userCredential.user;
   /*   String photoUrl =
      await StorageMethods().uploadImageToStorage('profilePics', user.photoURL, false);
*/

      if (user != null && !user.emailVerified) {
        if (userCredential.additionalUserInfo!.isNewUser) {
          // add the data to fire base

          await _firestore.collection('users').doc(user.uid).set(
              {
                'username' : user.displayName,
                'uid' : user.uid,
                'photoUrl' : user.photoURL,
                'email':user.emailVerified
              }
          ).whenComplete(() => Navigator.push(context, MaterialPageRoute(builder: (context) => FeedScreen())));

        }
        result = true;
      }
      return result;
    } catch (e) {
      print(e);
    }
    return result;
  }


  Future passwordReset(BuildContext context,String email)async{
    try{
      await _auth.sendPasswordResetEmail(email: email);
    }catch(e){
      showSnackBar(context, e.toString());
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
