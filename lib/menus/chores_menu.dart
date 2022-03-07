import 'package:flutter/material.dart';
import 'package:housemate_helper/menus/expenses_menu.dart';
import 'package:housemate_helper/menus/settings_menu.dart';

class ChoresMenu extends StatefulWidget {
  const ChoresMenu({Key? key}) : super(key: key);

  @override
  _ChoresMenuState createState() => _ChoresMenuState();
}

class _ChoresMenuState extends State<ChoresMenu> {
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
                  MaterialPageRoute(builder: (context) => ExpensesMenu()),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
