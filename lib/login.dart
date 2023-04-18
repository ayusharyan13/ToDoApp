import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todoapp/reusable_widgets/reusable_widgets.dart';
import 'package:todoapp/utils/colors.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [
                hexStringColor("CB2B93"),
                hexStringColor("9546C4"),
                hexStringColor("5E6154"),
              ], begin: Alignment.topCenter, end: Alignment.bottomCenter
          ),
        ),

        child: SingleChildScrollView(
          child: Padding(
              padding: EdgeInsets.fromLTRB(
                  20, MediaQuery.of(context).size.height * 0.2, 20, 0),
              child: Column(
                children: [
                  logoWidget('lib/assets/logo_user.jpeg'),
                  const SizedBox(height: 30,),
                  reusableTextField("Enter UserName",Icons.person_outline, false, _emailTextController),
                  const SizedBox(height: 20),
                  reusableTextField("Enter PassWord",Icons.lock_outline , true, _passwordTextController),
                  const SizedBox(height: 20,),
                  signInSignUpButton(context, true, () {
                    // we will make our firebase api call and do successful login
                    FirebaseAuth.instance.signInWithEmailAndPassword(
                        email: _emailTextController.text,
                        password: _passwordTextController.text).then(
                        (value) async {
                          SharedPreferences pref =await SharedPreferences.getInstance();
                          pref.setString("email", "useremail@gmail.com");
                          Navigator.pushNamed(context,'/homepage');
                        }
                    ).onError((error, stackTrace) {
                      // print("Error ${error.toString()}");
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(error.toString()),
                          duration: const Duration(seconds: 5),
                        ),

                      );
                    });
                  }),
                  signUpOption(),

                ],
              )
          ),
        ),
      ),
    );
  }

  Row signUpOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Don't have an account ?  ",
            style: TextStyle(
              fontSize: 18,
                color: Colors.white70)),
        GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/signup');
            },
            child: const Text(
              "Sign Up",
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold,
              fontSize: 17),
            )
        )
      ],
    );
  }

}
