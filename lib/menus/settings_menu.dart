import 'package:flutter/material.dart';

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
                      "NAME",
                      style: TextStyle(
                        fontSize: 25,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Divider( color: Colors.black ),
          Expanded(
            flex: 7,
            child: Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(left: 20.0),
              child: Text(
                  "Group Name: ",
                  style: TextStyle(
                    fontSize: 18,
                  ),
              ),
            ),
          ),
          Expanded(
            flex: 7,
            child: Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(left: 20.0),
              child: Text(
                  "Invite Code: ",
                  style: TextStyle(
                    fontSize: 18,
                  ),
              ),
            ),
          ),
          Divider( color: Colors.black ),
          Expanded(
            flex: 8,
            child: Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(left: 20.0),
              child: Text(
                  "Edit Profile",
                  style: TextStyle(
                    fontSize: 15,
                  ),
              ),
            ),
          ),
          Divider( color: Colors.black ),
          Expanded(
            flex: 8,
            child: Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(left: 20.0),
              child: Text(
                  "Group Settings",
                  style: TextStyle(
                    fontSize: 15,
                  ),
              ),
            ),
          ),
          Divider( color: Colors.black ),
          Expanded(
            flex: 8,
            child: Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(left: 20.0),
              child: Text(
                  "Log out",
                  style: TextStyle(
                    fontSize: 15,
                  ),
              ),
            ),
          ),
          Divider( color: Colors.black ),
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
