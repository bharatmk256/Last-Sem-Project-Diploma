import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddNote {
  final Timestamp timeStamp;
  final String location;
  final String title;
  final String note;
  final String uid;

  AddNote({
    this.timeStamp,
    this.location,
    this.title,
    this.note,
    this.uid,
  });

  CollectionReference notes = FirebaseFirestore.instance.collection('notes');
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> addNote() {
    return notes
        .add({
          'location': location,
          'note': note,
          'note_title': title,
          'time': timeStamp,
          'uid': uid,
        })
        .then((value) => print('Note Added'))
        .catchError((error) => print('Failed to add Note'));
  }
}
