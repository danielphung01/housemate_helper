import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:housemate_helper/bottomnavbar_page.dart';
import 'package:housemate_helper/join_create_group_page.dart';
import 'login_page.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}



class _MyHomePageState extends State<MyHomePage> {

  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) => checkLoginStatus());
  }

  void checkLoginStatus() {
    FirebaseAuth.instance.authStateChanges()
        .listen((User? user) {
      if (user == null) { // No user is signed in, go to login page
        print("user is currently signed out");
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
              (Route<dynamic> route) => false,
        );
      } else { // A user is signed in, proceed to app
        print("user is signed in");
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => BottomNavigationBarPage()),
              (Route<dynamic> route) => false,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // TODO: add loading screen here
        ],
      ),
    );
  }
}
