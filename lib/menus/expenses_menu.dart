import 'package:flutter/material.dart';

class ExpensesMenu extends StatefulWidget {
  const ExpensesMenu({Key? key}) : super(key: key);

  @override
  _ExpensesMenuState createState() => _ExpensesMenuState();
}

class _ExpensesMenuState extends State<ExpensesMenu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Text('Expenses'),
          automaticallyImplyLeading: false
      ),
    );
  }
}
