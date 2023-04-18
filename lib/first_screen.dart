import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/homepage.dart';
import 'package:todoapp/login.dart';
import 'package:shared_preferences/shared_preferences.dart';


class FirstScreen extends StatefulWidget {
   const FirstScreen({Key? key}) : super(key: key);

  @override
  State<FirstScreen> createState() => _FirstScreenState();
    final uid = ' ';
   void addtasktofirebase() async {
     final FirebaseAuth auth = FirebaseAuth.instance;
     final User? user = auth.currentUser;
      final uid = user?.uid;
     print(uid);
   }

}


class _FirstScreenState extends State<FirstScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          height: double.infinity,
          width: double.infinity,
          color:  Colors.black87,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(top:120, left:30,right:30),
                // child: const Text("Achieve Your Goal", style: TextStyle(
                //   fontSize: 25,
                //   fontWeight: FontWeight.bold,
                // ),
                //   textAlign: TextAlign.center,),
              ),
              Container(
                height: 500,
                width: 370,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(185)
                ),
                child: Image.asset(
                  'lib/assets/homeImg.jpeg',
                  width: 400.0,
                  height: 150.0,
                  fit: BoxFit.cover,
                ),
              ),

              const SizedBox(height:20),

              Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 70),
                        child: const Text("Already a Member ?" ,style: TextStyle(color: Colors.red,fontSize: 18),
                        )
                  ),
                  const SizedBox(width: 10),
                  Row(
                    children: [
                      ElevatedButton(
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                    side: const BorderSide(color: Colors.red)
                                )
                            ),
                          ),
                          onPressed: () async {
                            SharedPreferences prefs =await SharedPreferences.getInstance();
                            var email=prefs.getString("email");
                            Navigator.push(context,MaterialPageRoute(builder: (context)=>  email==null ? const LoginPage(): const HomePage()  ));
                          }, child: const Text("Continue")),
                    ],
                  ),

                ],
              ),

              const SizedBox(height: 10,),
                       ElevatedButton(
                          style: ButtonStyle(
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                      side: const BorderSide(color: Colors.red)
                                  )
                              )
                          ),
                          onPressed: () {
                            Navigator.pushNamed(context, '/signup');
                          }, child: const Text("Register")),
                  ],
                ),
              )
    );
  }
}