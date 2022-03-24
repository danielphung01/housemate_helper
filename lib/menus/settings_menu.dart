import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:housemate_helper/login_page.dart';
import 'package:housemate_helper/setting_pages/make_annoucement_page.dart';

class SettingsMenu extends StatefulWidget {
  const SettingsMenu({Key? key}) : super(key: key);

  @override
  _SettingsMenuState createState() => _SettingsMenuState();
}

class _SettingsMenuState extends State<SettingsMenu> {
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
                    child: const Text(
                      "<NAME>",
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
                const Text(
                  "<name>",
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
                const Text(
                  "<code>",
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
                print("make announcement button pressed");
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
                print("edit profile button pressed");
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
                  "Group Settings",
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
              ),
              onTap: () {
                print("group settings button pressed");
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
                // TODO: log out of account
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
