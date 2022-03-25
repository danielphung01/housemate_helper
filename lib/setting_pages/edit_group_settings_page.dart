import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class EditGroupSettingsPage extends StatefulWidget {
  const EditGroupSettingsPage({Key? key}) : super(key: key);

  @override
  State<EditGroupSettingsPage> createState() => _EditGroupSettingsPageState();
}

class _EditGroupSettingsPageState extends State<EditGroupSettingsPage> {

  var usernameController = TextEditingController();
  // TODO: get groupID of group that the user that is logged in belongs to rather than hardcoding it
  String groupID = "group0001";

  _EditGroupSettingsPageState() {
    FirebaseDatabase.instance.ref().child("groups/" + groupID + "/name").once()
      .then((databaseEvent) {
        print("Successfully loaded data");
        print("Key: " + databaseEvent.snapshot.key.toString());
        print("Value: " + databaseEvent.snapshot.value.toString());
        usernameController.text = databaseEvent.snapshot.value.toString();
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
                    controller: usernameController,
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
                    FirebaseDatabase.instance.ref().child("groups/" + groupID + "/name").set(usernameController.text)
                      .then((value) {
                        print("Successfully added.");
                      }).catchError((error) {
                        print("Failed to add. " + error.toString());
                      });
                  }
                ),
              ],
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
