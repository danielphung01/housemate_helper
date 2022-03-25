import 'package:flutter/material.dart';
import 'package:housemate_helper/create_menus/create_note.dart';
import 'package:housemate_helper/menus/settings_menu.dart';
import 'package:housemate_helper/menus/shopping_list_menu.dart';

class NotesMenu extends StatefulWidget {
  const NotesMenu({Key? key}) : super(key: key);

  @override
  _NotesMenuState createState() => _NotesMenuState();
}

class _NotesMenuState extends State<NotesMenu> {

  List<String> titles = <String>["Note A", "Note B", "Note C", "Note D", "Note E"];
  List<String> notes = <String>['qwerqwerqwerqwerqwerqwerqwerqwerqwerqwer\nqwer\nqwer\nqwer\nqwer\nqwer\nqwer', 'qwer', '', 'qwer', 'contents\ncontents'];
  List<bool> checked = [false, false, false, false, false];

  void SelectedItem(BuildContext context, selection) {
    if (selection == 0) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => (CreateNote(pageTitle: 'Edit Note', isExistingItem: true))),
      );
    } else if (selection == 1) {
      // TODO: delete item from database logic here
      print('delete');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
              child: ListView.builder(
                  itemCount: notes.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      contentPadding: EdgeInsets.only(top: 8, right: 13, left: 13),
                      title: Container(
                        color: Color.fromARGB(100, 230, 220, 130),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Checkbox(
                                value: checked[index],
                                onChanged: (bool? value) {
                                  checked[index] = !checked[index];
                                  setState(() {
                                    checked[index] = value!;
                                  });
                                  print(checked.toString());
                                },
                            ),
                            Expanded(
                              child: Container(
                                  padding: EdgeInsets.only(top: 15, bottom: 15),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        titles[index],
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                      Text(
                                        notes[index],
                                        style: TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  )
                              ),
                            ),
                            PopupMenuButton<int>(
                              icon: Icon(Icons.menu),
                              color: Colors.white,
                              itemBuilder: (context) => [
                                PopupMenuItem<int>(
                                  value: 0,
                                  child: Text(
                                    "Edit",
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                PopupMenuItem<int>(
                                  value: 1,
                                  child: Text(
                                    "Delete",
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ],
                              onSelected: (selection) => {
                                SelectedItem(context, selection)
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  }
              )
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // creating a new item
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => (CreateNote(pageTitle: 'Create Note', isExistingItem: false))),
          );
        },
        backgroundColor: Colors.lightBlue,
        child: const Icon(Icons.add),
      ),
    );
  }
}
