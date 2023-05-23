import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;

  const MyTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide:
                  const BorderSide(color: Color.fromARGB(255, 217, 217, 217)),
              borderRadius: BorderRadius.circular(99),
            ),
            focusedBorder: OutlineInputBorder(
                borderSide:
                    const BorderSide(color: Color.fromARGB(255, 205, 205, 205)),
                borderRadius: BorderRadius.circular(25)),
            fillColor: const Color.fromARGB(255, 217, 217, 217),
            filled: true,
            hintStyle: TextStyle(color: Color.fromARGB(255, 168, 168, 168)),
            hintText: hintText),
      ),
    );
  }
}
