import 'package:flutter/material.dart';
import 'package:housemate_helper/home_page.dart';
import 'package:housemate_helper/join_create_group_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

// TODO: fix themes
ThemeData _darkTheme = ThemeData(
  //brightness: Brightness.dark,
  primaryColor: Colors.amber, colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.red),
);

ThemeData _lightTheme = ThemeData(
  //brightness: Brightness.light,
  primaryColor: Colors.blue, colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.pink)
);

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
      },
    );
  }
}

