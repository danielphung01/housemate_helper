import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:housemate_helper/bottomnavbar_page.dart';
import 'package:housemate_helper/join_create_group_page.dart';
import 'package:housemate_helper/signup_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:housemate_helper/resources/fadeAnimation.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  // Firebase.initializeApp();

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  bool loginErrorMsgVisibility = false;
  var errorMsg = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 30,
              child: Image.asset(
                'assets/images/house_photo.png'
              ),
            ),
            Expanded(
                flex: 50,
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 35, right: 35, bottom: 10, top: 10),
                      child: TextField(
                        controller: emailController,
                        obscureText: false,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Email',
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 35, right: 35, bottom: 10, top: 10),
                      child: TextField(
                        controller: passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Password',
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10, bottom: 10),
                      child: Visibility(
                        visible: loginErrorMsgVisibility,
                        child: Text(
                          errorMsg,
                          style: TextStyle(
                            color: Colors.red
                          ),
                        )
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10, bottom: 10),
                      child: RichText(
                        text: TextSpan(
                          text: 'Forgot Password?',
                          style: TextStyle(
                            color: Colors.blue,
                            decoration: TextDecoration.underline,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              // TODO: implement forgot password
                              FirebaseAuth.instance.authStateChanges()
                                  .listen((User? user) {
                                if (user == null) {
                                  print("user is currently signed out");
                                } else {
                                  print("user is signed in");
                                }
                              });
                            }
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      height: 50,
                      width: 200,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Colors.blueGrey),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                              )
                          ),
                          side: MaterialStateProperty.all(
                            BorderSide(
                              style: BorderStyle.solid,
                              color: Colors.grey,
                            )
                          ),
                        ),
                        child: Text('Login'),
                        onPressed: () {
                          // login through Firebase
                          FirebaseAuth.instance.signInWithEmailAndPassword(
                              email: emailController.text, password: passwordController.text)
                              .then((value) {
                                print("Sucessfully logged in");
                                // Check if account is tied to room, if not, go to join_create_group_page
                                var uid = FirebaseAuth.instance.currentUser?.uid;
                                FirebaseDatabase.instance.ref().child('users/$uid').once()
                                    .then((databaseEvent) {
                                      String groupID = "null";
                                      groupID = databaseEvent.snapshot.child("groupID").value.toString();

                                      if (groupID != "null") {
                                        // The user is in a group
                                        Navigator.pushAndRemoveUntil(
                                          context,
                                          FadeRoute(page: BottomNavigationBarPage()),
                                          //MaterialPageRoute(builder: (context) => BottomNavigationBarPage()),
                                              (Route<dynamic> route) => false,
                                        );
                                      } else {
                                        // The user is not in a group
                                        Navigator.pushAndRemoveUntil(
                                          context,
                                          FadeRoute(page: JoinCreateGroupPage()),
                                          //MaterialPageRoute(builder: (context) => JoinCreateGroupPage()),
                                              (Route<dynamic> route) => false,
                                        );
                                      }
                                    }).catchError((error) {
                                      loginErrorMsgVisibility = true;
                                      errorMsg = "Internal Error.";
                                      setState(() { });
                                      FirebaseAuth.instance.signOut();
                                      Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(builder: (context) => LoginPage()),
                                            (Route<dynamic> route) => false,
                                      );
                                    });

                              }).catchError((error) {
                                loginErrorMsgVisibility = true;
                                errorMsg = "Invalid email or password.";
                                setState(() { });
                              });
                        },
                      ),
                    ),
                  ],
                )
            ),
            Expanded(
              flex: 10,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  RichText(
                      text: TextSpan(
                          text: 'Create an Accoount',
                          style: TextStyle(
                            color: Colors.blue,
                            decoration: TextDecoration.underline,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              print('Create an Account text pressed');
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => SignupPage()),
                              );
                            }
                      )
                  ),
                ],
              ),
            ),
          ],
        ),
      )
    );
  }
}
