import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:map_notes/screens/widgetStack/loginWidgets.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Color(0xffECECEC),
        ),
        child: LoginWidgets()
      ),
    );
  }
}
