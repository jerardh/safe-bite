import 'dart:ffi';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:safebite/screens/allergeninfo/AllergenInfo.dart';
import 'package:safebite/screens/foodanalysis/components/NutritionTile.dart';
import 'package:safebite/util/AppCircularProgress.dart';
import 'package:safebite/util/AppText.dart';
import 'package:safebite/util/appColor.dart';
import 'package:safebite/util/util.dart';

class FoodAnalysis extends StatefulWidget {
  final String foodname;
  final File foodImage;
  final double? probs;
  final double? amount;
  const FoodAnalysis(
      {super.key,
      required this.foodname,
      required this.foodImage,
      required this.probs,
      required this.amount});
  @override
  State<StatefulWidget> createState() {
    return FoodAnalysisState();
  }
}

class FoodAnalysisState extends State<FoodAnalysis> {
  final CollectionReference userInfo =
      FirebaseFirestore.instance.collection('caloriedata');
  Map<String, dynamic>? foodData; //contains information fetched from firebase
  Future<void> fetchFoodData() async {
    try {
      // example: get document with id "user1" from "users" collection
      DocumentSnapshot snapshot = await userInfo.doc(widget.foodname).get();

      if (snapshot.exists) {
        setState(() {
          foodData = snapshot.data() as Map<String, dynamic>;
        });
      }
    } catch (e) {
      print("Error fetching data: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    fetchFoodData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: Util().appBar,
        body: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.all(50.0),
                child: foodData == null
                    ? Center(child: Appcircularprogress())
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                            Text("Food Analysis Results",
                                style: AppText().secondaryStyle),
                            SizedBox(height: 20),
                            Text("Nutritional information and allergen check",
                                style: AppText().hintTextStyle),
                            SizedBox(height: 40),
                            Row(
                              children: [
                                ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Image(
                                        image: FileImage(widget.foodImage),
                                        height: 200,
                                        width: 150,
                                        fit: BoxFit.cover)),
                                SizedBox(width: 20),
                                Column(children: [
                                  Text(widget.foodname,
                                      style: AppText().analysistextStyle),
                                  SizedBox(height: 10),
                                  Container(
                                    width: 100,
                                    height: 100,
                                    decoration: BoxDecoration(
                                      color: AppColor
                                          .primaryDarker, // Background color
                                      shape:
                                          BoxShape.circle, // Makes it a circle
                                    ),
                                    child: Center(
                                      child: Text(
                                          "\t\t\t" +
                                              (foodData?["cps"] *
                                                          widget.amount /
                                                          (foodData?["size"] ??
                                                              100) ??
                                                      "0")
                                                  .toString() +
                                              "\nCalories",
                                          style: AppText().textStyle),
                                    ),
                                  )
                                ])
                              ],
                            ),
                            SizedBox(height: 20),
                            Wrap(spacing: 20, runSpacing: 20, children: [
                              Nutritiontile(
                                  name: "carbs",
                                  value: foodData?["carbs"] *
                                          widget.amount /
                                          (foodData?["size"] ?? 100) ??
                                      0),
                              Nutritiontile(
                                  name: "fat",
                                  value: foodData?["fat"] *
                                          widget.amount /
                                          (foodData?["size"] ?? 100) ??
                                      0),
                              Nutritiontile(
                                  name: "protein",
                                  value: foodData?["protein"] *
                                          widget.amount /
                                          (foodData?["size"] ?? 100) ??
                                      0)
                            ]),
                            SizedBox(height: 20),
                            Row(children: [
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColor.primaryRed,
                                    foregroundColor: Colors.white,
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)))),
                                onPressed: () => {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const Allergeninfo(
                                                foodName: "jalebi")),
                                  )
                                },
                                child: Text("allergic info"),
                              )
                            ])
                          ]))));
  }
}
