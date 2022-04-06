import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:housemate_helper/bottomnavbar_page.dart';

import 'login_page.dart';

class JoinCreateGroupPage extends StatefulWidget {
  const JoinCreateGroupPage({Key? key}) : super(key: key);

  @override
  _JoinCreateGroupPageState createState() => _JoinCreateGroupPageState();
}

class _JoinCreateGroupPageState extends State<JoinCreateGroupPage> {

  var inviteCode = TextEditingController();
  var groupName = TextEditingController();
  var uid;

  _JoinCreateGroupPageState() {
    final user = FirebaseAuth.instance.currentUser;
    uid = user?.uid;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Housemate Helper'),
        automaticallyImplyLeading: false
      ),
      body: Column(
        children: [
          Expanded(
            flex: 10,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                margin: EdgeInsets.only(left: 15),
                child: Text(
                  'Join an existing group:',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 10,
            child: Row(
              children: [
                Expanded(
                  flex: 85,
                  child: Container(
                    margin: EdgeInsets.only(left: 15, right: 15),
                    child: TextField(
                      controller: inviteCode,
                      obscureText: false,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'invite code',
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 15,
                  child: Container(
                    margin: EdgeInsets.only(right: 15),
                    child: ElevatedButton(
                      child: null,
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.teal),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          )
                        ),
                      ),
                        onPressed: () {
                          print("invite code used");
                          /*
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => BottomNavigationBarPage()),
                                (Route<dynamic> route) => false,
                          );
                          */
                          // TODO: check if group exists
                          FirebaseDatabase.instance.ref().child("groupCodes").once()
                            .then((databaseEvent) {
                              var groupID = databaseEvent.snapshot.child(inviteCode.text).value.toString();
                              if (groupID == "null") { // Group doesn't exist
                                print("group doesn't exist, alert user");
                                // TODO: Alert user

                              } else { // Group exists
                                print("group exists, joining");
                                // Set user's current group
                                FirebaseDatabase.instance.ref().child("users/$uid/groupID").set(groupID)
                                  .then((databaseEvent2) {
                                    print(" Success");
                                    // Add user to group list
                                    Random random = Random(DateTime.now().millisecondsSinceEpoch);
                                    var randomID = DateTime.now().millisecondsSinceEpoch.toString() + random.nextInt(9).toString();
                                    FirebaseDatabase.instance.ref().child("groups/$groupID/users/$randomID").set(uid)
                                        .catchError((error) {
                                          print("Failed to add user to group list.");
                                        });
                                    // Set user's current group randomID
                                    FirebaseDatabase.instance.ref().child("users/$uid/randomID").set(randomID)
                                      .catchError((error) {
                                        print("Failed set user randomID.");
                                      });
                                    // Continue to app
                                    Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(builder: (context) => BottomNavigationBarPage()),
                                          (Route<dynamic> route) => false,
                                    );
                                  }).catchError((error) {
                                    print("Failed to change user's group");
                                  });
                              }
                            }).catchError((error) {
                              print(error);
                            });
                          // TODO: join group with code
                        }
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 10,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                margin: EdgeInsets.only(left: 15),
                child: Text(
                  'Create a new group:',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 10,
            child: Row(
              children: [
                Expanded(
                  flex: 85,
                  child: Container(
                    margin: EdgeInsets.only(left: 15, right: 15),
                    child: TextField(
                      controller: groupName,
                      obscureText: false,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'group name',
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 15,
                  child: Container(
                    margin: EdgeInsets.only(right: 15),
                    child: ElevatedButton(
                        child: null,
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Colors.teal),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              )
                          ),
                        ),
                        onPressed: () {
                          // --- Create new group ---
                          Random random = Random(DateTime.now().millisecondsSinceEpoch);
                          var groupID = DateTime.now().millisecondsSinceEpoch.toString() + random.nextInt(9).toString();

                          // Set new group name
                          FirebaseDatabase.instance.ref().child("groups/$groupID/name").set(groupName.text)
                            .catchError((error) {
                              print("Failed to set new group name");
                            });

                          // Set new group code
                          random = Random(DateTime.now().millisecondsSinceEpoch);
                          const _chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890';
                          var code = List.generate(6, (index) => _chars[random.nextInt(_chars.length)]).join();
                          FirebaseDatabase.instance.ref().child("groups/$groupID/code").set(code)
                            .catchError((error) {
                              print("Failed to set new group code");
                            });

                          // Add group to list of groupCodes
                          FirebaseDatabase.instance.ref().child("groupCodes/$code").set(groupID)
                              .catchError((error) {
                            print("Failed to add to groupCodes");
                          });

                          // Add user to new group
                          random = Random(DateTime.now().millisecondsSinceEpoch);
                          var randomID = DateTime.now().millisecondsSinceEpoch.toString() + random.nextInt(9).toString();
                          FirebaseDatabase.instance.ref().child("groups/$groupID/users/$randomID").set(uid)
                              .catchError((error) {
                            print("Failed to add user to group list.");
                          });

                          // Set user's current group GroupID
                          FirebaseDatabase.instance.ref().child("users/$uid/groupID").set(groupID)
                              .catchError((error) {
                            print("Failed set user randomID.");
                          });

                          // Set user's current group randomID
                          FirebaseDatabase.instance.ref().child("users/$uid/randomID").set(randomID)
                              .catchError((error) {
                            print("Failed set user randomID.");
                          });

                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => BottomNavigationBarPage()),
                                (Route<dynamic> route) => false,
                          );
                        }
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 52,
            child: Text(
                ''
              ),
          ),
          // TODO: FORMATTING
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
        ],
      ),
    );
  }
}
