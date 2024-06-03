import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/firebase_options.dart';
// import 'package:todoapp/pages/test.dart';
// import 'package:todoapp/pages/homescreen.dart';
import 'package:todoapp/pages/wrapper.dart';
// import 'package:todoapp/test.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
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
      home: const Wrapper(),
    );
  }
}
