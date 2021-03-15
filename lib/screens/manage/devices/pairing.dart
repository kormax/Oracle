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
          Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Spacer(),


                Container(
                  margin: EdgeInsets.symmetric(vertical: 12, horizontal: 4),
                  child: Center(child:
                    Column(children: [
                        CircularProgressIndicator(backgroundColor: Colors_.primary,),
                        SizedBox(height: 32,),
                        Text(
                          "Looking for devices...",
                          style: TextStyle(
                            fontSize: 28,
                            height: 32/28,
                            fontWeight: FontWeight.w600,
                            color: Colors_.grayscaleDarkest,
                          ),
                        ),
                      ])
                  )
                ),
                Spacer(),

              ],
            ),
          ),


        ],
      ),
    );
  }



}