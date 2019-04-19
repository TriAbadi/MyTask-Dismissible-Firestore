import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:trayapp2/AddTask.dart';
import 'main.dart';
import 'package:google_sign_in/google_sign_in.dart';

class MyTask extends StatefulWidget {
  MyTask({this.user, this.googleSignIn});
  final FirebaseUser user;
  final GoogleSignIn googleSignIn;

  @override
  _MyTaskState createState() => _MyTaskState();
}

class _MyTaskState extends State<MyTask> {
  void _signOut() {
    AlertDialog alertDialog = AlertDialog(
      content: Container(
        height: 215.0,
        child: Column(
          children: <Widget>[
            ClipOval(
              child: Image.network(widget.user.photoUrl),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text("Sign Out ?", style: TextStyle(fontSize: 16.0)),
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                InkWell(
                  onTap: () {
                    widget.googleSignIn.signOut();
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => MyHomePage()));
                  },
                  child: Column(
                    children: <Widget>[
                      Icon(Icons.check),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                      ),
                      Text("Yes")
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Column(
                    children: <Widget>[
                      Icon(Icons.close),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                      ),
                      Text("Cancel")
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
    showDialog(context: context, child: alertDialog);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (BuildContext context) => AddTask(email:widget.user.email)));
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.green[200],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        elevation: 20.0,
        color: Colors.green[100],
        child: ButtonBar(
          children: <Widget>[],
        ),
      ),
      body: Container(
          height: 170.0,
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("img/balloon.jpeg"), fit: BoxFit.cover),
            boxShadow: [
              BoxShadow(
                color: Colors.black,
                blurRadius: 8.0,
              )
            ], // color:Colors.blue--> pakai kalo pake image texture
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Row(
                  children: <Widget>[
                    Container(
                      width: 60.0,
                      height: 60.0,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: NetworkImage(widget.user.photoUrl),
                              fit: BoxFit.cover)),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(left: 18.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("Welcome",
                                style: TextStyle(
                                    fontSize: 18.0, color: Colors.white)),
                            Text(widget.user.displayName,
                                style: TextStyle(
                                    fontSize: 18.0, color: Colors.white)),
                          ],
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.exit_to_app,
                          color: Colors.white, size: 30.0),
                      onPressed: () {
                        _signOut();
                      },
                    ),
                  ],
                ),
              ),
              Text("My Task",
                  style: TextStyle(
                    color: Colors.white, fontSize: 30.0,
                    letterSpacing: 2.0,
                    //fontFamily: "pacifico" ---> kalau mau ganti type font
                  ))
            ],
          )),
    );
  }
}
