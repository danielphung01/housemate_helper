import 'package:flutter/material.dart';

class EventsMenu extends StatefulWidget {
  const EventsMenu({Key? key}) : super(key: key);

  @override
  _EventsMenuState createState() => _EventsMenuState();
}

class _EventsMenuState extends State<EventsMenu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Events'),
        automaticallyImplyLeading: false
      ),

      body: Column(
        children: [
          Container(
            child: RaisedButton(
              child: Text('button'),
              onPressed: () {
                print("button Pressed");
              },
            ),
          ),
        ],
      ),
    );
  }
}