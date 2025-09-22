import 'package:flutter/material.dart';
import 'package:safebite/screens/home/home.dart';
import 'package:safebite/util/AppText.dart';
import 'package:safebite/util/appColor.dart';

class SignIn extends StatefulWidget {
  var userName;
  var passWord;

  SignIn({super.key});
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
    return Padding(
        padding: const EdgeInsets.all(50.0),
        child: Column(
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
                style: ElevatedButton.styleFrom(
                    textStyle: AppText().textStyle,
                    backgroundColor: AppColor.primaryDarker,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)))),
                // onPressed: _login,
                child: const Text("Login")),
          ],
        ));
  }
}
