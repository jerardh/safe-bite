import 'package:flutter/material.dart';
import 'package:safebite/util/AppText.dart';

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
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 6,
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Food Name
            Text(
              foodName,
              style: AppText().secondaryStyle
            ),
            const SizedBox(height: 10),

            // Ingredients Title
            Text(
              "Ingredients:",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.grey[700],
              ),
            ),
            const SizedBox(height: 8),

            // Ingredient List
            ...ingredients.map(
              (item) => Row(
                children: [
                  const Icon(Icons.check_circle, size: 18, color: Colors.green),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      item,
                      style: const TextStyle(fontSize: 14),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
