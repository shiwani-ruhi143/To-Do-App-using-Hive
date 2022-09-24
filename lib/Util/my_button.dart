import 'package:flutter/material.dart';

class MyButton extends StatefulWidget {
  final String text;
  VoidCallback onPressed;
  MyButton({super.key, required this.onPressed, required this.text});

  @override
  State<MyButton> createState() => _MyButtonState();
}

class _MyButtonState extends State<MyButton> {
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: widget.onPressed,
      child: Text(widget.text,style: TextStyle(color: Colors.white),),
      color: Colors.black,
    );
  }
}
