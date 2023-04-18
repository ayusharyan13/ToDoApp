import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Description extends StatelessWidget {
  final String title, description;
  const Description({Key ? key, required this.title, required this.description}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Description'),backgroundColor: Colors.black,),
      body: Container(
        color:Colors.black,
        child: Center(
          child: Column(
            children: [
           Container(
             margin: const EdgeInsets.only(top:15,left:15,right: 15),
            decoration: BoxDecoration(
              border: Border.all(color:Colors.red ,width: 2),
              ),
             child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.all(10),
                  height: 26,
                  child: Column(
                    children: [
                    Text(
                    title,
                    style: GoogleFonts.roboto(
                        fontSize: 24, fontWeight: FontWeight.bold,color: Colors.white),
                  ),
          ]

                ),
                ),
                Container(width: double.infinity, height: 2, color: Colors.red),
                Container(
                  margin: const EdgeInsets.all(10),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Text(
                      description,
                      style: GoogleFonts.roboto(fontSize: 18,color:Colors.white),
                    ),
                  ),
                ),
              ],
            ),
           )
          ]
          ),
        ),
      ),
    );
  }
}