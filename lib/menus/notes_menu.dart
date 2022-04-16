import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:housemate_helper/create_menus/create_note.dart';
import 'package:housemate_helper/items/note.dart';
import 'package:housemate_helper/menus/settings_menu.dart';
import 'package:housemate_helper/menus/shopping_list_menu.dart';

class NotesMenu extends StatefulWidget {
  const NotesMenu({Key? key}) : super(key: key);

  @override
  _NotesMenuState createState() => _NotesMenuState();
}

class _NotesMenuState extends State<NotesMenu> {

  List<Note> notes = <Note>[];
  dynamic user;
  dynamic uid;
  var groupID = "";

  _NotesMenuState() {
    user = FirebaseAuth.instance.currentUser;
    uid = user?.uid;
    // Get groupID from user
    FirebaseDatabase.instance.ref().child("users/$uid").once()
        .then((databaseEvent) {
          groupID = databaseEvent.snapshot.child("groupID").value.toString();
          GetNotes();
        })
        .catchError((error) { print("Failed to groupID from user"); });
  }

  // Get all notes of the current group and add them to notes list
  void GetNotes() {
    FirebaseDatabase.instance.ref().child("groups/$groupID/notes").once()
        .then((databaseEvent) {
          Map<dynamic, dynamic> values = databaseEvent.snapshot.value as Map;
          notes.clear();
          values.forEach((k, v) {
            var creator = "";
            FirebaseDatabase.instance.ref().child("users/${v['creator']}/username").once()
              .then((databaseEvent2) {
                creator = databaseEvent2.snapshot.value.toString();
                notes.insert(0, Note(k, v["title"], v["body"], v["edited"], creator));
                setState(() {

                });
              })
              .catchError((error) { print("Failed to add note to list of notes: " + error); });
          });
        })
        .catchError((error) { print("failed to load notes: " + error); });
  }

  void SelectedItem(BuildContext context, selection, noteID) {
    if (selection == 0) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => (CreateNote(pageTitle: 'Edit Note', isExistingItem: true))),
      );
    } else if (selection == 1) {
      FirebaseDatabase.instance.ref().child("groups/$groupID/notes/$noteID").remove()
          .then((databaseEvent) {
            GetNotes();
          })
          .catchError((error) { print("Failed to delete note: " + error); });
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
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Checkbox(
                                    value: notes[index].checked,
                                    onChanged: (bool? value) {
                                      notes[index].checked = !notes[index].checked;
                                      setState(() {
                                        notes[index].checked = value!;
                                      });
                                      print(notes[index].checked.toString());
                                    },
                                ),
                                Expanded(
                                  child: Container(
                                      padding: EdgeInsets.only(top: 15),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            notes[index].title,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                            ),
                                          ),
                                          Text(
                                            notes[index].body,
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
                                    SelectedItem(context, selection, notes[index].number)
                                  },
                                ),
                              ],
                            ),
                            Container(
                              padding: EdgeInsets.only(top: 10, right: 10, bottom: 10),
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  notes[index].user,
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
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
