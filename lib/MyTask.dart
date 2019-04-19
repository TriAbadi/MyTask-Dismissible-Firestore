import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:google_sign_in/google_sign_in.dart';

class MyTask extends StatefulWidget {

    MyTask({this.user,this.googleSignIn});
    final FirebaseUser user;
    final GoogleSignIn googleSignIn;




  @override
  _MyTaskState createState() => _MyTaskState();
}

class _MyTaskState extends State<MyTask> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: 170.0,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("img/balloon.jpeg"),fit: BoxFit.cover),
            boxShadow: [
              BoxShadow(
              color: Colors.black,
              blurRadius: 8.0,
            )
          ],
        ),


      ),
      
    );
  }
}