import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:housemate_helper/login_page.dart';
import 'package:housemate_helper/setting_pages/edit_group_settings_page.dart';
import 'package:housemate_helper/setting_pages/edit_profile_page.dart';
import 'package:housemate_helper/setting_pages/make_annoucement_page.dart';

class SettingsMenu extends StatefulWidget {
  const SettingsMenu({Key? key}) : super(key: key);

  @override
  _SettingsMenuState createState() => _SettingsMenuState();
}

class _SettingsMenuState extends State<SettingsMenu> {

  var username = TextEditingController();
  var groupName = TextEditingController();
  var inviteCode = TextEditingController();
  // TODO: get groupID of group that the user that is logged in belongs to rather than hardcoding it

  _SettingsMenuState() {
    fillData();
  }

  void fillData() {
    // Get user data
    final user = FirebaseAuth.instance.currentUser;
    final uid = user?.uid;
    FirebaseDatabase.instance.ref().child("users/" + uid!).once()
      .then((databaseEvent) {
        print("Successfully loaded user data");
        username.text = databaseEvent.snapshot.child("username").value.toString();

        // Get group data
        String groupID = databaseEvent.snapshot.child("groupID").value.toString();
        FirebaseDatabase.instance.ref().child('groups/$groupID').once()
          .then((databaseEvent) {
            groupName.text = databaseEvent.snapshot.child("name").value.toString();
            inviteCode.text = databaseEvent.snapshot.child("code").value.toString();
            print("Successfully loaded group data");
            print(databaseEvent.snapshot.toString());
            setState(() {
            });
          }).catchError((error) {
            print("Failed to load group data");
            print(error);
          });
        }).catchError((error) {
          print("Failed to load user data");
          print(error);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Settings'),
        automaticallyImplyLeading: true,
      ),

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 15,
            child: Container(
              padding: EdgeInsets.only(left: 20.0),
              child: Row(
                children: [
                  Icon (
                    Icons.person,
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 20.0),
                    child: Text(
                      username.text,
                      style: TextStyle(
                        fontSize: 25,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          const Divider( color: Colors.black ),
          Expanded(
            flex: 7,
            child: Row(
              children: [
                Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(left: 20.0),
                child: const Text(
                    "Group Name: ",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
                Text(
                  groupName.text,
                  style: TextStyle(
                    fontSize: 17,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 7,
            child: Row(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(left: 20.0),
                  child: const Text(
                    "Invite Code: ",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
                Text(
                  inviteCode.text,
                  style: TextStyle(
                    fontSize: 17,
                  ),
                ),
              ],
            ),
          ),
          const Divider( color: Colors.black ),
          Expanded(
            flex: 8,
            child: InkWell(
              child: Container(
                padding: EdgeInsets.only(left: 20.0),
                alignment: Alignment.centerLeft,
                width: double.infinity,
                child: const Text(
                  "Make Announcement",
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MakeAnnouncementPage()),
                );
              },
            ),
          ),
          Expanded(
            flex: 8,
            child: InkWell(
              child: Container(
                padding: EdgeInsets.only(left: 20.0),
                alignment: Alignment.centerLeft,
                width: double.infinity,
                child: const Text(
                  "Edit Profile",
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EditProfilePage()),
                );
              },
            ),
          ),
          Expanded(
            flex: 8,
            child: InkWell(
              child: Container(
                padding: EdgeInsets.only(left: 20.0),
                alignment: Alignment.centerLeft,
                width: double.infinity,
                child: const Text(
                  "Edit Group Settings",
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EditGroupSettingsPage()),
                );
              },
            ),
          ),
          Expanded(
            flex: 8,
            child: InkWell(
              child: Container(
                padding: EdgeInsets.only(left: 20.0),
                alignment: Alignment.centerLeft,
                width: double.infinity,
                child: const Text(
                  "Log Out",
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
              ),
              onTap: () async {
                print("log out button pressed");
                // Log out of account
                await FirebaseAuth.instance.signOut();
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                    (Route<dynamic> route) => false,
                );
              },
            ),
          ),
          // SPACE
          Expanded(
            flex: 51,
            child: Text(
                ""
            ),
          ),
        ],
      ),
    );
  }
}
