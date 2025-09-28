import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:safebite/screens/home/home.dart';
import 'package:safebite/util/AppCircularProgress.dart';
import 'package:safebite/util/AppText.dart';
import 'package:safebite/util/HashingHelper.dart';
import 'package:safebite/util/appColor.dart';
import 'package:safebite/util/util.dart';
import 'package:flutter/gestures.dart';
import 'package:safebite/screens/signup/SignUp.dart';

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
  final CollectionReference userInfo =
      FirebaseFirestore.instance.collection('userInfo');
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  Hashinghelper hashinghelper = Hashinghelper();
  Future<void> login() async {
    setState(() {
      _isLoading = true;
    });
    String userName = _userNameController.text.trim();
    String password = hashinghelper.hashString(_passwordController.text.trim());
    if (userName.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter username and password")),
      );
      return;
    } else {
      // print("Hashed password=" + password);
      QuerySnapshot querySnapshot = await userInfo.get();
      var flag = false;
      for (var doc in querySnapshot.docs) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        var storeduserId = data['userName'];
        var storedpassword = data['passWord'];
        if (storeduserId == userName && password == storedpassword) {
          flag = true;
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => Home()),
          );
          break;
        }
      }
      if (!flag) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Please enter a valid username and password")));
      }
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(
            left: 50.0, right: 50.0, top: 100.0, bottom: 0.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text("Sign In", style: AppText().secondaryStyle),
            SizedBox(height: 20),
            TextField(
              controller: _userNameController,
              decoration:
                  Util().appTextFieldDecoration.copyWith(labelText: "Username"),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration:
                  Util().appTextFieldDecoration.copyWith(labelText: "Password"),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
                onPressed: _isLoading ? null : () => {login()},
                style: ElevatedButton.styleFrom(
                    disabledBackgroundColor: AppColor.background,
                    disabledForegroundColor: AppColor.background,
                    backgroundColor: AppColor.primaryDarker,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)))),
                // onPressed: _login,
                child: _isLoading
                    ? SizedBox(
                        child: Appcircularprogress(),
                        width: 40,
                        height: 40,
                      )
                    : Text(
                        "Login",
                        style: AppText().textStyle,
                      )),
            SizedBox(height: 50),
            RichText(
                text: TextSpan(
              style: AppText().contenttextStyle,
              children: [
                const TextSpan(text: "Not Registered? "),
                TextSpan(
                  text: "Create an account",
                  style: AppText().hintTextStyle,
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Scaffold(appBar: Util().appBar, body: SignUp()),
                        ),
                      );
                    },
                ),
              ],
            )),
          ],
        ));
  }
}
