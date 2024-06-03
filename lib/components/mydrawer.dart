import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  MyDrawer({super.key});

  final user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Center(
        child: Center(
          child: user != null
              ? RotatedBox(
                  quarterTurns: 3,
                  child: Text(
                    user!.email.toString(),
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 25),
                  ),
                )
              : const Text('No UserName'),
        ),
      ),
    );
  }
}
