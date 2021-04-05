import 'package:firebase_auth/firebase_auth.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class AddUser {
  final String name;
  final String email_id;
  final String phone_number;
  final String profile_pic_url;
  final String username;
  final String uid;

  AddUser({
    this.name,
    this.email_id,
    this.phone_number,
    this.profile_pic_url,
    this.username,
    this.uid,
  }) {
    if (isUserDoesNotExist) {
      addUser();
    } else {
    }
  }

  CollectionReference users = FirebaseFirestore.instance.collection('users');
  final FirebaseAuth auth = FirebaseAuth.instance;

  bool isUserDoesNotExist = false;

  Future getCurrentUserFromFirestore() async {
    FirebaseFirestore.instance
        .collection('users')
        .where('uid', isEqualTo: uid)
        .snapshots()
        .listen((data) {
      isUserDoesNotExist = data.docs[0]['uid'] ? true : false;
    });
  }

  Future<void> addUser() {
    return users
        .add({
          'name': name,
          'email_id': email_id,
          'phone_number': phone_number,
          'profile_pic_url': profile_pic_url,
          'uid': uid,
          'notes_count': "",
          'username': "",
        })
        .then((value) => print('User Added'))
        .catchError((error) => print('Failed to add user'));
  }
}
