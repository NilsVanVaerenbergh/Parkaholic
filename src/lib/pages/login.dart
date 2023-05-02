import 'package:flutter/material.dart';
import 'package:src/components/button.dart';
import 'package:src/pages/home.dart';
import 'package:src/components/textField.dart';

class Login extends StatelessWidget {
  Login({super.key});

  //textFieldControllers
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(550.0,100.0,550.0,100.0), // <-- Add some padding
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black,
                width: 1.0,
              ),
            ),
            child: Column(
              children:  [
                SizedBox(
                  height: 50,
                ),
                Text(
                  'Welkom bij Parcaholic!',
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(
                  height: 50,
                ),
                MyTextField(controller: usernameController,hintText: 'username', obscureText: false,),

                SizedBox(height: 15,),

                MyTextField(controller: passwordController, hintText: 'password', obscureText: true),

                SizedBox(height: 50,),

                MyButton(
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const MyHomePage(title: 'Parcaholic'))
                )
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
