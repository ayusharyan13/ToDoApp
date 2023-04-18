import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/homepage.dart';
import 'first_screen.dart';
import 'login.dart';
import 'signup.dart';
import 'splash_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To do App',
      initialRoute: '/',
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        '/': (context) => const SplashScreen(),
        // When navigating to the "/second" route, build the SecondScreen widget.
        '/second': (context) => const FirstScreen(),
        '/login' : (context) => const LoginPage(),
        '/signup' : (context) =>  const SignUpScreen(),
        '/homepage' : (context) => const HomePage(),
      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}