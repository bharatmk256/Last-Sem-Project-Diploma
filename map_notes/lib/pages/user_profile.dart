import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:map_notes/theme.dart';

class UserProfile extends StatelessWidget {
  final name, username, email, phone, notes, imageURL;

  // final name = "Bharat",
  //     username = "bharatmk257",
  //     email = "bharatmk257@yahool.com",
  //     phone = "8877867826",
  //     notes = 30;
  UserProfile({
    this.email,
    this.name,
    this.imageURL,
    this.notes,
    this.phone,
    this.username,
  });
  @override
  Widget build(BuildContext context) {
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
                    imageURL,
                  ),
                  radius: 100,
                ),
                SizedBox(
                  height: 50,
                ),
                infoCardBuilder(
                  leading: Icon(
                    Icons.person,
                  ),
                  title: "Name",
                  subtitle: "$name",
                  trailing: Icon(
                    CupertinoIcons.pencil,
                  ),
                ),
                infoCardBuilder(
                  leading: Icon(Icons.verified),
                  subtitle: "$username",
                  title: "UserName",
                  trailing: Icon(CupertinoIcons.pencil),
                ),
                infoCardBuilder(
                  leading: Icon(Icons.mail),
                  subtitle: "$email",
                  title: "Email",
                  trailing: Icon(CupertinoIcons.pencil),
                ),
                infoCardBuilder(
                  leading: Icon(Icons.phone),
                  subtitle: "$phone",
                  title: "Phone",
                  trailing: null,
                ),
                infoCardBuilder(
                  leading: Icon(Icons.notes_outlined),
                  subtitle: "$notes",
                  title: "Notes",
                  trailing: null,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Card infoCardBuilder({var title, var subtitle, var leading, var trailing}) {
    return Card(
      elevation: 4,
      child: ListTile(
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
