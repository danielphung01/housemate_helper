import 'package:flutter/material.dart';
import 'package:housemate_helper/menus/settings_menu.dart';
import 'package:housemate_helper/menus/shopping_list_menu.dart';

class NotesMenu extends StatefulWidget {
  const NotesMenu({Key? key}) : super(key: key);

  @override
  _NotesMenuState createState() => _NotesMenuState();
}

class _NotesMenuState extends State<NotesMenu> {

  List<String> notes = <String>['Note A\nqwerqwerqwerqwerqwerqwerqwerqwerqwerqwer\nqwer\nqwer\nqwer\nqwer', 'Note B', 'Note C', 'Note D', 'Note E'];
  List<bool> checked = [false, false, false, false, false];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
              child: ListView.builder(
                  //padding: const EdgeInsets.only(top: 10),
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
                            Flexible(
                              child: Container(
                                  padding: EdgeInsets.only(top: 10, bottom: 10, right: 10),
                                  child: Text(notes[index])
                              ),
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
    );
  }
}
