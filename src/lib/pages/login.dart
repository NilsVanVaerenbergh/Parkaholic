import 'package:flutter/material.dart';
import 'package:src/components/button.dart';
import 'package:src/handlers/data_handler.dart';
import 'package:src/pages/home.dart';
import 'package:src/components/textField.dart';
import 'package:src/pages/register_user.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _Login();
}

class _Login extends State<Login> {
  //textFieldControllers
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  String errorMessage = "";
  String hashedPassword = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Aanmelden'),
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
                'Welkom bij Parkaholic!',
                style: TextStyle(fontSize: 20),
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
                button_text: "Sign-in",
                onTap: () => {
                  hashedPassword = DataHandler()
                      .hashPassword(password: passwordController.text),
                  DataHandler()
                      .checkPassword(
                          name: usernameController.text,
                          hashedPassword: hashedPassword)
                      .then((userData) => {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MyHomePage(
                                          title: 'Parkaholic',
                                          userData: userData,
                                        )))
                          })
                      .catchError((error) => setState(
                          //Error: Invalid argument(s) (onError): The error handler of Future.catchError must return a value of the future's type
                          () => {errorMessage = error.toString()}))
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //       builder: (context) =>
                  //           const MyHomePage(title: 'Parcaholic')));
                },
              ),
              const SizedBox(
                height: 15,
              ),
              MyButton(
                button_text: "Sing-up",
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const RegisterUser())),
              )
            ],
          ),
        ),
      ),
    );
  }
}
