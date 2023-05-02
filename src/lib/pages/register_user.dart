// ignore_for_file: invalid_return_type_for_catch_error

import 'package:flutter/material.dart';
import 'package:src/components/button.dart';
import 'package:src/components/textField.dart';
import 'package:src/handlers/dataHandler.dart';
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
        title: const Text('Account aanmaken'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
              150, 100.0, 150, 100.0), // <-- Add some padding
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              const Text(
                'Maak hier je account aan!',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 50,
              ),
              MyTextField(
                controller: usernameController,
                hintText: 'Gebruikersnaam',
                obscureText: false,
              ),
              const SizedBox(
                height: 15,
              ),
              MyTextField(
                  controller: passwordController,
                  hintText: 'Wachtwoord',
                  obscureText: true),
              Text(
                errorMessage,
                style: const TextStyle(color: Colors.red),
              ),
              const SizedBox(
                height: 50,
              ),
              MyButton(
                  button_text: "aanmaken",
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
                                          builder: (context) => Login()))
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
