import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  const MyButton({super.key, required this.onTap, required this.button_text});

  final Function()? onTap;
  final String button_text;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          padding: EdgeInsets.all(25),
          margin: EdgeInsets.symmetric(horizontal: 50),
          decoration: BoxDecoration(
              color: Color.fromARGB(255, 217, 217, 217),
              borderRadius: BorderRadius.circular(99)),
          child: Center(
              child: Text(
            button_text,
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ))),
    );
  }
}
