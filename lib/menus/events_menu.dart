import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:housemate_helper/create_menus/create_event.dart';

class EventsMenu extends StatefulWidget {
  const EventsMenu({Key? key}) : super(key: key);

  @override
  _EventsMenuState createState() => _EventsMenuState();
}

class _EventsMenuState extends State<EventsMenu> {
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
              MaterialPageRoute(builder: (context) => (CreateEvent(pageTitle: 'Edit Event', isExistingItem: true))),
            );
          } else { // creating a new item
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => (CreateEvent(pageTitle: 'Create Event', isExistingItem: false))),
            );
          }
        },
        backgroundColor: Colors.lightBlue,
        child: const Icon(Icons.add),
      ),
    );
  }
}