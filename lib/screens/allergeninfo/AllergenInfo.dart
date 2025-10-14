import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:safebite/screens/allergeninfo/components/FoodInfo.dart';
import 'package:safebite/util/AppCircularProgress.dart';
import 'package:safebite/util/util.dart';
import 'package:http/http.dart' as http;

class Allergeninfo extends StatefulWidget {
  final String foodName;
  const Allergeninfo({super.key, required this.foodName});

  @override
  State<Allergeninfo> createState() => _AllergeninfoState();
}

class _AllergeninfoState extends State<Allergeninfo> {
  Map<String, dynamic>? ingredients;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getIngredients(widget.foodName);
  }

  @override
  Widget build(BuildContext context) {
    List<String> ingrs =
        (ingredients != null && ingredients!.containsKey("ingredients"))
            ? (ingredients!["ingredients"] as List).cast<String>()
            : [];

    return (FoodInfo(foodName: widget.foodName, ingredients: ingrs));
  }

  void getIngredients(String foodName) async {
    print("called getIngrediients");
    setState(() => {isLoading = true});

    final url = Uri(
      scheme: "http",
      host: "192.168.1.11",
      port: 5000,
      path: "/get_food_info",
      queryParameters: {"dish": foodName},
    );

    try {
      print("Trying to call ");
      final response = await http.get(url);
      if (response.statusCode == 200) {
        setState(() {
          ingredients = jsonDecode(response.body);
          print("Results: $ingredients['ingredients']");
        });
        print("Results: $ingredients['ingredients']");
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed with code: ${response.statusCode}")),
        );
      }
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    } finally {
      if (mounted) {
        setState(() => isLoading = false);
      }
    }
  }
}
