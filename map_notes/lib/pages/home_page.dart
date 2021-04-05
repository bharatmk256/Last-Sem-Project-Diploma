import 'package:flutter/material.dart';
import 'package:map_notes/pages/user_profile.dart';
import 'package:map_notes/stores/login_store.dart';
import 'package:provider/provider.dart';
import 'package:here_sdk/core.dart';
import 'package:here_sdk/mapview.dart';
import '../theme.dart';
import '../mapServices/gesture_handler.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  void displayMenu(BuildContext context, store) {
    showModalBottomSheet(
      context: context,
      builder: (ctx) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: Text("About"),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => UserProfile(),
                ));
              },
            ),
            ListTile(
              title: Text("Logout"),
              onTap: () {
                store.signOut(context);
              },
            ),
          ],
        );
      },
    );
  }

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
            elevation: 0,
            title: TextField(
              style: TextStyle(color: MyColors.primaryColor),
              decoration: InputDecoration(
                icon: Icon(Icons.search),
                hintText: "Search",
                border: InputBorder.none,
              ),
            ),
            backgroundColor: Colors.white,
            actions: [
              GestureDetector(
                onTap: () => displayMenu(context, loginStore),
                child: CircleAvatar(
                  backgroundImage: NetworkImage(
                    "https://ih1.redbubble.net/image.1003273014.6574/st,small,507x507-pad,600x600,f8f8f8.jpg",
                  ),
                  radius: 30,
                ),
              ),
            ],
          ),
          body: Stack(
            children: [
              Center(
                child: HereMap(
                  onMapCreated: _onMapCreated,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _onMapCreated(HereMapController hereMapController) {
    hereMapController.mapScene.loadSceneForMapScheme(MapScheme.normalDay,
        (MapError error) {
      if (error == null) {
        GestureHandle(context, hereMapController);
      } else {
        print("Map scene not loaded. MapError: " + error.toString());
      }
    });
  }
}
