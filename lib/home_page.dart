import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
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

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) => checkLoginStatus());
  }

  Future<void> checkLoginStatus() async {
    await Future.delayed(Duration(seconds: 1), (){});
    if (FirebaseAuth.instance.currentUser != null) { // A user is signed in, proceed to app
      print("user is signed in");
      // Check if account is tied to room, if not, go to join_create_group_page
      var uid = FirebaseAuth.instance.currentUser?.uid;
      FirebaseDatabase.instance.ref().child('users/$uid').once()
          .then((databaseEvent) {
        String groupID = databaseEvent.snapshot.child("groupID").value.toString();
        if (groupID != "null") {
          // The user is in a group
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => BottomNavigationBarPage()),
                (Route<dynamic> route) => false,
          );
        } else {
          // The user is not in a group
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => JoinCreateGroupPage()),
                (Route<dynamic> route) => false,
          );
        }
      }).catchError((error) {
        print("Failed to check user's current group");
        print(error);
      });
    } else { // No user is signed in, go to login page
      print("user is currently signed out");
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
            (Route<dynamic> route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.lightBlue,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Loading Screen
              Text(
                "Loading...",
                style: TextStyle(
                  fontSize: 40,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
