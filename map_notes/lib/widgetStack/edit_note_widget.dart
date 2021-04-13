import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

void displayOldNote(BuildContext context, var uid, var value) {
  final titleTextEditingController = TextEditingController();
  final noteTextEditingController = TextEditingController();
  CollectionReference notes = FirebaseFirestore.instance.collection('notes');

  titleTextEditingController.text = value.docs[0]['note_title'];
  noteTextEditingController.text = value.docs[0]['note'];
  var location = value.docs[0]['location'];
  var oldNoteTime = value.docs[0]['time'];

  showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    builder: (ctx) {
      return Container(
        height: MediaQuery.of(context).size.height / 1.2,
        child: editNoteWidget(
          location: location,
          myTimeStamp: oldNoteTime,
          noteTextEditingController: noteTextEditingController,
          titleTextEditingController: titleTextEditingController,
          uid: uid,
          value: value,
          notes: notes,
        ),
      );
    },
  );
}

Widget editNoteWidget({
  String location,
  var titleTextEditingController,
  var noteTextEditingController,
  var myTimeStamp,
  var uid,
  var value,
  CollectionReference notes,
}) {
  DateTime currentPhoneDate = DateTime.now();
  Timestamp myTimeStamp = Timestamp.fromDate(currentPhoneDate);
  return Padding(
    padding: const EdgeInsets.all(10.0),
    child: Container(
      color: Colors.transparent,
      child: ListView(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Edit Note",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 40,
                ),
              ),
              TextButton(
                onPressed: () {
                  String documentID = value.docs[0].id;
                  notes
                      .doc(documentID)
                      .update({
                        'note': noteTextEditingController.text,
                        'note_title': titleTextEditingController.text,
                        'time': myTimeStamp,
                      })
                      .then((value) => print("updated"))
                      .catchError(
                        (error) => print("Failed to update user: $error"),
                      );
                },
                child: Text(
                  'Save',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
          Divider(
            color: Colors.black,
            thickness: 1,
          ),
          Container(
            alignment: Alignment.topLeft,
            child: Text("Pinned At: $location"),
          ),
          TextField(
            decoration: InputDecoration(
              hintText: "Title",
              border: InputBorder.none,
            ),
            controller: titleTextEditingController,
            style: TextStyle(fontSize: 40),
          ),
          Container(
            height: 600,
            child: TextField(
              keyboardType: TextInputType.multiline,
              maxLines: null,
              decoration: InputDecoration(
                hintText: "Note",
                border: InputBorder.none,
              ),
              controller: noteTextEditingController,
              style: TextStyle(fontSize: 20),
            ),
          ),
        ],
      ),
    ),
  );
}
