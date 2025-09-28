import 'package:flutter/material.dart';
import 'package:safebite/screens/signin/signIn.dart';
import 'package:safebite/util/AppText.dart';
import 'package:safebite/util/appColor.dart';
import 'package:safebite/util/util.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _allergyController = TextEditingController();

  String? _gender;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 12,
                  spreadRadius: 2,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            width: 400,
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Create Account",
                    style: AppText().secondaryStyle,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Join thousands who scan smarter, eat safer",
                    style: TextStyle(color: Colors.grey[600]),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 24),

                  // First + Last Name
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _firstNameController,
                          decoration: Util()
                              .appTextFieldDecoration
                              .copyWith(labelText: "First Name"),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: TextFormField(
                          controller: _lastNameController,
                          decoration: Util()
                              .appTextFieldDecoration
                              .copyWith(labelText: "Last Name"),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Email
                  TextFormField(
                    controller: _emailController,
                    decoration: Util()
                        .appTextFieldDecoration
                        .copyWith(labelText: "Email"),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 16),

                  // Password
                  TextFormField(
                    controller: _passwordController,
                    decoration: Util()
                        .appTextFieldDecoration
                        .copyWith(labelText: "Password"),
                    obscureText: true,
                  ),
                  const SizedBox(height: 16),

                  // Confirm Password
                  TextFormField(
                    controller: _confirmPasswordController,
                    decoration: Util()
                        .appTextFieldDecoration
                        .copyWith(labelText: "Confirm Password"),
                    obscureText: true,
                  ),
                  const SizedBox(height: 16),
                  // Height and Weight
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _heightController,
                          decoration: Util()
                              .appTextFieldDecoration
                              .copyWith(labelText: "Height (cm)"),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: TextFormField(
                          controller: _weightController,
                          decoration: Util()
                              .appTextFieldDecoration
                              .copyWith(labelText: "Weight (kg)"),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Allergic Ingredients
                  TextFormField(
                    controller: _allergyController,
                    decoration: Util().appTextFieldDecoration.copyWith(
                        labelText: "Allergens",
                        hintText: "Eg: Peanuts, Gluten, Milk"),
                    maxLines: 2,
                  ),
                  const SizedBox(height: 24),

                  // Create Account Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: AppColor.primaryDarker),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // Show success notification
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Account created successfully!'),
                              backgroundColor: Colors.green,
                            ),
                          );
                          // Navigate to Sign In page after short delay
                          Future.delayed(const Duration(milliseconds: 800), () {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(builder: (context) => SignIn()),
                            );
                          });
                        }
                      },
                      child: Text(
                        "Create Account",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Already have an account? "),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (context) => SignIn()),
                          );
                        },
                        child: Text(
                          "Sign in",
                          style: TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
