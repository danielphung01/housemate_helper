import 'package:flutter/material.dart';
import 'package:housemate_helper/bottomnavbar_page.dart';
import 'package:housemate_helper/join_create_group_page.dart';
import 'login_page.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            child: RaisedButton(
              child: Text('login screen'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
            ),
          ),
          Container(
            child: RaisedButton(
              child: Text('bottommnav screen'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BottomNavigationBarPage()),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
