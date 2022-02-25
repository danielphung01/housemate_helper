import 'package:flutter/material.dart';

class ChoresMenu extends StatefulWidget {
  const ChoresMenu({Key? key}) : super(key: key);

  @override
  _ChoresMenuState createState() => _ChoresMenuState();
}

class _ChoresMenuState extends State<ChoresMenu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Text('Chores'),
          automaticallyImplyLeading: false
      ),
    );
  }
}
