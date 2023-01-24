
import 'package:sqqlsoical/screens/ProfilePage/profilescreen.dart';
import 'package:sqqlsoical/screens/SearchPage/searchscreen.dart';
import 'package:sqqlsoical/screens/UploadScreen/uploadscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../FeedScreen/feedscreen.dart';


const webScreenSize = 600;

List<Widget> homeScreenItems() {

  return [
  const FeedScreen(),
  const SearchScreen(),
  const AddPostScreen(),
  const Text('notifications'),
  ProfileScreen(
  uid: FirebaseAuth.instance.currentUser!.uid,
  ),
  ];
}
