import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class CreateNote extends StatefulWidget {
  const CreateNote({Key? key, required this.pageTitle, required this.isExistingItem, required this.noteID}) : super(key: key);

  final String pageTitle;
  final bool isExistingItem;
  final String noteID;

  @override
  State<CreateNote> createState() => _CreateNoteState();
}

class _CreateNoteState extends State<CreateNote> {

  var titleController = TextEditingController();
  var bodyController = TextEditingController();
  dynamic user;
  dynamic uid;
  var groupID = "";
  var randomID = "";
  var noteID = "";

  _CreateNoteState() {
    user = FirebaseAuth.instance.currentUser;
    uid = user?.uid;
    // Get groupID from user
    FirebaseDatabase.instance.ref().child("users/$uid").once()
        .then((databaseEvent) {
          groupID = databaseEvent.snapshot.child("groupID").value.toString();
          randomID = databaseEvent.snapshot.child("randomID").value.toString();

          // Autofill text from existing note that is to be edited
          if (widget.isExistingItem) {
            FirebaseDatabase.instance.ref().child("groups/$groupID/notes/${widget.noteID}").once()
                .then((databaseEvent) {
              titleController.text = databaseEvent.snapshot.child("title").value.toString();
              bodyController.text = databaseEvent.snapshot.child("body").value.toString();
              setState(() {

              });
            })
                .catchError((error) { print("Failed to get note to edit"); });
          }
        })
        .catchError((error) { print("Failed to groupID from user"); });
  }

  void deleteNote() {
    FirebaseDatabase.instance.ref().child("groups/$groupID/notes/${widget.noteID}").remove()
        .catchError((error) { print("Failed to delete old note: " + error); });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.pageTitle),
        centerTitle: true,
        automaticallyImplyLeading: true,
        actions: [
          Visibility(
            visible: widget.isExistingItem,
            child: Container(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  deleteNote();
                  Navigator.of(context).pop();
                },
                child: Icon (
                  Icons.delete,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.all(20),
            child: TextField(
              controller: titleController,
              keyboardType: TextInputType.multiline,
              minLines: 1,
              maxLines: 2,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Title',
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(right: 20, left: 20),
            child: TextField(
              controller: bodyController,
              keyboardType: TextInputType.multiline,
              minLines: 1,
              maxLines: 7,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Start typing...',
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Delete old note
          if (widget.isExistingItem) { // Delete the old note, to be replace
            deleteNote();
          }
          // Create random noteID
          noteID = DateTime.now().millisecondsSinceEpoch.toString();
          FirebaseDatabase.instance.ref().child("groups/$groupID/notes/$noteID/title").set(titleController.text)
              .then((databaseEvent) {
                FirebaseDatabase.instance.ref().child("groups/$groupID/notes/$noteID/body").set(bodyController.text)
                    .catchError((error) { print(error); });
                if (widget.isExistingItem) {  // Was an edited item
                  FirebaseDatabase.instance.ref().child("groups/$groupID/notes/$noteID/edited").set(true)
                      .catchError((error) { print(error); });
                } else {  // Was not an edited item
                  FirebaseDatabase.instance.ref().child("groups/$groupID/notes/$noteID/edited").set(false)
                      .catchError((error) { print(error); });
                }
                FirebaseDatabase.instance.ref().child("groups/$groupID/notes/$noteID/creator").set(uid)
                    .catchError((error) { print(error); });
                Navigator.of(context).pop();
              }).catchError((error) { print(error); });
        },
        backgroundColor: Colors.lightBlue,
        child: const Icon(Icons.check),
      ),
    );
  }
}
