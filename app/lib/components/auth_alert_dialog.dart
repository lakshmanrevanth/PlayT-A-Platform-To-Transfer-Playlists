import 'package:flutter/material.dart';

Widget showAlertDialog(BuildContext context, String data) {
  return AlertDialog(
    title: Text(data),
    content: Text("You are awesome!"),
    actions: [
      MaterialButton(
        child: Text("OK"),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
    ],
  );
}
