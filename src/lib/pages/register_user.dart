// ignore_for_file: invalid_return_type_for_catch_error

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:src/components/button.dart';
import 'package:src/components/textField.dart';
import 'package:src/handlers/data_handler.dart';
import 'package:src/pages/home.dart';
import 'package:src/pages/login.dart';

class RegisterUser extends StatefulWidget {
  const RegisterUser({super.key});

  @override
  State<RegisterUser> createState() => _RegisterUser();
}

class _RegisterUser extends State<RegisterUser> {
  //textFieldControllers
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  String errorMessage = "";

  String hashedPassword = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create an account'),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(
              MediaQuery.of(context).size.width * 0.2,
              100.0,
              MediaQuery.of(context).size.width * 0.2,
              100.0), // <-- Add some padding
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              const Text(
                'Create your account here!',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 50,
              ),
              MyTextField(
                controller: usernameController,
                hintText: 'Username',
                obscureText: false,
              ),
              const SizedBox(
                height: 15,
              ),
              MyTextField(
                  controller: passwordController,
                  hintText: 'Password',
                  obscureText: true),
              Text(
                errorMessage,
                style: const TextStyle(color: Colors.red),
              ),
              const SizedBox(
                height: 50,
              ),
              MyButton(
                  button_text: "Create",
                  onTap: () => {
                        hashedPassword = DataHandler()
                            .hashPassword(password: passwordController.text),
                        DataHandler()
                            .createUser(
                                name: usernameController.text,
                                hashedPassword: hashedPassword)
                            .then((value) => {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => MyHomePage(
                                                userData: value,
                                                title: 'Parkaholic',
                                              )))
                                })
                            .catchError((error) => setState(
                                //Error: Invalid argument(s) (onError): The error handler of Future.catchError must return a value of the future's type
                                () => {errorMessage = error.toString()}))
                      })
            ],
          ),
        ),
      ),
    );
  }
}
