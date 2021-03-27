import 'package:flutter/material.dart';
import "package:data/constants.dart";
import "package:data/widgets/divider.dart";

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Profile"),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.settings),
              tooltip: 'Settings',
              onPressed: () => Navigator.of(context).pushNamed("/settings"),
            ),
          ],
        ),
        body: SingleChildScrollView(
            child: Column(
          children: [
            Card(
                margin: EdgeInsets.only(top: 16, left: 16, right: 16),
                elevation: 1.0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8))),
                color: Colors_.primaryLightest,
                child: Column(children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      onTap: () {},
                      title: Text(
                        "NTUU \"KPI\"",
                        style: TextStyle(
                          color: Colors_.grayscaleDarkest,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      leading: CircleAvatar(
                          backgroundColor: Colors.transparent,
                          backgroundImage: AssetImage(
                              "assets/organisation_profile_picture.png") //NetworkImage(avatars[0]),
                          ),
                      trailing: Icon(
                        Icons.edit,
                        color: Colors_.grayscaleDarkest,
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors_.grayscaleWhite,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(8),
                          bottomRight: Radius.circular(8)),
                    ),
                    child: Column(
                      children: <Widget>[
                        ListTile(
                          leading: Icon(
                            Icons.badge,
                            color: Colors_.primary,
                          ),
                          title: Text("Change Organization"),
                          trailing: Icon(Icons.keyboard_arrow_right),
                          onTap: () {},
                        ),
                      ],
                    ),
                  )
                ])),
            Card(
                margin: EdgeInsets.all(16),
                elevation: 1.0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8))),
                color: Colors_.primary,
                child: Column(children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      onTap: () {},
                      title: Text(
                        "Maksym Korotych",
                        style: TextStyle(
                          color: Colors_.grayscaleWhite,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      leading: CircleAvatar(
                          backgroundImage: AssetImage(
                              "assets/user_profile_picture.png") //NetworkImage(avatars[0]),
                          ),
                      trailing: Icon(
                        Icons.edit,
                        color: Colors_.grayscaleWhite,
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors_.grayscaleWhite,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(8),
                          bottomRight: Radius.circular(8)),
                    ),
                    child: Column(
                      children: <Widget>[
                        ListTile(
                          leading: Icon(
                            Icons.lock_outline,
                            color: Colors_.primary,
                          ),
                          title: Text("Change Password"),
                          trailing: Icon(Icons.keyboard_arrow_right),
                          onTap: () {},
                        ),
                        Divider(
                          height: 0,
                        ),
                        ListTile(
                          leading: Icon(
                            Icons.language,
                            color: Colors_.primary,
                          ),
                          title: Text("Change Locale"),
                          trailing: Icon(Icons.keyboard_arrow_right),
                          onTap: () {},
                        ),
                      ],
                    ),
                  )
                ])),
            Card(
                margin: EdgeInsets.all(16),
                elevation: 1.0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8))),
                color: Colors_.primary,
                child: Container(
                    child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: ListTile(
                          onTap: () {
                            Navigator.popUntil(context, ModalRoute.withName('/main'));

                            Navigator.popAndPushNamed(context, '/welcome');
                          },
                          title: Text(
                            "Logout",
                            style: TextStyle(
                              color: Colors_.grayscaleWhite,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          leading: Icon(
                            Icons.logout,
                            color: Colors_.grayscaleWhite,
                          )),
                    ),
                  ],
                ))),
          ],
        )));
  }
}
