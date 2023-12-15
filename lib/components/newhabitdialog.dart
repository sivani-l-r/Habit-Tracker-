import 'package:flutter/material.dart';

class EnterNewHabit extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSaved;
  final VoidCallback onCancel;

  const EnterNewHabit({
    required this.controller,
    required this.onSaved,
    required this.onCancel,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Enter New Habit'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: controller,
            decoration: InputDecoration(
              labelText: 'New Habit',
              hintText: 'Type your new habit here',
            ),
          ),
        ],
      ),
      actions: [
        ElevatedButton(
          onPressed: onSaved,
          child: Text('Save'),
        ),
        TextButton(
          onPressed: onCancel,
          child: Text('Cancel'),
        ),
      ],
    );
  }
}
