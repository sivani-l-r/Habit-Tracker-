import 'package:flutter/material.dart';

class AddNewFab extends StatelessWidget {
  const AddNewFab({
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      child: Icon(Icons.add),
      backgroundColor: const Color.fromARGB(255, 44, 233, 30),
      elevation: 16.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
    );
  }
}
