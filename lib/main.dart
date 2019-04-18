import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'dart:async';

import 'package:trayapp2/MyTask.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  Future<FirebaseUser> _signIn() async {
    GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );
    FirebaseUser firebaseUser =
        await firebaseAuth.signInWithCredential(credential);


      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (BuildContext context)=> MyTask(user:firebaseUser,googleSignIn:googleSignIn)
        )
      );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("img/concrete.png"), fit: BoxFit.cover)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.done, size: 300.0),
            Padding(
              padding: const EdgeInsets.only(bottom: 30.0),
            ),
            InkWell(
              onTap: () {
                _signIn();
              },
              child: Container(
                  color: Colors.transparent,
                  height: 30.0,
                  width: 300.0,
                  child: Container(
                    decoration: new BoxDecoration(
                        color: Colors.blue[100],
                        borderRadius: new BorderRadius.all(
                          const Radius.circular(13.0),
                        )),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
