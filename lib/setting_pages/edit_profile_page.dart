import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../menus/settings_menu.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {

  var usernameController = TextEditingController();
  dynamic uid;

  _EditProfilePageState() {
    uid = FirebaseAuth.instance.currentUser?.uid;
    FirebaseDatabase.instance.ref().child("users/$uid").once()
        .then((databaseEvent) {
      usernameController.text = databaseEvent.snapshot.child("username").value.toString();
    }).catchError((error) { print(error); });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
        automaticallyImplyLeading: true,
        centerTitle: true,
      ),

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.all(20),
            child: Text(
              'Change Username:',
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
                      labelText: 'Username',
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
                      FirebaseDatabase.instance.ref().child("users/$uid/username").set(usernameController.text)
                          .then((value) {
                        print("Successfully changed username.");
                        Navigator.of(context).pop();
                        // TODO: maybe switch this temporary solution to onUpdate to update the settings page
                        Navigator.of(context).pop();
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SettingsMenu()),
                        );
                      }).catchError((error) { print("Failed to change username. " + error.toString()); });
                    }
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
