import 'package:flutter/material.dart';
import 'package:housemate_helper/home_page.dart';
import 'package:housemate_helper/join_create_group_page.dart';
import 'login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Housemate Helper",
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          // backgroundColor: Color(0xFF1C2C54),
          // foregroundColor: Color(0xFF48C385)
        ),
      ),
      initialRoute: '/',
      routes: {
        '/':  (context) => MyHomePage(title: 'Housemate Helper'),
        '/join_create_group_page': (context) => JoinCreateGroupPage(),
      },
    );
  }
}

