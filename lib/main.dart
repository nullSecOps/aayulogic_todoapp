import 'package:flutter/material.dart';
import 'package:todoapp/pages/homescreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "TODO APP",
      theme: ThemeData(useMaterial3: true),
      home: const HomeScreen(),
    );
  }
}
