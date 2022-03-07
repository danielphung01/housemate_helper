import 'package:flutter/material.dart';
import 'package:housemate_helper/menus/chores_menu.dart';
import 'package:housemate_helper/menus/events_menu.dart';
import 'package:housemate_helper/menus/expenses_menu.dart';
import 'package:housemate_helper/menus/notes_menu.dart';
import 'package:housemate_helper/menus/settings_menu.dart';
import 'package:housemate_helper/menus/shopping_list_menu.dart';

class BottomNavigationBarPage extends StatefulWidget {
  const BottomNavigationBarPage({Key? key}) : super(key: key);

  @override
  _BottomNavigationBarPageState createState() => _BottomNavigationBarPageState();
}

class _BottomNavigationBarPageState extends State<BottomNavigationBarPage> {

  int _selectedIndex = 0;
  String appBarTitleText = 'Events';

  static final List<Widget> _widgetOptions = <Widget>[
    EventsMenu(),
    NotesMenu(),
    ShoppingListMenu(),
    ChoresMenu(),
    ExpensesMenu()
  ];

  static final List<String> _pageTitles = <String>[
    'Events',
    'Notes',
    'Shopping List',
    'Chores',
    'Expenses'
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      appBarTitleText = _pageTitles[index];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(appBarTitleText),
        automaticallyImplyLeading: false,
        actions: [
          Container(
            padding: EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SettingsMenu()),
                );
              },
              child: Icon (
                Icons.person,
              ),
            ),
          ),
        ],
      ),

      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),

      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_view_month),
            label: 'Events',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.note),
            label: 'Notes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Shopping',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.cleaning_services),
            label: 'Chores',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.money),
            label: 'Expenses',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
