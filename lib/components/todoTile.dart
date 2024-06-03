import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:todoapp/pages/homescreen.dart';

class TodoTile extends StatefulWidget {
  TodoTile(
      {super.key,
      required this.isTaskCompleted,
      required this.taskName,
      required this.onChanged,
      required this.id,
      required this.isDeleted});

  final String taskName;
  final bool isTaskCompleted;
  Function(bool?)? onChanged;
  final VoidCallback isDeleted;
  final String id;

  @override
  State<TodoTile> createState() => _TodoTileState();
}

class _TodoTileState extends State<TodoTile> {
  final modifiedText = TextEditingController();

  Future<void> modifyData(String id, String data) async {
    try {
      await FirebaseFirestore.instance
          .collection('todos')
          .doc(id)
          .update({'todo': data.toString()}).whenComplete(() => Navigator.of(
                  context)
              .pop(ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Successfully Updated !')))));
    } catch (e) {
      throw Exception(e);
    }
    // print(id);
    print(data);
  }

  @override
  void initState() {
    super.initState();
  }

  AlertDialog openDialog(BuildContext context) {
    return AlertDialog(
      title: const Text(
        overflow: TextOverflow.ellipsis,
        'EDIT',
        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.deepPurple),
      ),
      content: const SizedBox(
          height: 100, width: 400, child: Text(' * Edit Your Todo *')),
      actions: [
        Container(
            margin: EdgeInsets.only(bottom: 50),
            child: TextField(
              controller: modifiedText,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(
                      borderSide: BorderSide(width: 2, color: Colors.grey),
                      borderRadius: BorderRadius.all(Radius.circular(15)))),
            )),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Cancel')),
            ElevatedButton(
                onPressed: () {
                  modifyData(widget.id, modifiedText.text);
                },
                child: const Text('Submit')),
          ],
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
            color: Colors.deepPurple, borderRadius: BorderRadius.circular(8)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Checkbox(
              value: widget.isTaskCompleted,
              onChanged: widget.onChanged,
              checkColor: Colors.white,
              activeColor: Colors.green,
            ),
            Text(
              widget.taskName,
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  decoration: widget.isTaskCompleted
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                  decorationColor: Colors.white),
            ),
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => openDialog(context),
                    );
                  },
                  icon: const Icon(FontAwesomeIcons.penToSquare),
                  color: Colors.white,
                ),
                IconButton(
                    onPressed: widget.isDeleted,
                    icon: const Icon(
                      FontAwesomeIcons.trash,
                      color: Colors.white,
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
