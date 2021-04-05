import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GetNote {
  final String location;
  final String uid;

  GetNote({
    this.location,
    this.uid,
  });

  CollectionReference notes = FirebaseFirestore.instance.collection('notes');
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future getNote() {
    return notes
        .where('location', isEqualTo: location)
        .where('uid', isEqualTo: uid)
        .get()
        .then((value) => {print(value.docs[0]['note'])});
  }
}
