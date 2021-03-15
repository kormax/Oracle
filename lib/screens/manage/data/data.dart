import 'package:flutter/material.dart';
import "package:data/constants.dart";

class DataScreen extends StatefulWidget {
  @override
  _DataScreenState createState() => _DataScreenState();
}

class _DataScreenState extends State<DataScreen> {
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
        title: _isSearching ? _buildSearchField() : _buildTitle(),
        actions: _buildActions(),
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
                      Text(
                        "No data",
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
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _createData,
        backgroundColor: Colors_.primaryNormal,
        icon: const Icon(Icons.add, color: Colors_.grayscaleWhite,),
        label: const Text('Add data', style: TextStyle(color: Colors_.grayscaleWhite,)),
      )
    );
  }
  Widget _buildSearchField() {
    return TextField(
      controller: _searchQueryController,
      autofocus: true,
      decoration: InputDecoration(
        hintText: "Enter search query...",
        border: InputBorder.none,
        hintStyle: TextStyle(color: Colors.white30),
      ),
      style: TextStyle(color:  Colors_.grayscaleWhite, fontSize: 16.0),
      onChanged: (query) => updateSearchQuery(query),
    );
  }

  Widget _buildTitle() {
    return Text("Data");
  }

  List<Widget> _buildActions() {
    if (_isSearching) {
      return <Widget>[
        IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            if (_searchQueryController == null ||
                _searchQueryController.text.isEmpty) {
              Navigator.pop(context);
              return;
            }
            _clearSearchQuery();
          },
        ),
      ];
    }

    return <Widget>[
      IconButton(
        icon: const Icon(Icons.search),
        onPressed: _startSearch,
      ),
    ];
  }

  void _startSearch() {
    ModalRoute.of(context)
        .addLocalHistoryEntry(LocalHistoryEntry(onRemove: _stopSearching));

    setState(() {
      _isSearching = true;
    });
  }

  void updateSearchQuery(String newQuery) {
    setState(() {
      searchQuery = newQuery;
    });
  }

  void _stopSearching() {
    _clearSearchQuery();

    setState(() {
      _isSearching = false;
    });
  }

  void _clearSearchQuery() {
    setState(() {
      _searchQueryController.clear();
      updateSearchQuery("");
    });
  }

  void _createData() {
    Navigator.pushNamed(context, "/data/edit");
  }

}