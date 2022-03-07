import 'package:flutter/material.dart';
import 'package:housemate_helper/menus/events_menu.dart';
import 'package:housemate_helper/menus/settings_menu.dart';

class ExpensesMenu extends StatefulWidget {
  const ExpensesMenu({Key? key}) : super(key: key);

  @override
  _ExpensesMenuState createState() => _ExpensesMenuState();
}

class _ExpensesMenuState extends State<ExpensesMenu> {
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
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EventsMenu()),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
