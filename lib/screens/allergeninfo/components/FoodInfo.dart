import 'package:flutter/material.dart';
import 'package:safebite/util/AppText.dart';
import 'package:safebite/util/appColor.dart';
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
        decoration: BoxDecoration(),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Dish Card
                Card(
                  elevation: 6,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  color: AppColor.primary,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.white,
                          child: Icon(Icons.fastfood,
                              color: AppColor.primary, size: 30),
                        ),
                        SizedBox(width: 16),
                        Text(
                          foodName,
                          style: AppText().primaryStyle,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),

                Text(
                  "Ingredients",
                  style: AppText().secondaryStyle,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 12),

                // Ingredients as stylish cards
                Expanded(
                  child: GridView.builder(
                    itemCount: ingredients.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 3,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                    ),
                    itemBuilder: (context, index) {
                      return Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        color: Colors.white,
                        child: Center(
                          child: Text(
                            ingredients[index],
                            style: AppText().hintTextStyle,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
