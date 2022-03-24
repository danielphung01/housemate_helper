import 'package:flutter/material.dart';

class CreateChore extends StatefulWidget {
  const CreateChore({Key? key, required this.isExistingItem, required this.pageTitle}) : super(key: key);

  final bool isExistingItem;
  final String pageTitle;

  @override
  State<CreateChore> createState() => _CreateChoreState();
}

class _CreateChoreState extends State<CreateChore> {

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
                  print('delete');
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
          Text('chores')
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        backgroundColor: Colors.lightBlue,
        child: const Icon(Icons.check),
      ),
    );
  }
}
