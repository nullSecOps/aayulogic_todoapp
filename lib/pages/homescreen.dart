import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/components/appbar.dart';
import 'package:todoapp/components/mydrawer.dart';
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
  Future<void> checkboxChange(bool value, String id) async {
    // print(value);
    await FirebaseFirestore.instance
        .collection('todos')
        .doc(id)
        .update({'isCompleted': value});
  }

  Future<void> deleteData(String id) async {
    await FirebaseFirestore.instance.collection('todos').doc(id).delete();
    // print(res);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: MyDrawer(),
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
            // snapshot.data!.docs.map((DocumentSnapshot document) {
            StreamBuilder<QuerySnapshot>(
                stream:
                    FirebaseFirestore.instance.collection('todos').snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.active) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) => TodoTile(
                          isTaskCompleted: snapshot.data!.docs[index]
                              ['isCompleted'],
                          id: snapshot.data!.docs[index].id.toString(),
                          taskName: snapshot.data!.docs[index]['todo'],
                          onChanged: (value) => checkboxChange(
                              value!, snapshot.data!.docs[index].id.toString()),
                          isDeleted: () {
                            deleteData(snapshot.data!.docs[index].id.toString())
                                .whenComplete(() => ScaffoldMessenger.of(
                                        context)
                                    .showSnackBar(const SnackBar(
                                        content:
                                            Text('Deleted Successfully !'))));
                          },
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text(snapshot.hasError.toString()),
                      );
                    }
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    );
                  }
                  throw Exception();
                })
          ],
        ));
  }
}
