import 'package:flutter/material.dart';

class ShoppingListMenu extends StatefulWidget {
  const ShoppingListMenu({Key? key}) : super(key: key);

  @override
  _ShoppingListMenuState createState() => _ShoppingListMenuState();
}

class _ShoppingListMenuState extends State<ShoppingListMenu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Text('Shopping List'),
          automaticallyImplyLeading: false
      ),
    );
  }
}
