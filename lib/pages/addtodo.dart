import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/components/appbar.dart';
import 'package:todoapp/pages/homescreen.dart';

class AddTodo extends StatefulWidget {
  // VoidCallback add;
  AddTodo({super.key});

  @override
  State<AddTodo> createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodo> {
  final mycontroller = TextEditingController();
  CollectionReference mytodo = FirebaseFirestore.instance.collection('todos');

  Future<void> addData() async {
    await mytodo
        .add({'isCompleted': false, 'todo': mycontroller.text})
        .then((value) => print("User Added $value"))
        .catchError((error) => print(error));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    mycontroller.dispose();
  }

  // VoidCallback? addData;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple.shade400,
      appBar: const MyAppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Add New \" TODO \"",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  color: Colors.white,
                  fontStyle: FontStyle.italic),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
              child: TextField(
                controller: mycontroller,
                decoration: const InputDecoration(
                  labelText: "write here...",
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(),
                  floatingLabelStyle: TextStyle(
                    color: Colors.black,
                    backgroundColor: Colors.white,
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () {
                      addData();
                      setState(() {
                        List toInsert = [mycontroller.text, false];
                        todoList.insert(todoList.length, toInsert);
                        print(todoList);
                        Navigator.of(context).pop(true);
                      });
                    },
                    child: const Text("Submit")),
                const SizedBox(
                  width: 10,
                ),
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text("Back"))
              ],
            )
          ],
        ),
      ),
    );
  }
}
