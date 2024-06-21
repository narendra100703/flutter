import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mywork1/my_button.dart';
class DialogBox extends StatelessWidget {
  final controller;
  VoidCallback onSave;
  VoidCallback onCancel;

  DialogBox({super.key,
  required this.controller,
  required this.onSave,
  required this.onCancel});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white70,
      content: Container(
        height: 150,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextField(
              controller:controller ,
              decoration:InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20),),
                  borderSide:BorderSide(
                    width: 8,
                    color: Colors.black
                  ) ),
              hintText: "Add a new task") ,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MyButton(text: "Save", onPressed: onSave),
                MyButton(text: "Cancel", onPressed: onCancel)
              ],
            )
          ],
        ),
      ),
    );
  }
}
