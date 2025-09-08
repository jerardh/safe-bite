import 'package:flutter/material.dart';
import 'package:safebite/screens/home/home.dart';

class SignIn extends StatefulWidget {
  var userName;
  var passWord;
  @override
  State<StatefulWidget> createState() {
    return SignInState();
  }
}

class SignInState extends State<SignIn> {
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  Future<void> login() async {
    String userName = _userNameController.text.trim();
    String password = _passwordController.text.trim();
    if (userName.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter username and password")),
      );
      return;
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => Home()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextField(
          controller: _userNameController,
          decoration: const InputDecoration(
            labelText: "User Name",
          ),
        ),
        const SizedBox(height: 16),
        TextField(
          controller: _passwordController,
          obscureText: true,
          decoration: const InputDecoration(
            labelText: "Password",
          ),
        ),
        const SizedBox(height: 24),
        ElevatedButton(
          onPressed: () => {login()},
          // onPressed: _login,
          child: const Text("Login"),
        ),
      ],
    );
  }
}
