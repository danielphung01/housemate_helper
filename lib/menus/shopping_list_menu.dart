import 'package:flutter/material.dart';
import 'package:housemate_helper/menus/chores_menu.dart';
import 'package:housemate_helper/menus/settings_menu.dart';

class ShoppingListMenu extends StatefulWidget {
  const ShoppingListMenu({Key? key}) : super(key: key);

  @override
  _ShoppingListMenuState createState() => _ShoppingListMenuState();
}

class _ShoppingListMenuState extends State<ShoppingListMenu> {
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
                  MaterialPageRoute(builder: (context) => ChoresMenu()),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
