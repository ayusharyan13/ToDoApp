import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todoapp/add_task.dart';
import 'package:todoapp/utils/colors.dart';
import 'description.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String uid = '';
  @override
  void initState() {
    getuid();
    super.initState();
  }

  getuid() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    // final FirebaseAuth auth = FirebaseAuth.instance;
      final User user =  auth.currentUser!;
    setState(() {
       uid = user.uid;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TO DO'),
        actions: [
          IconButton(icon: const Icon(Icons.logout),
            onPressed: () async{
              SharedPreferences pref = await SharedPreferences.getInstance();
              pref.remove("email");
            await FirebaseAuth.instance.signOut();
            },)
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              hexStringColor("CB2B93"),
              hexStringColor("9546C4"),
              hexStringColor("5E6154"),
            ], begin: Alignment.topCenter, end: Alignment.bottomCenter)
        ),

        child: StreamBuilder(stream: FirebaseFirestore.instance
            .collection('tasks')
            .doc(uid)
            .collection('mytasks')
            .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              final docs = snapshot.data!.docs;

              return ListView.builder(
                itemCount: docs.length,
                itemBuilder: (context, index) {
                  var time = (docs[index]['timestamp'] as Timestamp).toDate();

                  return InkWell(
                    onTap: () {
                      Navigator.push( context, MaterialPageRoute(
                              builder: (context) =>
                                  Description(
                                    title: docs[index]['title'],
                                    description: docs[index]['description'],
                                  )));
                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                          color: const Color(0xff121211),
                          borderRadius: BorderRadius.circular(20)),
                      height: 80,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    margin: const EdgeInsets.only(left: 20),
                                    child: Text(docs[index]['title'],
                                        style:
                                        GoogleFonts.roboto(fontSize: 20,color: Colors.white))),

                                const SizedBox( height: 5,),
                                Container(
                                    margin: const EdgeInsets.only(left: 20),
                                    child: Text(
                                        DateFormat.yMd().add_jm().format(time),style: const TextStyle(color: Colors.white),))
                              ]),
                          IconButton(
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.white,
                              ),
                              onPressed: () async {
                                await FirebaseFirestore.instance
                                    .collection('tasks')
                                    .doc(uid)
                                    .collection('mytasks')
                                    .doc(docs[index]['time'])
                                    .delete();
                              })
                        ],
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
        // color: Colors.red,
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).dialogBackgroundColor,
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) =>
          const AddTask()));
        },
        child: const Icon(Icons.add, color: Colors.black,),
      ),
        );

  }
}



/*
child: ElevatedButton(
              child: const Text("LogOut"),
              onPressed: () {
                FirebaseAuth.instance.signOut().then((value){
                  print("Signed Out");
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> const LoginPage()));
                });
              },
            )
 */