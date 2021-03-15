import "package:data/constants.dart";
import 'package:data/screens/initial/signup.dart';
import 'package:data/screens/profile.dart';
import 'package:data/screens/settings.dart';
import 'package:data/screens/tasks/tasks.dart';
import 'package:data/screens/today.dart';
import 'package:flutter/material.dart';

import 'actions/actions.dart';
import 'initial/login.dart';
import 'initial/welcome.dart';

class MainScreen extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          primaryColor: Colors_.primary,
          accentColor: Colors_.primaryLight,
          textTheme: TextTheme(
              headline1: TextStyle(color: Colors_.grayscaleDarkest),
              headline2: TextStyle(color: Colors_.grayscaleDarkest),
              headline3: TextStyle(color: Colors_.grayscaleDarkest),
              headline4: TextStyle(color: Colors_.grayscaleDarkest),
              headline5: TextStyle(color: Colors_.grayscaleDarkest),
              headline6: TextStyle(color: Colors_.grayscaleDarkest),
              bodyText1: TextStyle(color: Colors_.grayscaleDarkest),
              bodyText2: TextStyle(color: Colors_.grayscaleDarkest),
              subtitle1: TextStyle(color: Colors_.grayscaleDarkest),
              subtitle2: TextStyle(color: Colors_.grayscaleDarkest),
          ),
          fontFamily: 'Rubik',
          backgroundColor: Colors_.grayscaleWhite,
          disabledColor: Colors_.disabledPrimary
      ),
      debugShowCheckedModeBanner: false,

      initialRoute: '/welcome',
      routes: {
        "/welcome": (context) => OnboardingScreen(),
        "/signup": (context) => SignUpScreen(),
        "/login": (context) => LoginScreen(),
        "/main": (context) => MainNavigationScreen(defaultPage: "today",),
        "/profile": (context) => ProfileScreen(),
        "/settings": (context) => SettingsScreen()
      }
    );
  }
}


class MainNavigationScreen extends StatefulWidget {
  final defaultPage;

  const MainNavigationScreen({
    this.defaultPage = "today",
    Key key,
  }) : super(key: key);

  @override
  _MainNavigationScreenState createState() => new _MainNavigationScreenState(defaultPage: this.defaultPage);
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  String defaultPage = "";
  int _pageIndex = 0;
  PageController _pageController;

  _MainNavigationScreenState({
    @required this.defaultPage,
  });

  List<Widget> tabPages = [
    TodayScreen(),
    TasksScreen(),
    ActionsScreen(),
  ];

  @override
  void initState(){
    super.initState();
    switch(defaultPage) {
      case "today":
        _pageIndex = 0;
        break;
      case "tasks":
        _pageIndex = 1;
        break;
      case "actions":
        _pageIndex = 2;
        break;
    }
    _pageController = PageController(initialPage: _pageIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            "",
            style: TextStyle(color: Colors_.grayscaleWhite)
        ),
        backgroundColor: Colors_.primary,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.supervised_user_circle_outlined),
            tooltip: 'Profile',
            onPressed: () =>
                Navigator.of(context).pushNamed("/profile"),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _pageIndex,
        onTap: onTabTapped,
        backgroundColor: Colors_.grayscaleWhite,
        selectedItemColor: Colors_.selectedPrimary,

        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.today),
            label: 'Today',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.all_inbox_rounded),
            label: 'Tasks',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_chart),
            label: 'Actions',
          ),
        ],

      ),

      body: PageView(
        children: tabPages,
        onPageChanged: onPageChanged,
        controller: _pageController,
      ),
    );
  }
  void onPageChanged(int page) {
    setState(() {
      this._pageIndex = page;
    });
  }

  void onTabTapped(int index) {
    this._pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut
    );
  }
}

