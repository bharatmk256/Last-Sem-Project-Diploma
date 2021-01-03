import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginWidgets extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    String dropdownValue = '+91 - India';
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Container(
          height: screenHeight / 2,
          color: Color(0xff00203F),
        ),
        Column(
          children: [
            Expanded(
              flex: 1,
              child: Container(),
            ),
            Expanded(
              flex: 2,
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Container(
                      height: MediaQuery.of(context).size.height/1.5,
                      alignment: Alignment.bottomCenter,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black45,
                            blurRadius: 10.0,
                            spreadRadius: 2.0,
                          ),
                        ],
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25.0),
                          topRight: Radius.circular(25.0),
                        ),
                      ),
                      padding: EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            "Enter Country Code & phone number",
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Container(
                            width: 500,
                            child: DropdownButton<String>(
                              value: dropdownValue,
                              underline: Container(
                                height: 1,
                                color: Colors.black38,
                              ),
                              onChanged: (String newValue) {},
                              items: <String>[
                                '+91 - India',
                                '+92 - India',
                                '+93 - India',
                                '+94 - India'
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                            padding: EdgeInsets.only(top: 20.0, bottom: 10.0),
                          ),
                          TextField(
                            decoration: InputDecoration(hintText: "9876546378"),
                          ),
                          Container(
                            height: 90.0,
                          ),
                          Text(
                            "We will Send You a One Time Password\nto your mobile number",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          Container(
                            height: 30.0,
                          ),
                          RaisedButton(
                            padding: EdgeInsets.only(
                              left: 40.0,
                              right: 40.0,
                              top: 15.0,
                              bottom: 15.0,
                            ),
                            onPressed: () {},
                            color: Color(0xff00203F),
                            child: Text(
                              "SEND OTP",
                              style: TextStyle(color: Colors.white),
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
