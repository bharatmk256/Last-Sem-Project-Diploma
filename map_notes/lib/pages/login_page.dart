import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:map_notes/stores/login_store.dart';
import 'package:map_notes/widgets/loader_hud.dart';
import 'package:provider/provider.dart';
import 'package:country_code_picker/country_code_picker.dart';

import '../theme.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key key}) : super(key: key);
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    String selectedCountrycode = '91';
    return Consumer<LoginStore>(
      builder: (_, loginStore, __) {
        return Observer(
          builder: (_) => LoaderHUD(
            inAsyncCall: loginStore.isLoginLoading,
            child: Scaffold(
              backgroundColor: Colors.white,
              key: loginStore.loginScaffoldKey,
              body: SafeArea(
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Container(
                      height: screenHeight / 2,
                      color: MyColors.primaryColor,
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
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.height / 1.5,
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
                                        "Select Country Code & phone number",
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
                                        child: CountryCodePicker(
                                          dialogSize: Size(500, 500),
                                          onChanged: (CountryCode countryCode) {
                                            selectedCountrycode =
                                                countryCode.toString();
                                          },
                                          showFlagMain: false,
                                          textStyle: TextStyle(
                                            fontSize: 20.0,
                                            color: Colors.black54,
                                          ),
                                          initialSelection: 'IN',
                                          alignLeft: true,
                                        ),
                                        decoration: BoxDecoration(
                                          border: Border(
                                            bottom: BorderSide(
                                              color: Colors.black,
                                              style: BorderStyle.solid,
                                            ),
                                          ),
                                        ),
                                        margin: EdgeInsets.only(
                                          top: 20.0,
                                          bottom: 20.0,
                                        ),
                                      ),
                                      TextField(
                                        decoration: InputDecoration(
                                          hintText: "1234567890",
                                        ),
                                        style: TextStyle(
                                          letterSpacing: 4.0,
                                          fontSize: 20.0,
                                          color: Colors.black54,
                                        ),
                                        keyboardType: TextInputType.phone,
                                        maxLines: 1,
                                        controller: phoneController,
                                      ),
                                      SizedBox(
                                        height: 90.0,
                                      ),
                                      Text(
                                        "We will Send You a One Time Password\nto your mobile number",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w300,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 30.0,
                                      ),
                                      Container(
                                        constraints:
                                            const BoxConstraints(maxWidth: 500),
                                        child: RaisedButton(
                                          onPressed: () {
                                            if (phoneController
                                                .text.isNotEmpty) {
                                              loginStore.getCodeWithPhoneNumber(
                                                context,
                                                "+" +
                                                    selectedCountrycode +
                                                    phoneController.text
                                                        .toString(),
                                              );
                                            } else {
                                              loginStore
                                                  .loginScaffoldKey.currentState
                                                  .showSnackBar(
                                                SnackBar(
                                                  behavior:
                                                      SnackBarBehavior.floating,
                                                  backgroundColor: Colors.red,
                                                  content: Text(
                                                    'Please enter a phone number',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              );
                                            }
                                          },
                                          color: MyColors.primaryColor,
                                          shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(14))),
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 8, horizontal: 8),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: <Widget>[
                                                Text(
                                                  'Next',
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                                Container(
                                                  padding:
                                                      const EdgeInsets.all(8),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                            Radius.circular(
                                                                20)),
                                                    color: MyColors
                                                        .primaryColorLight,
                                                  ),
                                                  child: Icon(
                                                    Icons.arrow_forward_ios,
                                                    color: Colors.white,
                                                    size: 16,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      )
                                      // start of raised Button
                                      /*
                                      RaisedButton(
                                        // padding: EdgeInsets.only(
                                        //   left: 40.0,
                                        //   right: 40.0,
                                        //   top: 15.0,
                                        //   bottom: 15.0,
                                        // ),
                                         shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(14))),
                                        onPressed: () {
                                          if (phoneController.text.isNotEmpty) {
                                            loginStore.getCodeWithPhoneNumber(
                                              context,
                                              "+" +
                                                  selectedCountrycode +
                                                  phoneController.text
                                                      .toString(),
                                            );
                                          } else {
                                            loginStore
                                                .loginScaffoldKey.currentState
                                                .showSnackBar(
                                              SnackBar(
                                                behavior:
                                                    SnackBarBehavior.floating,
                                                backgroundColor: Colors.red,
                                                content: Text(
                                                  'Please enter a phone number',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            );
                                          }
                                        },
                                        color: Color(0xff00203F),
                                        child: Text(
                                          "SEND OTP",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        // shape: RoundedRectangleBorder(
                                        //   borderRadius:
                                        //       BorderRadius.circular(50.0),
                                        // ),
                                      )
                                      */
                                      // end of raised button
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
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
