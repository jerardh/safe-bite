import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:safebite/screens/allergeninfo/components/FoodInfo.dart';
import 'package:safebite/util/AppCircularProgress.dart';
import 'package:safebite/util/AppText.dart';
import 'package:safebite/util/appColor.dart';
import 'package:safebite/util/util.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Allergeninfo extends StatefulWidget {
  final String foodName;

  const Allergeninfo({super.key, required this.foodName});

  @override
  State<Allergeninfo> createState() => _AllergeninfoState();
}

class _AllergeninfoState extends State<Allergeninfo> {
  List<String>? ingredients;
  List<String>? allergens;
  Map<String, dynamic>? responsedata;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getIngredients(widget.foodName);
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        appBar: Util().appBar,
        body: Center(child: Appcircularprogress()),
      );
    }

    return Scaffold(
      body: FoodInfo(
          foodName: widget.foodName,
          ingredients: ingredients ?? [],
          allergens: allergens ?? []),
    );
  }

  Future<void> getIngredients(String foodName) async {
    setState(() => isLoading = true);
    final prefs = await SharedPreferences.getInstance();
    final email = prefs.getString('email');
    final url = Uri(
      scheme: "http",
      host: Util.hostname,
      port: 5000,
      path: "/get_food_info",
      queryParameters: {"dish": foodName, "email": email},
    );

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        responsedata = jsonDecode(response.body);

        setState(() {
          ingredients = List<String>.from(responsedata!['ingredients'] ?? []);
          allergens = List<String>.from(responsedata!['allergens'] ?? []);
          if (!(allergens?.isEmpty ?? true)) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  "Food Contains allergens"+
                      (allergens != null ? ": ${allergens!.join(", ")}" : ""),
                  style: AppText().alertTextStyle,
                ),
                duration: Duration(seconds: 5),
                backgroundColor: AppColor.primaryRed,
              ),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  "Food is Safe to Eat",
                  style: AppText().alertTextStyle,
                ),
                duration: Duration(seconds: 5),
                backgroundColor: AppColor.primaryDark,
              ),
            );
          }
        });

        print("Ingredients: $ingredients");
        print("Allergens: $allergens");
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed with code: ${response.statusCode}")),
        );
      }
    } catch (e) {
      print("Error: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }
}
