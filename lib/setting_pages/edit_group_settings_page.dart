import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:housemate_helper/join_create_group_page.dart';

import '../menus/settings_menu.dart';

class EditGroupSettingsPage extends StatefulWidget {
  const EditGroupSettingsPage({Key? key}) : super(key: key);

  @override
  State<EditGroupSettingsPage> createState() => _EditGroupSettingsPageState();
}

class _EditGroupSettingsPageState extends State<EditGroupSettingsPage> {

  var groupNameController = TextEditingController();
  // TODO: get groupID of group that the user that is logged in belongs to rather than hardcoding it
  String groupID = "group0001";
  dynamic user;
  dynamic uid;

  _EditGroupSettingsPageState() {
    user = FirebaseAuth.instance.currentUser;
    uid = user?.uid;
    FirebaseDatabase.instance.ref().child("groups/$groupID/name").once()
      .then((databaseEvent) {
        print("Successfully loaded data");
        print("Key: " + databaseEvent.snapshot.key.toString());
        print("Value: " + databaseEvent.snapshot.value.toString());
        groupNameController.text = databaseEvent.snapshot.value.toString();
      }).catchError((error) {
        print("Failed to load data");
        print(error);
      });
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
                print("leave group button pressed");
                // Leave group: set group to null and return to JoinCreateGroupPage

                FirebaseDatabase.instance.ref().child("users/$uid/groupID").set("null")
                  .then((value){
                    print("successfully left group");
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => JoinCreateGroupPage()),
                          (Route<dynamic> route) => false,
                    );
                  }).catchError((error) {
                    print("failed to leave group");
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
        ],
      ),
    );
  }
}
