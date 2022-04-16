import 'package:flutter/material.dart';
import 'package:housemate_helper/create_menus/create_expense.dart';
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
          Expanded(
              child: ListView.builder(
                  itemCount: 0,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      contentPadding: EdgeInsets.only(top: 8, right: 13, left: 13),
                    );
                  }
              )
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: check if the user is trying to create a new item or delete/edit an existing one
          // TODO: pass true or false into isExistingItem accordingly to show/hide delete icon
          if (true) { // deleting/editing an existing item
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => (CreateExpense(pageTitle: 'Edit Expense', isExistingItem: true))),
            );
          } else { // creating a new item
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => (CreateExpense(pageTitle: 'Create Expense', isExistingItem: false))),
            );
          }
        },
        backgroundColor: Colors.lightBlue,
        child: const Icon(Icons.add),
      ),
    );
  }
}
