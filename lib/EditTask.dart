import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

class EditTask extends StatefulWidget {
  EditTask({this.title, this.dueDate, this.note, this.index});

  final String title;
  final String note;
  final DateTime dueDate;

  final index;

  @override
  _EditTaskState createState() => _EditTaskState();
}

class _EditTaskState extends State<EditTask> {
  TextEditingController controllerTitle;
  TextEditingController controllerNote;

  DateTime _dueDate;

  String _dateText = '';

  String newTask;
  String note;

  void _updateTask() {
    Firestore.instance.runTransaction((Transaction transaction) async {
      DocumentSnapshot snapshot = 
      await transaction.get(widget.index);
      await transaction.update(snapshot.reference, {
        "title" : newTask,
        "note" : note,
        "dueDate" : _dueDate
      });
    });

    Navigator.pop(context);
  }

  Future<Null> _selectDueData(BuildContext context) async {
    final picked = await showDatePicker(
        context: context,
        initialDate: _dueDate,
        firstDate: DateTime(2019),
        lastDate: DateTime(2080));

    if (picked != null) {
      setState(() {
        _dueDate = picked;
        _dateText = "${picked.day}/${picked.month}/${picked.year}";

        
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _dueDate = widget.dueDate;
    _dateText = "${_dueDate.day}/${_dueDate.month}/${_dueDate.year}";


    newTask = widget.title; // ---> apabila data yg tidak dirubah maka akan tetap tidak hilang
    note = widget.note;     //---> apabila data yg tidak dirubah maka akan tetap tidak hilang

    controllerTitle = TextEditingController(text: widget.title);
        controllerNote = TextEditingController(text: widget.note);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        children: <Widget>[
          Container(
            height: 200.0,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("img/balloon.jpeg"), fit: BoxFit.cover),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("My Task ",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30.0,
                      letterSpacing: 2.0,
                    )),
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Text("EDIT TASK",
                      style: TextStyle(fontSize: 24.0, color: Colors.white)),
                ),
                Icon(Icons.list, color: Colors.white, size: 30.0)
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: controllerTitle,
              onChanged: (String str) {
                setState(() {
                  newTask = str;
                });
              },
              decoration: InputDecoration(
                  icon: Icon(Icons.dashboard),
                  hintText: "New Task",
                  border: InputBorder.none),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: Icon(Icons.date_range),
                ),
                Expanded(
                    child: Text("Due Date",
                        style:
                            TextStyle(fontSize: 22.0, color: Colors.black54))),
                FlatButton(
                    onPressed: () => _selectDueData(context),
                    child: Text(_dateText,
                        style:
                            TextStyle(fontSize: 22.0, color: Colors.black54))),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: controllerNote,
              onChanged: (String str) {
                setState(() {
                  note = str;
                });
              },
              decoration: InputDecoration(
                  icon: Icon(Icons.note),
                  hintText: "Note",
                  border: InputBorder.none),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 100.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.check,
                    size: 48.0,
                  ),
                  onPressed: () {
                    _updateTask();
                  },
                ),
                IconButton(
                  icon: Icon(
                    Icons.close,
                    size: 48.0,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
