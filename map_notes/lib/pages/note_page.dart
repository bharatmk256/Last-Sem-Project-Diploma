import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:map_notes/services/add_note.dart';

Widget noteWidget({
  String location,
  var titleTextEditingController,
  var noteTextEditingController,
  var myTimeStamp,
  var uid,
}) {
  // // final titleTextEditingController = TextEditingController();
  // // final noteTextEditingController = TextEditingController();
  // String titleString;
  // String noteString;
  // String locationOfCurrentNote = location;

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
