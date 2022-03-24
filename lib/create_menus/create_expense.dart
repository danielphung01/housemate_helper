import 'package:flutter/material.dart';

class CreateExpense extends StatefulWidget {
  const CreateExpense({Key? key, required this.isExistingItem, required this.pageTitle}) : super(key: key);

  final bool isExistingItem;
  final String pageTitle;

  @override
  State<CreateExpense> createState() => _CreateExpenseState();
}

class _CreateExpenseState extends State<CreateExpense> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Expense'),
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
