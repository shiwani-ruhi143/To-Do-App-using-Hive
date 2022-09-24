import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:to_do_app/Util/my_button.dart';

class DialogBox extends StatefulWidget {
  final VoidCallback onSave;
  final VoidCallback onCancel;
  final TextEditingController controller;
  final TextEditingController controller2;

  const DialogBox(
      {super.key,
      required this.controller,
      required this.onCancel,
      required this.onSave,
      required this.controller2});

  @override
  State<DialogBox> createState() => _DialogBoxState();
}

class _DialogBoxState extends State<DialogBox> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return AlertDialog(
      title: Text("Add a new task",textAlign: TextAlign.center,),
      backgroundColor: Color.fromARGB(255, 249, 247, 247),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: widget.controller,
            decoration: InputDecoration(
                border: OutlineInputBorder(), hintText: "Task name"),
          ),
          SizedBox(height: 10.h,),
          TextField(
            textCapitalization: TextCapitalization.sentences,
            maxLength: 100,
            controller: widget.controller2,
            decoration: InputDecoration(
                border: OutlineInputBorder(), hintText: "Task description"),
          ),
        ],
      ),
      actions: [
        MyButton(
            onPressed: () {
              widget.onCancel();
            },
            text: "Cancel"),
        SizedBox(
          width: 5.w,
        ),
        MyButton(
            onPressed: () {
              widget.onSave();
            },
            text: "Save")
      ],
    );
  }
}
