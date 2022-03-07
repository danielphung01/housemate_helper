import 'package:flutter/material.dart';
import 'package:housemate_helper/menus/settings_menu.dart';
import 'package:housemate_helper/menus/shopping_list_menu.dart';

class NotesMenu extends StatefulWidget {
  const NotesMenu({Key? key}) : super(key: key);

  @override
  _NotesMenuState createState() => _NotesMenuState();
}

class _NotesMenuState extends State<NotesMenu> {
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
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ShoppingListMenu()),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
