import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:map_notes/services/add_note.dart';

void displayNote(BuildContext context, String location, var uid) {
  final titleTextEditingController = TextEditingController();
  final noteTextEditingController = TextEditingController();
  DateTime currentPhoneDate = DateTime.now();
  Timestamp myTimeStamp = Timestamp.fromDate(currentPhoneDate);

  showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    builder: (ctx) {
      return Container(
        height: MediaQuery.of(context).size.height / 1.2,
        child: newNoteWidget(
          location: location,
          myTimeStamp: myTimeStamp,
          noteTextEditingController: noteTextEditingController,
          titleTextEditingController: titleTextEditingController,
          uid: uid,
        ),
      );
    },
  );
}

Widget newNoteWidget({
  String location,
  var titleTextEditingController,
  var noteTextEditingController,
  var myTimeStamp,
  var uid,
}) {
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
                "Note",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 40,
                ),
              ),
              TextButton(
                onPressed: () {
                  AddNote(
                    location: location,
                    uid: uid,
                    note: noteTextEditingController.text,
                    timeStamp: myTimeStamp,
                    title: titleTextEditingController.text,
                  ).addNote();
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
