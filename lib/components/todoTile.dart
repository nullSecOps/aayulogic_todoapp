import 'package:flutter/material.dart';

class TodoTile extends StatelessWidget {
  TodoTile(
      {super.key,
      required this.isTaskCompleted,
      required this.taskName,
      required this.onChanged,
      required this.isDeleted});

  final String taskName;
  final bool isTaskCompleted;
  Function(bool?)? onChanged;
  final VoidCallback isDeleted;

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
              value: isTaskCompleted,
              onChanged: onChanged,
              checkColor: Colors.white,
              activeColor: Colors.green,
            ),
            Text(
              taskName,
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  decoration: isTaskCompleted
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                  decorationColor: Colors.white),
            ),
            IconButton(
                onPressed: isDeleted,
                icon: const Icon(
                  Icons.delete,
                  color: Colors.white,
                ))
          ],
        ),
      ),
    );
  }
}
