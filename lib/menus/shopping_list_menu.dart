import 'package:flutter/material.dart';
import 'package:housemate_helper/create_menus/create_shopping_item.dart';
import 'package:housemate_helper/menus/chores_menu.dart';
import 'package:housemate_helper/menus/settings_menu.dart';

class ShoppingListMenu extends StatefulWidget {
  const ShoppingListMenu({Key? key}) : super(key: key);

  @override
  _ShoppingListMenuState createState() => _ShoppingListMenuState();
}

class _ShoppingListMenuState extends State<ShoppingListMenu> {

  void deleteButtonPressed() {
    print("delete button pressed");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Shopping List"),
        automaticallyImplyLeading: false,
        actions: [
          Container(
            padding: EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () {
                deleteButtonPressed();
              },
              child: Icon (
                Icons.delete,
              ),
            ),
          ),
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
              MaterialPageRoute(builder: (context) => (CreateShoppingItem(pageTitle: 'Edit Shopping List Item', isExistingItem: true))),
            );
          } else { // creating a new item
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => (CreateShoppingItem(pageTitle: 'Create Shopping List Item', isExistingItem: false))),
            );
          }
        },
        backgroundColor: Colors.lightBlue,
        child: const Icon(Icons.add),
      ),
    );
  }
}

