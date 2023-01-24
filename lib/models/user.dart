import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  late String email;
  late String uid;
  late String photoUrl;
  late String username;
  late String bio;
  late List followers;
  late List following;

  //final String phonenumber;

  User({
    required this.username,
    required this.uid,
    required this.photoUrl,
    required this.email,
    required this.bio,
    required this.followers,
    required this.following,
    //   required this.phonenumber
  });

  static User fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
// print(snapshot."username");
    return User(
      username: snapshot["username"] ?? [],
      uid: snapshot["uid"] ?? [],
      email: snapshot["email"] ?? [],
      photoUrl: snapshot["photoUrl"] ?? [],
      bio: snapshot["bio"] ?? [],
      followers: snapshot["followers"] ?? [],
      following: snapshot["following"] ?? [],
      //  phonenumber :snapshot['phonenumber']
    );
  }

  Map<String, dynamic> toJson() => {
        "username": username,
        "uid": uid,
        "email": email,
        "photoUrl": photoUrl,
        "bio": bio,
        "followers": followers,
        "following": following,
      };
}
