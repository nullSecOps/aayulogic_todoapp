import 'package:flutter/material.dart';
import 'package:todoapp/pages/addtodo.dart';

class AddButton extends StatelessWidget {
  const AddButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      backgroundColor: Colors.deepPurple,
      splashColor: Colors.deepPurple.shade400,
      onPressed: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => AddTodo(),
        ));
      },
      icon: const Icon(
        Icons.add,
        size: 30,
        color: Colors.white,
      ),
      label: const Text(
        'ADD',
        style: TextStyle(color: Colors.white, fontSize: 20),
      ),
      // child: \\const ,
    );
  }
}
