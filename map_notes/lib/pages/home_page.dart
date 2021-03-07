import 'package:flutter/material.dart';
import 'package:map_notes/pages/user_profile.dart';
import 'package:map_notes/stores/login_store.dart';
import 'package:provider/provider.dart';
import 'package:here_sdk/core.dart';
import 'package:here_sdk/mapview.dart';
import '../theme.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    SdkContext.init(IsolateOrigin.main);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginStore>(
      builder: (_, loginStore, __) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text("This is testScreen"),
            backgroundColor: MyColors.primaryColor,
            actions: [
              GestureDetector(
                  onTap: () {
                    loginStore.signOut(context);
                  },
                  child: Icon(Icons.offline_bolt_outlined)),
              GestureDetector(
                child: Icon(Icons.person_outline_outlined),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => UserProfile(
                      imageURL:
                          "https://ih1.redbubble.net/image.1003273014.6574/st,small,507x507-pad,600x600,f8f8f8.jpg",
                      email: "Bharat@gmail.com",
                      name: "Bharat",
                      notes: "50",
                      phone: "7898775567",
                      username: "bharatmk",
                    ),
                  ));
                },
              ),
            ],
          ),
          body: Center(
            child: HereMap(
              onMapCreated: _onMapCreated,
            ),
          ),
        );
      },
    );
  }

  void _onMapCreated(HereMapController hereMapController) {
    hereMapController.mapScene.loadSceneForMapScheme(MapScheme.normalDay,
        (MapError error) {
      if (error != null) {
        print('Map scene not loaded. MapError: ${error.toString()}');
        return;
      }
      const double distanceToEarthInMeaters = 8000;
      hereMapController.camera.lookAtPointWithDistance(
          GeoCoordinates(52.530932, 13.384915), distanceToEarthInMeaters);
    });
  }
}
