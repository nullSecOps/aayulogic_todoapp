import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GetData extends StatelessWidget {
  // final String todo;

  // GetData(this.todo);

  @override
  Widget build(BuildContext context) {
    CollectionReference myTodo = FirebaseFirestore.instance.collection('todos');

    return Container(
      child: Text(myTodo.id),
    );
  }
}
