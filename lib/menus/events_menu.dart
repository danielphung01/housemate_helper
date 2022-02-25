import 'package:flutter/material.dart';

class EventsMenu extends StatefulWidget {
  const EventsMenu({Key? key}) : super(key: key);

  @override
  _EventsMenuState createState() => _EventsMenuState();
}

class _EventsMenuState extends State<EventsMenu> {

  int _currentIndex = 0;
  final List<Widget> _children = [
    EventsMenu()
  ];


  void onTabTapped (String tabItem, int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Events'),
        automaticallyImplyLeading: false
      ),

      body: Column(

      ),

    );
  }
}