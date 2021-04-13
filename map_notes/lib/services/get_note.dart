import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:map_notes/widgetStack/edit_note_widget.dart';
import 'package:map_notes/widgetStack/new_note_widget.dart';

class GetNote {
  final String location;
  final String uid;

  GetNote({
    this.location,
    this.uid,
  });

  CollectionReference notes = FirebaseFirestore.instance.collection('notes');
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future getNote(_context) {
    return notes
        .where('location', isEqualTo: location)
        .where('uid', isEqualTo: uid)
        .get()
        .then((value) => {displayOldNote(_context, uid, value)})
        .catchError((error) => {displayNote(_context, location, uid)});
  }
}

//print('Got this${value.docs[0]['note']}')
