import 'package:flutter/material.dart';
import 'package:todoapp/components/addButton.dart';
import 'package:todoapp/components/appbar.dart';
import 'package:todoapp/components/todoTile.dart';
import 'package:todoapp/pages/addtodo.dart';

List todoList = [
  ["to drink coffee", true],
  ["to do exercise ", false],
  ["to eat pizza ", false]
];

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // todoList

  void checkboxChange(bool? value, int index) {
    setState(() {
      todoList[index][1] = !todoList[index][1];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.deepPurple.shade400,
        appBar: const MyAppBar(),
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Colors.deepPurple,
          splashColor: Colors.deepPurple.shade400,
          onPressed: () async {
            bool? toReset = await Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => AddTodo(),
            ));

            if (toReset ?? false) {
              setState(() {});
            }
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
        ),
        body: Stack(
          children: [
            const SizedBox(
              height: 20,
            ),
            ListView.builder(
              itemCount: todoList.length,
              itemBuilder: (context, index) => TodoTile(
                isTaskCompleted: todoList[index][1],
                taskName: todoList[index][0],
                onChanged: (value) => checkboxChange(value, index),
                isDeleted: () {
                  setState(() {
                    todoList.remove(todoList[index]);
                  });
                },
              ),
            )
          ],
        ));
  }
}
