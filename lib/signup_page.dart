import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:housemate_helper/join_create_group_page.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  // Firebase.initializeApp();

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {

  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();
  bool passwordErrorMessageVisibility = false;

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
              child: Image(
                image: NetworkImage("https://4m4you.com/wp-content/uploads/2020/06/logo-placeholder.png"),
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
                      margin: EdgeInsets.only(left: 35, right: 35, bottom: 10, top: 10),
                      child: TextField(
                        controller: confirmPasswordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Confirm Password',
                        ),
                      ),
                    ),
                    Visibility(
                      child: Text(
                        'Invalid email or password.',
                        style: TextStyle(
                          color: Colors.red,
                        ),
                      ),
                      visible: passwordErrorMessageVisibility,
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
                        child: Text('Create Account'),
                        onPressed: () {
                          if (passwordController.text == confirmPasswordController.text) { // Check if password and confirmPassword are the same
                            FirebaseAuth.instance.createUserWithEmailAndPassword( // Create account through FirebaseAuth
                                email: emailController.text, password: passwordController.text)
                                .then((value) {
                                  print("Successfully signed up");
                                  print(value.user!.uid);
                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(builder: (context) => JoinCreateGroupPage()),
                                        (Route<dynamic> route) => false,
                                  );
                                }).catchError((error) {
                                  print("Failed to sign up");
                                  print(error.toString());
                                  // TODO:
                                });
                          } else {
                            print("passwords are not the same");
                            // TODO: show "passwords must be matching prompt"
                          }
                          /*
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => JoinCreateGroupPage()),
                                (Route<dynamic> route) => false,
                          );
                          */
                          /*
                        FirebaseAuth.instance.signInWithEmailAndPassword(
                            email: emailController.text, password: passwordController.text)
                            .then((value) {
                          print("Login successful");
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ListViewDemoPage()),
                          );

                        }).catchError((error) {
                          print("Login failed");
                          print(error.toString());
                        });
                        */
                        },
                      ),
                    ),
                  ],
                )
            ),
            Expanded(
              flex: 10,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Already have an account? ',
                    style: TextStyle(
                      color: Colors.blue,
                    ),
                  ),
                  RichText(
                      text: TextSpan(
                          text: 'Login',
                          style: TextStyle(
                            color: Colors.blue,
                            decoration: TextDecoration.underline,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              print('Login in text pressed');
                              Navigator.pop(context);
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
