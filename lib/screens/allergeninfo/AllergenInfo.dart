import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:safebite/screens/allergeninfo/components/FoodInfo.dart';
import 'package:safebite/util/AppCircularProgress.dart';
import 'package:safebite/util/util.dart';
import 'package:http/http.dart' as http;

class Allergeninfo extends StatefulWidget {
  final String foodName;
  const Allergeninfo({
    super.key,
    required this.foodName,
  });
  @override
  State<StatefulWidget> createState() {
    return AllergeninfoState();
  }
}

class AllergeninfoState extends State<Allergeninfo> {
  Map<String, dynamic>? ingredients;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getIngredients(widget.foodName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: Util().appBar,
        body: isLoading
            ? Center(
                widthFactor: 40, heightFactor: 40, child: Appcircularprogress())
            : FoodInfo(
                foodName: widget.foodName,
                ingredients: ingredients?["ingredients"] ?? [],
              ));
  }

  void getIngredients(String foodName) async {
    setState(() => isLoading = true);

    final url = Uri.https(
      Util.host,
      "get_food_info",
      {"dish": foodName},
    );

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        setState(() {
          ingredients = jsonDecode(response.body);
        });
        print("Results: $ingredients");
      } else {
        print("Failed with code: ${response.statusCode}");
      }
    } catch (e) {
      print("Error: $e");
    } finally {
      setState(() => isLoading = false);
    }
  }
}
