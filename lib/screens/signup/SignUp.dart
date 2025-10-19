import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:safebite/screens/signin/signIn.dart';
import 'package:safebite/util/AppCircularProgress.dart';
import 'package:safebite/util/AppText.dart';
import 'package:safebite/util/HashingHelper.dart';
import 'package:safebite/util/appColor.dart';
import 'package:safebite/util/util.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  List<String> allergens = [];
  Hashinghelper hashinghelper = Hashinghelper();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _allergyController = TextEditingController();
  void _addAllergy() {
    final newAllergy = _allergyController.text.trim();
    if (newAllergy.isNotEmpty && !allergens.contains(newAllergy)) {
      setState(() {
        allergens.add(newAllergy);
        _allergyController.clear();
      });
      /*ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('$newAllergy added to allergies.')),
      );*/
    }
  }

  void removeAllergy(String allergy) {
    setState(() {
      allergens.remove(allergy);
    });
    /*ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('$allergy removed from allergies.')),
    );*/
  }

  Future<void> addUser() async {
    if (_formKey.currentState!.validate()) {
      // Validation passed

      setState(() {
        _isLoading = true; // show loader
      });
      // Reference to the "users" collection
      try {
        CollectionReference users =
            FirebaseFirestore.instance.collection('userInfo');
        var firstname = _firstNameController.text.toString();
        var lastname = _lastNameController.text.toString();
        var email = _emailController.text.toString();
        var password =
            hashinghelper.hashString(_passwordController.text.trim());
        var height = int.parse(_heightController.text);
        var weight = int.parse(_weightController.text);
        /*allergens = _allergyController.text
            .toString()
            .split(",")
            .map((item) => item.trim())
            .toList();*/
        // Add a new user
        await users.add({
          'firstname': firstname,
          'lastname': lastname,
          'email': email,
          'password': password,
          'height': height,
          'weight': weight,
          'allergens': allergens,
          'createdAt': FieldValue.serverTimestamp(), // timestamp
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("User added successfully"),
            backgroundColor: AppColor.primaryDarker,
          ),
        );
        Future.delayed(const Duration(milliseconds: 800), () {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
                builder: (context) =>
                    Scaffold(appBar: Util().appBar, body: SignIn())),
          );
        });
      } catch (e) {
        print(e);
      } finally {
        setState(() {
          _isLoading = false; // hide loader
        });
      }
    }
  }

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
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "First name cannot be empty";
                            }
                            return null; // valid
                          },
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
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Last name cannot be empty";
                            }
                            return null; // valid
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Email
                  TextFormField(
                    controller: _emailController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Email cannot be empty";
                      }
                      if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                        return "Enter a valid email address";
                      }
                      return null; // valid
                    },
                    decoration: Util()
                        .appTextFieldDecoration
                        .copyWith(labelText: "Email"),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 16),

                  // Password
                  TextFormField(
                    controller: _passwordController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Password cannot be empty";
                      }
                      if (value.length < 6) {
                        return "Password must be at least 6 characters";
                      }
                      return null; // valid
                    },
                    decoration: Util()
                        .appTextFieldDecoration
                        .copyWith(labelText: "Password"),
                    obscureText: true,
                  ),
                  const SizedBox(height: 16),

                  // Confirm Password
                  TextFormField(
                    controller: _confirmPasswordController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Password cannot be empty";
                      }
                      if (value != _passwordController.text.toString()) {
                        return "Passwords do not match";
                      }
                      return null; // valid
                    },
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
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Height cannot be empty";
                            }
                            return null; // valid
                          },
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
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Weight cannot be empty";
                            }
                            return null; // valid
                          },
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
                  Wrap(
                    spacing: 8.0,
                    children: allergens.map((allergy) {
                      return Chip(
                        label: Text(allergy,
                            style:
                                const TextStyle(color: AppColor.textPrimary)),
                        backgroundColor: AppColor.secondary,
                        deleteIconColor: Colors.black87,
                        deleteIcon: const Icon(Icons.close, size: 18),
                        onDeleted: () => removeAllergy(allergy),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: const BorderSide(color: AppColor.primaryDark),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _allergyController,
                          decoration: Util().appTextFieldDecoration.copyWith(
                                hintText:
                                    'Allergens(Eg: Gluten, Shellfish, Soy)',
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 0),
                              ),
                          onFieldSubmitted: (value) => _addAllergy(),
                        ),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton.icon(
                        onPressed: _addAllergy,
                        icon: const Icon(Icons.add, color: Colors.white),
                        label: const Text('Add',
                            style: TextStyle(color: Colors.white)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColor.primaryDarker,
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 14),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Create Account Button
                  SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: AppColor.primaryDarker),
                        onPressed: () {
                          addUser();
                        },
                        child: _isLoading
                            ? SizedBox(
                                child: Appcircularprogress(),
                                width: 40,
                                height: 40,
                              )
                            : Text(
                                "Create Account",
                                style: TextStyle(
                                    fontSize: 16, color: Colors.white),
                              ),
                      )),

                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Already have an account? ",
                          style: AppText().contenttextStyle),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (context) => SignIn()),
                          );
                        },
                        child: Text("Sign in", style: AppText().hintTextStyle),
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
