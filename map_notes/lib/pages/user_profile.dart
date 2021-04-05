import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:map_notes/theme.dart';

class UserProfile extends StatefulWidget {
  FirebaseAuth auth = FirebaseAuth.instance;
  String uid;

  getUser() {
    final User user = auth.currentUser;
    uid = user.uid;
  }

  UserProfile() {
    getUser();
  }

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  CollectionReference user = FirebaseFirestore.instance.collection('users');

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: user.where('uid', isEqualTo: widget.uid).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data.docs[0]['uid'] == widget.uid) {
          final List<DocumentSnapshot> document = snapshot.data.docs;
          String documentID = document[0].id;
          return MaterialApp(
            home: Scaffold(
              backgroundColor: MyColors.primaryColor,
              body: Container(
                padding: EdgeInsets.all(20),
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(
                          document[0]['profile_pic_url'],
                        ),
                        radius: 100,
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      infoCardBuilder(
                        documentID: documentID,
                        fKey: 'name',
                        leading: Icon(Icons.person),
                        title: "Name",
                        subtitle: document[0]['name'],
                        trailing: Icon(
                          CupertinoIcons.pencil,
                        ),
                      ),
                      infoCardBuilder(
                        documentID: documentID,
                        fKey: 'username',
                        leading: Icon(Icons.verified),
                        subtitle: document[0]['username'],
                        title: "UserName",
                        trailing: Icon(CupertinoIcons.pencil),
                      ),
                      infoCardBuilder(
                        documentID: documentID,
                        fKey: 'email_id',
                        leading: Icon(Icons.mail),
                        subtitle: document[0]['email_id'],
                        title: "Email",
                        trailing: Icon(CupertinoIcons.pencil),
                      ),
                      infoCardBuilder(
                        leading: Icon(Icons.phone),
                        subtitle: document[0]['phone_number'],
                        title: "Phone",
                        trailing: null,
                      ),
                      infoCardBuilder(
                        documentID: documentID,
                        leading: Icon(Icons.notes_outlined),
                        subtitle: document[0]['notes_count'],
                        title: "Notes",
                        trailing: null,
                      ),
                      infoCardBuilder(
                        leading: Icon(Icons.notes_outlined),
                        subtitle: document[0]['uid'],
                        title: "UID",
                        trailing: null,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        } else {
          return Scaffold();
        }
      },
    );
  }

  Card infoCardBuilder({
    var title,
    var subtitle,
    var leading,
    var trailing,
    var fKey,
    var documentID,
  }) {
    String changedText;
    return Card(
      elevation: 4,
      child: ListTile(
        onTap: () {
          if (trailing != null) {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text('Change $title'),
                  content: TextField(
                    onChanged: (value) => changedText = value,
                    decoration: InputDecoration(
                      labelText: '$title',
                    ),
                  ),
                  actions: [
                    ElevatedButton(
                      onPressed: () {
                        user
                            .doc(documentID)
                            .update({fKey: changedText})
                            .then((value) => print('user updated'))
                            .catchError((error) =>
                                print("Failed to update user: $error"));
                        Navigator.of(context).pop();
                      },
                      child: Text('Save'),
                    ),
                    ElevatedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text('Cancel'),
                    )
                  ],
                );
              },
            );
          }
        },
        leading: leading,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.w400,
                color: Colors.grey,
                fontSize: 13,
              ),
            ),
            Text(
              subtitle,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 17,
              ),
            ),
          ],
        ),
        trailing: trailing,
      ),
    );
  }
}
