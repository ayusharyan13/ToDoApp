import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todoapp/utils/colors.dart';

class AddTask extends StatefulWidget {
  const AddTask({Key? key}) : super(key: key);

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  // we don't want users to see each other tasks
  // so need to store task with unique id
  void addtasktofirebase() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    var db = FirebaseFirestore.instance;
    final User? user = auth.currentUser;
    final uid = user?.uid;   // getting the id of current user
    var time = DateTime.now();
    await db
        .collection('tasks').doc(uid)
        .collection('mytasks')
        .doc(time.toString())
        .set({
      'title': titleController.text,
      'description': descriptionController.text,
      'time': time.toString(),
      'timestamp': time
    });
    Fluttertoast.showToast(msg: 'Data Added');
    }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("New Task")),
      body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  hexStringColor("CB2B93"),
                  hexStringColor("9546C4"),
                  hexStringColor("5E6154"),
                ], begin: Alignment.topCenter, end: Alignment.bottomCenter)
            ),
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(
                  labelText: 'Enter Title',
                  border: OutlineInputBorder()
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(
                    labelText: 'Enter Description',
                    border: OutlineInputBorder()
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton( style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith<Color>
                    ((Set<MaterialState> states) {
                    if (states.contains(MaterialState.pressed)) {
                      return Colors.purple.shade100;
                    } else {
                      return Theme.of(context).primaryColor;
                    }
                  })),
               onPressed: () {
                  addtasktofirebase();
               }, child: const Text("Add task"),


                )
              )],
          )
        )
      )
    );
  }
}

