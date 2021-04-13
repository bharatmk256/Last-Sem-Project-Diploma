import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:here_sdk/core.dart';
import 'package:here_sdk/gestures.dart';
import 'package:here_sdk/mapview.dart';
import 'package:map_notes/widgetStack/new_note_widget.dart';
import 'package:map_notes/services/get_note.dart';

class GestureHandle {
  BuildContext _context;
  HereMapController _hereMapController;

  FirebaseAuth auth = FirebaseAuth.instance;
  String uid;

  getUser() {
    final User user = auth.currentUser;
    uid = user.uid;
  }

  // void displayNote(BuildContext context, String location) {
  //   final titleTextEditingController = TextEditingController();
  //   final noteTextEditingController = TextEditingController();
  //   DateTime currentPhoneDate = DateTime.now();
  //   Timestamp myTimeStamp = Timestamp.fromDate(currentPhoneDate);
  //
  //   GetNote(location: location, uid: uid).getNote(_context);
  //
  //   showModalBottomSheet(
  //     isScrollControlled: true,
  //     context: context,
  //     builder: (ctx) {
  //       return Container(
  //         height: MediaQuery.of(context).size.height / 1.2,
  //         child: newNoteWidget(
  //           location: location,
  //           myTimeStamp: myTimeStamp,
  //           noteTextEditingController: noteTextEditingController,
  //           titleTextEditingController: titleTextEditingController,
  //           uid: uid,
  //         ),
  //       );
  //     },
  //   );
  // }

  GestureHandle(BuildContext context, HereMapController hereMapController) {
    _context = context;
    _hereMapController = hereMapController;

    //get UID from firebase
    getUser();

    double distanceToEarthInMeaters = 8000;
    _hereMapController.camera.lookAtPointWithDistance(
        GeoCoordinates(23.040257, 72.652564), distanceToEarthInMeaters);

    //23.040257, 72.652564

    // _setTapGestureHandler();
    // _setDoubleTapGestureHandler();
    // _setTwoFingerTapGestureHandler();

    _setLongPressGestureHandler();

    _showDialog(
      "How To!",
      "Long press on particular place to start writing your notes",
    );
  }

  void _setLongPressGestureHandler() {
    _hereMapController.gestures.longPressListener =
        LongPressListener.fromLambdas(lambda_onLongPress:
            (GestureState gestureState, Point2D touchPoint) {
      var geoCoordinates =
          _toString(_hereMapController.viewToGeoCoordinates(touchPoint));

      if (gestureState == GestureState.begin) {
        print(geoCoordinates);

        GetNote(location: geoCoordinates, uid: uid).getNote(_context);

        print("LongPress detected at: $geoCoordinates");
      }
      if (gestureState == GestureState.update) {
        print("LongPress update at: $geoCoordinates");
      }
      if (gestureState == GestureState.end) {
        print("LongPress finger lifted at: $geoCoordinates");
      }
    });
  }

  String _toString(GeoCoordinates geoCoordinates) {
    var latitude = geoCoordinates.latitude;
    var longitude = geoCoordinates.longitude;

    String latitudeS = latitude.toStringAsFixed(4);
    String longitudeS = longitude.toStringAsFixed(4);

    // String latitude = geoCoordinates.latitude.toString();
    // String longitude = geoCoordinates.longitude.toString();

    // return "${geoCoordinates.latitude.toString()} , ${geoCoordinates.longitude.toString()}";
    return "${latitudeS} , ${longitudeS}";
  }

  Future<void> _showDialog(String title, String message) async {
    return showDialog<void>(
      context: _context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(message),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
