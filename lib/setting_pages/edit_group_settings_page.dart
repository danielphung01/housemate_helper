import 'package:flutter/material.dart';

class EditGroupSettingsPage extends StatefulWidget {
  const EditGroupSettingsPage({Key? key}) : super(key: key);

  @override
  State<EditGroupSettingsPage> createState() => _EditGroupSettingsPageState();
}

class _EditGroupSettingsPageState extends State<EditGroupSettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Group Settings'),
        automaticallyImplyLeading: true,
        centerTitle: true,
      ),

      body: Column(
        children: [

        ],
      ),
    );
  }
}
