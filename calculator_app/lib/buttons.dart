import 'package:flutter/material.dart';

class Buttons extends StatefulWidget {
  Buttons(
      {required this.color,
      required this.textcolor,
      required this.buttonText,
      required this.ButtonTap});

  late final color;
  late final textcolor;
  late final String buttonText;
  final ButtonTap;

  @override
  State<Buttons> createState() => _ButtonsState();
}

class _ButtonsState extends State<Buttons> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.ButtonTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
          child: Container(
            alignment: Alignment.center,
            height: 60.0,
            color: widget.color,
            padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
            child: Text(
              widget.buttonText,
              style: TextStyle(color: widget.textcolor, fontSize: 25.0),
            ),
          ),
        ),
      ),
    );
  }
}
