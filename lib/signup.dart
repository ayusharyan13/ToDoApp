import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'reusable_widgets/reusable_widgets.dart';
import 'utils/colors.dart';
class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {


  // final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _userNameTextController = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text(
            "Sign Up",
            style: TextStyle(
                fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        body: Container(
            width: MediaQuery
                .of(context)
                .size
                .width,
            height: MediaQuery
                .of(context)
                .size
                .height,
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  hexStringColor("CB2B93"),
                  hexStringColor("9546C4"),
                  hexStringColor("5E6154"),
                ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
            child: SingleChildScrollView(
                child: Padding(
                    padding: EdgeInsets.fromLTRB(
                        20, MediaQuery
                        .of(context)
                        .size
                        .height * 0.2, 20, 0),
                    child: Column(
                        children: [
                          const SizedBox(height: 20,),
                          reusableTextField(
                              "Enter UserName", Icons.person_outline, false,
                              _userNameTextController),
                          const SizedBox(height: 20,),
                          reusableTextField(
                              "Enter Email Id", Icons.email_rounded, false,
                              _emailTextController),
                          const SizedBox(height: 20,),
                          reusableTextField(
                              "Enter Password", Icons.password_rounded, true,
                              _passwordTextController),
                          const SizedBox(height: 20,),
                          signInSignUpButton(context, false, () async {
                            try {
                              String user = _userNameTextController.text;
                              // stores user in database
                              UserCredential authResult;

                              authResult = await FirebaseAuth.instance
                                  .createUserWithEmailAndPassword(
                                  email: _emailTextController.text,
                                  password: _passwordTextController.text);
                              // print(authResult);

                              FirebaseFirestore.instance.collection('Users')
                                  .doc(authResult.user!.uid)
                                  .set(
                                {
                                  "UserName": user,
                                  "UserId": authResult.user!.uid,
                                  "UserEmail": _emailTextController.text,
                                },
                              );
                              Navigator.pushNamed(context, '/homepage');
                            } catch (e) {
                              // Display error message on screen
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(e.toString()),
                                  duration: const Duration(seconds: 5),
                                ),

                              );
                            }
                          }
                          )
                        ]
                    )
                )
            )
        )
    );
  }
}
/*
 signInSignUpButton(context, false, () async {
                          String user = _userNameTextController.text;
                         // stores user in database
                          UserCredential authResult;

                          authResult = await  FirebaseAuth.instance.createUserWithEmailAndPassword(
                              email: _emailTextController.text,
                              password: _passwordTextController.text).then((value) async {
                            print("Wow Successful, Created a New Account");
                            String? uid = authResult.user?.uid;

                            Navigator.push(context,MaterialPageRoute(builder:(context)=> const HomePage()));
                          }).onError((error, stackTrace)  {
                            print("Error ${error.toString()}");

                          }) as UserCredential;

                        }),
 */