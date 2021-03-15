import 'package:flutter/material.dart';
import "package:data/constants.dart";

class PairingScreen extends StatefulWidget {
  @override
  _PairingScreenState createState() => _PairingScreenState();
}

class _PairingScreenState extends State<PairingScreen> {
  TextEditingController _searchQueryController = TextEditingController();
  bool _isSearching = false;
  String searchQuery = "";

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
        title: Text("Device pairing"),
        iconTheme: IconThemeData(color: Colors_.grayscaleWhite),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[

                Container(
                  margin: EdgeInsets.symmetric(vertical: 12, horizontal: 4),
                  child: Text(
                    "Device pairing text haha",
                    style: TextStyle(
                      fontSize: 28,
                      height: 40/28,
                      fontWeight: FontWeight.bold,
                      color: Colors_.grayscaleDarkest,
                    ),),
                ),


              ],
            ),
          ),


        ],
      ),
    );
  }



}