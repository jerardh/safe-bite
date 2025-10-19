import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:safebite/screens/signin/signIn.dart';
import 'package:safebite/util/AppCircularProgress.dart';
import 'package:safebite/util/AppText.dart';
import 'package:safebite/util/HashingHelper.dart';
import 'package:safebite/util/appColor.dart';
import 'package:safebite/util/util.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UpdateProfile extends StatefulWidget {
  @override
  _UpdateProfileState createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  DocumentSnapshot? userDoc;
  final CollectionReference userInfo =
      FirebaseFirestore.instance.collection('userInfo');

  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  List<String> allergens = [];
  Hashinghelper hashinghelper = Hashinghelper();

  // Controllers
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _allergyController = TextEditingController();

  String? _docId; // To store the current user's Firestore document ID

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  // 🔹 Load current user data from Firestore
  Future<void> _loadUserData() async {
    final preferences = await SharedPreferences.getInstance();
    String currUserEmail = preferences.getString('email') ?? '';

    if (currUserEmail.isEmpty) return;

    QuerySnapshot querySnapshot = await userInfo.get();
    userDoc = querySnapshot.docs.first;
    var flag = false;
    for (var doc in querySnapshot.docs) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      var storeduserId = data['email'];
      var storedpassword = data['password'];
      if (storeduserId == currUserEmail) {
        setState(() {
          userDoc = doc;
        });
        break;
      }
    }
    if (querySnapshot.docs.isNotEmpty) {
      Map<String, dynamic> data = userDoc!.data() as Map<String, dynamic>;
      setState(() {
        _docId = userDoc!.id;
        _emailController.text = data['email'] ?? '';
        _firstNameController.text = data['firstname'] ?? '';
        _lastNameController.text = data['lastname'] ?? '';
        _heightController.text = data['height']?.toString() ?? '';
        _weightController.text = data['weight']?.toString() ?? '';
        allergens = List<String>.from(data['allergens'] ?? []);
      });
    }
  }

  // 🔹 Update Firestore data
  Future<void> _updateUser() async {
    if (_formKey.currentState!.validate() && _docId != null) {
      setState(() {
        _isLoading = true;
      });

      try {
        var passwordHash =
            hashinghelper.hashString(_passwordController.text.trim());
        var height = int.tryParse(_heightController.text) ?? 0;
        var weight = int.tryParse(_weightController.text) ?? 0;

        await userInfo.doc(_docId).update({
          'firstname': _firstNameController.text.trim(),
          'lastname': _lastNameController.text.trim(),
          'password': passwordHash,
          'height': height,
          'weight': weight,
          'allergens': allergens,
          'updatedAt': FieldValue.serverTimestamp(),
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Profile updated successfully"),
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
        print('Error updating user: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error updating profile: $e")),
        );
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  // 🔹 Add / Remove allergens dynamically
  void _addAllergy() {
    final newAllergy = _allergyController.text.trim();
    if (newAllergy.isNotEmpty && !allergens.contains(newAllergy)) {
      setState(() {
        allergens.add(newAllergy);
        _allergyController.clear();
      });
    }
  }

  void removeAllergy(String allergy) {
    setState(() {
      allergens.remove(allergy);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Util().appBar,
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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Update Profile", style: AppText().secondaryStyle),
                  const SizedBox(height: 24),

                  // First + Last Name
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _firstNameController,
                          validator: (v) => v == null || v.isEmpty
                              ? "First name required"
                              : null,
                          decoration: Util().appTextFieldDecoration.copyWith(
                                labelText: "First Name",
                              ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: TextFormField(
                          controller: _lastNameController,
                          validator: (v) => v == null || v.isEmpty
                              ? "Last name required"
                              : null,
                          decoration: Util().appTextFieldDecoration.copyWith(
                                labelText: "Last Name",
                              ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Email (read-only)
                  TextFormField(
                    controller: _emailController,
                    readOnly: true,
                    decoration: Util().appTextFieldDecoration.copyWith(
                          labelText: "Email (cannot change)",
                        ),
                  ),
                  const SizedBox(height: 16),

                  // Password fields
                  TextFormField(
                    controller: _passwordController,
                    validator: (v) =>
                        v == null || v.isEmpty ? "Enter password" : null,
                    obscureText: true,
                    decoration: Util()
                        .appTextFieldDecoration
                        .copyWith(labelText: "New Password"),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _confirmPasswordController,
                    validator: (v) {
                      if (v == null || v.isEmpty) return "Confirm password";
                      if (v != _passwordController.text)
                        return "Passwords do not match";
                      return null;
                    },
                    obscureText: true,
                    decoration: Util()
                        .appTextFieldDecoration
                        .copyWith(labelText: "Confirm Password"),
                  ),
                  const SizedBox(height: 16),

                  // Height & Weight
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _heightController,
                          validator: (v) =>
                              v == null || v.isEmpty ? "Enter height" : null,
                          keyboardType: TextInputType.number,
                          decoration: Util()
                              .appTextFieldDecoration
                              .copyWith(labelText: "Height (cm)"),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: TextFormField(
                          controller: _weightController,
                          validator: (v) =>
                              v == null || v.isEmpty ? "Enter weight" : null,
                          keyboardType: TextInputType.number,
                          decoration: Util()
                              .appTextFieldDecoration
                              .copyWith(labelText: "Weight (kg)"),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // Allergens
                  Wrap(
                    spacing: 8.0,
                    children: allergens.map((a) {
                      return Chip(
                        label: Text(a,
                            style:
                                const TextStyle(color: AppColor.textPrimary)),
                        backgroundColor: AppColor.secondary,
                        deleteIconColor: Colors.black87,
                        deleteIcon: const Icon(Icons.close, size: 18),
                        onDeleted: () => removeAllergy(a),
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
                                hintText: 'Add allergen (e.g. Gluten)',
                              ),
                          onFieldSubmitted: (_) => _addAllergy(),
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
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // 🔹 Update button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.primaryDarker,
                      ),
                      onPressed: _updateUser,
                      child: _isLoading
                          ? SizedBox(
                              width: 40,
                              height: 40,
                              child: Appcircularprogress(),
                            )
                          : const Text("Update Profile",
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white)),
                    ),
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
