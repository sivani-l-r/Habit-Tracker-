import 'package:flutter/material.dart';

class EditDialog extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSaved;
  final VoidCallback onCancel;

  const EditDialog({
    required this.controller,
    required this.onSaved,
    required this.onCancel,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Edit'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: controller,
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
