import 'package:firebase_auth/firebase_auth.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => BottomNavigationBarPage()),
                                (Route<dynamic> route) => false,
                          );
                          // TODO: check if group exists

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
                      controller: inviteCode,
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
                          print("created new room pressed");
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => BottomNavigationBarPage()),
                                (Route<dynamic> route) => false,
                          );
                          // TODO: create new group

                          // TODO: join group with code
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
