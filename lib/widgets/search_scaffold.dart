import 'package:flutter/material.dart';


class SearchScaffold extends StatefulWidget {
  final List<String> list = List.generate(10, (index) => "Text $index");
  List<Widget> actions = [];
  Widget title;
  Widget body;
  SearchDelegate search;

  SearchScaffold({this.actions, this.title, this.body, this.search});

  @override
  _SearchScaffoldState createState() => _SearchScaffoldState();
}

class _SearchScaffoldState extends State<SearchScaffold> {
  List<Widget> actions = [];
  Widget title;
  Widget body;
  SearchDelegate search;

  _SearchScaffoldState({this.actions, this.title, this.body, this.search});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            onPressed: () {
              showSearch(context: context, delegate: this.search);
            },
            icon: Icon(Icons.search),
          )
        ] + this.actions,
        centerTitle: true,
        title: this.title,
      ),
      body: body
    );
  }
}

