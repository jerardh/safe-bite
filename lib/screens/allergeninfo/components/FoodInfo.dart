import 'package:flutter/material.dart';
import 'package:safebite/util/AppText.dart';
import 'package:safebite/util/util.dart';

class FoodInfo extends StatelessWidget {
  final String foodName;
  final List<String> ingredients;

  const FoodInfo({
    super.key,
    required this.foodName,
    required this.ingredients,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: Util().appBar,
        body: Container(
            width: 600,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              elevation: 3,
              margin: const EdgeInsets.all(10),
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // Food Name
                    Text(foodName, style: AppText().secondaryStyle),
                    const SizedBox(height: 10),

                    // Ingredients Title
                    Text(
                      "Ingredients:",
                      style: AppText().secondaryStyle,
                    ),
                    const SizedBox(height: 8),

                    // Ingredient List
                    ...ingredients.map(
                      (item) => Row(
                        children: [
                          const Icon(Icons.food_bank,
                              size: 18, color: Colors.green),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              item,
                              style: AppText().analysistextStyle,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )));
  }
}
