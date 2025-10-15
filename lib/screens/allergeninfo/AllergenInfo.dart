import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:safebite/screens/allergeninfo/components/FoodInfo.dart';
import 'package:safebite/util/AppCircularProgress.dart';
import 'package:safebite/util/util.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    // Show circular progress indicator while loading
    if (isLoading) {
      return Scaffold(
        appBar: Util().appBar,
        body: Center(child: Appcircularprogress()),
      );
    }

    //Prepare ingredients list once data is fetched
    List<String> ingrs =
        (ingredients != null && ingredients!.containsKey("ingredients"))
            ? (ingredients!["ingredients"] as List).cast<String>()
            : [];

    return Scaffold(
      body: FoodInfo(
        foodName: widget.foodName,
        ingredients: ingrs,
      ),
    );
  }

  Future<void> getIngredients(String foodName) async {
    print("called getIngredients");
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
      print("Trying to call $url");
      final response = await http.get(url);

      if (response.statusCode == 200) {
        setState(() {
          ingredients = jsonDecode(response.body);
        });
        print("Results: ${ingredients?['ingredients']}");
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
