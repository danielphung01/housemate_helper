import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:housemate_helper/menus/notes_menu.dart';
import 'package:housemate_helper/menus/settings_menu.dart';

class EventsMenu extends StatefulWidget {
  const EventsMenu({Key? key}) : super(key: key);

  @override
  _EventsMenuState createState() => _EventsMenuState();
}

class _EventsMenuState extends State<EventsMenu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            child: RaisedButton(
              child: Text('temp button'),
              onPressed: () {
                print("button Pressed");
                // TEMP BUTTON
                FirebaseAuth.instance.authStateChanges()
                  .listen((User? user) {
                    if (user == null) {
                      print("user is currently signed out");
                    } else {
                      print("user is signed in");
                    }
                  });
              },
            ),
          ),
        ],
      ),
    );
  }
}