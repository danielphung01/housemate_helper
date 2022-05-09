import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:housemate_helper/join_create_group_page.dart';

import '../menus/settings_menu.dart';
import '../resources/fadeAnimation.dart';

class EditGroupSettingsPage extends StatefulWidget {
  const EditGroupSettingsPage({Key? key}) : super(key: key);

  @override
  State<EditGroupSettingsPage> createState() => _EditGroupSettingsPageState();
}

class _EditGroupSettingsPageState extends State<EditGroupSettingsPage> {

  List<String> usernames = <String>[];
  var groupNameController = TextEditingController();
  dynamic user;
  dynamic uid;
  var groupID = "";
  var randomID = "";

  _EditGroupSettingsPageState() {
    user = FirebaseAuth.instance.currentUser;
    uid = user?.uid;
    // Get groupID from user
    FirebaseDatabase.instance.ref().child("users/$uid").once()
      .then((databaseEvent) {
        groupID = databaseEvent.snapshot.child("groupID").value.toString();
        // Get current group name
        FirebaseDatabase.instance.ref().child("groups/$groupID").once()
          .then((databaseEvent) {
            groupNameController.text = databaseEvent.snapshot.child("name").value.toString();
          }).catchError((error) {
            print("Failed to group name");
            print(error);
          });
        randomID = databaseEvent.snapshot.child("randomID").value.toString();

        // Get list of users
        getGroupUsers();

      }).catchError((error) {
        print("Failed to groupID from user");
        print(error);
      });

  }

  void getGroupUsers() {
    FirebaseDatabase.instance.ref().child("groups/$groupID/users").once()
        .then((databaseEvent) {
          Map<dynamic, dynamic> values = databaseEvent.snapshot.value as Map;
          usernames.clear();
          values.forEach((k, v) {
            FirebaseDatabase.instance.ref().child("users/$v/username").once()
                .then((databaseEvent2) {
                  usernames.add(databaseEvent2.snapshot.value.toString());
                  setState(() { });
                })
                .catchError((error) { print("Failed to add user to list of users: " + error.toString()); });
          });
        })
        .catchError((error) { print("failed to load users: " + error); });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Group Settings'),
        automaticallyImplyLeading: true,
        centerTitle: true,
      ),

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.all(20),
            child: Text(
              'Change Group Name:',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(right: 20, left: 20, bottom: 20),
            child: Row(
              children: [
                Expanded(
                  flex: 95,
                  child: TextField(
                    controller: groupNameController,
                    obscureText: false,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Group Name',
                    ),
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Text(''),
                ),
                ElevatedButton(
                  child: Text(
                    'save'
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.blue),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        )
                    ),
                  ),
                  onPressed: () {
                    FirebaseDatabase.instance.ref().child("groups/$groupID/name").set(groupNameController.text)
                      .then((value) {
                        print("Successfully changed group name.");
                        Navigator.of(context).pop();
                        // TODO: maybe switch this temporary solution to onUpdate to update the settings page
                        Navigator.of(context).pop();
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SettingsMenu()),
                        );
                      }).catchError((error) {
                        print("Failed to change group name. " + error.toString());
                      });
                  }
                ),
              ],
            ),
          ),
          Container(
            child: InkWell(
              child: Container(
                padding: EdgeInsets.only(left: 20.0, bottom: 10, top: 10),
                alignment: Alignment.centerLeft,
                width: double.infinity,
                child: const Text(
                  "Leave Group",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.blue,
                  ),
                ),
              ),
              onTap: () {
                // Leave group: set group to null and return to JoinCreateGroupPage
                FirebaseDatabase.instance.ref().child("groups/$groupID/users/$randomID").remove()
                  .then((databaseEvent) {
                    // Set user groupID to null
                    FirebaseDatabase.instance.ref().child("users/$uid/groupID").set("null")
                      .catchError((error) {
                      print("failed to leave group");
                    });
                    // Set user randomID to null
                    FirebaseDatabase.instance.ref().child("users/$uid/randomID").set("null")
                      .catchError((error) {
                      print("failed to leave group");
                    });
                    Navigator.pushAndRemoveUntil(
                      context,
                      FadeRoute(page: JoinCreateGroupPage()),
                      //MaterialPageRoute(builder: (context) => JoinCreateGroupPage()),
                          (Route<dynamic> route) => false,
                    );
                  }).catchError((error) {
                    print("failed to remove user from group");
                  });

              },
            ),
          ),
          const Divider( color: Colors.black ),
          Container(
            margin: EdgeInsets.all(20),
            child: Text(
              'Group Members:',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 20, right: 20),
            child: const Divider( color: Colors.black ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(left: 20, right: 20),
              child: ListView.builder(
                physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                itemCount: usernames.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    contentPadding: EdgeInsets.only(right: 10, left: 10),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text (
                          "-   ${usernames[index]}"
                        ),
                      ],
                    ),
                  );
                }
              ),
            ),
          )
        ],
      ),
    );
  }
}
