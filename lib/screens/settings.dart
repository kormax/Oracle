import 'package:flutter/material.dart';
import "package:data/constants.dart";

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {


  @override
  void initState(){
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  Colors_.grayscaleWhite,
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(color: Colors_.grayscaleWhite),
        title: Text(
          'Settings',
          style: TextStyle(color: Colors_.grayscaleWhite),
        ),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Notification Settings",
                  style: TextStyle(
                    fontSize: 28,
                    height: 40/28,
                    fontWeight: FontWeight.bold,
                    color: Colors_.primary,
                  ),
                ),
                SizedBox(height: 24),
                Text(
                  "Send notification when task is:",
                  style: TextStyle(
                    fontSize: 22,
                    height: 24/22,
                    fontWeight: FontWeight.normal,
                    color: Colors_.grayscaleDarkest,
                  ),
                ),
                SizedBox(height: 8),
                SwitchListTile(
                  activeColor: Colors_.primary,
                  contentPadding: const EdgeInsets.all(0),
                  value: true,
                  title: Text("Assigned"),
                  onChanged: (val) {},
                ),
                SwitchListTile(
                  activeColor:  Colors_.primary,
                  contentPadding: const EdgeInsets.all(0),
                  value: false,
                  title: Text("Cancelled"),
                  onChanged: null,
                ),
                SwitchListTile(
                  activeColor: Colors_.primary,
                  contentPadding: const EdgeInsets.all(0),
                  value: true,
                  title: Text("Updated"),
                  onChanged: (val) {},
                ),
                SwitchListTile(
                  activeColor:  Colors_.primary,
                  contentPadding: const EdgeInsets.all(0),
                  value: true,
                  title: Text("Expiring"),
                  onChanged: null,
                ),
                SizedBox(height: 24),
                Text(
                  "Send notification in case of:",
                  style: TextStyle(
                    fontSize: 22,
                    height: 24/22,
                    fontWeight: FontWeight.normal,
                    color: Colors_.grayscaleDarkest,
                  ),
                ),
                SizedBox(height: 8),
                SwitchListTile(
                  activeColor: Colors_.primary,
                  contentPadding: const EdgeInsets.all(0),
                  value: true,
                  title: Text("High priority risks"),
                  onChanged: (val) {},
                ),
                SwitchListTile(
                  activeColor: Colors_.primary,
                  contentPadding: const EdgeInsets.all(0),
                  value: true,
                  title: Text("Medium priority risks"),
                  onChanged: (val) {},
                ),
                SwitchListTile(
                  activeColor: Colors_.primary,
                  contentPadding: const EdgeInsets.all(0),
                  value: true,
                  title: Text("Low priority risks"),
                  onChanged: (val) {},
                ),

              ],
            ),
          ),


        ],
      ),
    );
  }


}