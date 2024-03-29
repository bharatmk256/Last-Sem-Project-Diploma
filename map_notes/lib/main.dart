import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:map_notes/screens/homeScreen.dart';
import 'package:map_notes/screens/loginScreen.dart';
import 'package:map_notes/screens/noteScreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Map Notes",
      theme: ThemeData.light(),
      // home: MyHome(),
      routes: {
        '/': (context) => ScreensList(),
        'homeScreen': (context) => MyHome(),
        'loginScreen': (context) => LoginScreen(),
        'noteScreen': (context) => NoteScreen(),
      },
    );
  }
}

class ScreensList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              onPressed: () {
                Navigator.pushNamed(context, "loginScreen");
              },
              child: Text("Login Screen"),
            ),
            RaisedButton(
              onPressed: () {
                Navigator.pushNamed(context, "homeScreen");
              },
              child: Text("Home Screen"),
            ),
            RaisedButton(
              onPressed: () {
                Navigator.pushNamed(context, "noteScreen");
              },
              child: Text("Note Screen"),
            ),
          ],
        ),
      ),
    );
  }
}
