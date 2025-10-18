import 'package:flutter/material.dart';
import 'package:safebite/util/appColor.dart';
import 'package:safebite/util/util.dart';

class ProfileUpdateScreen extends StatefulWidget {
  const ProfileUpdateScreen({super.key});

  @override
  State<ProfileUpdateScreen> createState() => _ProfileUpdateScreenState();
}

class _ProfileUpdateScreenState extends State<ProfileUpdateScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _allergyController = TextEditingController();

  // Password change controllers
  final TextEditingController _currentPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();

  bool _showPasswordFields = false;

  // Dynamic list to hold user allergies
  List<String> _allergies = ['Peanuts', 'Dairy'];

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _nameController.text = 'Jane Doe';
    _emailController.text = 'jane.doe@example.com';
    _bioController.text = 'Flutter enthusiast and mobile developer.';
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _bioController.dispose();
    _allergyController.dispose();
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    super.dispose();
  }

  // --- Allergy Management ---
  void _addAllergy() {
    final newAllergy = _allergyController.text.trim();
    if (newAllergy.isNotEmpty && !_allergies.contains(newAllergy)) {
      setState(() {
        _allergies.add(newAllergy);
        _allergyController.clear();
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('$newAllergy added to allergies.')),
      );
    }
  }

  void _removeAllergy(String allergy) {
    setState(() {
      _allergies.remove(allergy);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('$allergy removed from allergies.')),
    );
  }

  // --- Profile Update ---
  Future<void> _updateProfile() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      await Future.delayed(const Duration(seconds: 2));
      setState(() {
        _isLoading = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Profile and Allergies Updated Successfully! ✅'),
          ),
        );
      }
    }
  }

  // --- Password Update Function ---
  void _changePassword() {
    final current = _currentPasswordController.text.trim();
    final newPass = _newPasswordController.text.trim();

    if (current.isEmpty || newPass.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill both password fields')),
      );
      return;
    }

    setState(() {
      _showPasswordFields = false;
      _currentPasswordController.clear();
      _newPasswordController.clear();
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Password changed successfully ✅')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: AppBar(
        title: const Text('Edit Profile'),
        backgroundColor: AppColor.primaryDarkest,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _buildGeneralProfileFields(),
              const SizedBox(height: 30),
              _buildAllergyManagementSection(),
              const SizedBox(height: 40),
              _buildSaveButton(),
            ],
          ),
        ),
      ),
    );
  }

  // --- General Profile Section with Change Password ---
  Widget _buildGeneralProfileFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Center(
          child: CircleAvatar(
            radius: 50,
            backgroundImage: NetworkImage(
              'https://via.placeholder.com/150/008080/FFFFFF?Text=User',
            ),
            backgroundColor: AppColor.primaryDarkest,
          ),
        ),
        const SizedBox(height: 20),

        TextFormField(
          controller: _nameController,
          decoration: Util().appTextFieldDecoration.copyWith(
            labelText: 'Full Name',
            prefixIcon: const Icon(Icons.person_outline, color: AppColor.primaryDarkest),
          ),
          validator: (value) => value!.isEmpty ? 'Name is required.' : null,
        ),
        const SizedBox(height: 15),

        TextFormField(
          controller: _emailController,
          keyboardType: TextInputType.emailAddress,
          decoration: Util().appTextFieldDecoration.copyWith(
            labelText: 'Email',
            prefixIcon: const Icon(Icons.email_outlined, color: AppColor.primaryDarkest),
          ),
          validator: (value) =>
              !value!.contains('@') ? 'Enter a valid email.' : null,
        ),
        const SizedBox(height: 15),

        TextFormField(
          controller: _bioController,
          maxLines: 3,
          decoration: Util().appTextFieldDecoration.copyWith(
            labelText: 'Bio / Short Description',
            prefixIcon: const Icon(Icons.description, color: AppColor.primaryDarkest),
          ),
        ),
        const SizedBox(height: 15),

        // --- Change Password Button ---
        Align(
          alignment: Alignment.centerRight,
          child: TextButton.icon(
            icon: const Icon(Icons.lock_outline, color: AppColor.primaryDarkest),
            label: const Text(
              'Change Password',
              style: TextStyle(color: AppColor.primaryDarkest, fontWeight: FontWeight.bold),
            ),
            onPressed: () {
              setState(() {
                _showPasswordFields = !_showPasswordFields;
              });
            },
          ),
        ),

        // --- Password Fields (Visible when pressed) ---
        if (_showPasswordFields) ...[
          TextFormField(
            controller: _currentPasswordController,
            obscureText: true,
            decoration: Util().appTextFieldDecoration.copyWith(
              labelText: 'Current Password',
              prefixIcon: const Icon(Icons.lock, color: AppColor.primaryDarkest),
            ),
          ),
          const SizedBox(height: 10),
          TextFormField(
            controller: _newPasswordController,
            obscureText: true,
            decoration: Util().appTextFieldDecoration.copyWith(
              labelText: 'New Password',
              prefixIcon: const Icon(Icons.lock_open, color: AppColor.primaryDarkest),
            ),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: _changePassword,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColor.primaryDarkest,
              padding: const EdgeInsets.symmetric(vertical: 12),
            ),
            child: const Text(
              'Save Password',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ],
    );
  }

  // --- Allergy Section ---
  Widget _buildAllergyManagementSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Allergies & Dietary Restrictions',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColor.textPrimary,
          ),
        ),
        const Divider(color: AppColor.divider),
        Wrap(
          spacing: 8.0,
          children: _allergies.map((allergy) {
            return Chip(
              label: Text(allergy, style: const TextStyle(color: AppColor.textPrimary)),
              backgroundColor: AppColor.secondary,
              deleteIconColor: Colors.black87,
              deleteIcon: const Icon(Icons.close, size: 18),
              onDeleted: () => _removeAllergy(allergy),
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
                  hintText: 'e.g., Gluten, Shellfish, Soy',
                  contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                ),
                onFieldSubmitted: (value) => _addAllergy(),
              ),
            ),
            const SizedBox(width: 8),
            ElevatedButton.icon(
              onPressed: _addAllergy,
              icon: const Icon(Icons.add, color: Colors.white),
              label: const Text('Add', style: TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSaveButton() {
    return ElevatedButton(
      onPressed: _isLoading ? null : _updateProfile,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColor.primaryDarkest,
        padding: const EdgeInsets.symmetric(vertical: 15),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      child: _isLoading
          ? const SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 3.0,
              ),
            )
          : const Text(
              'Save Changes',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
    );
  }
}
