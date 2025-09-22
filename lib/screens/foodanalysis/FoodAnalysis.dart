import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:safebite/util/AppText.dart';
import 'package:safebite/util/util.dart';

class FoodAnalysis extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return FoodAnalysisState();
  }
}

class FoodAnalysisState extends State<FoodAnalysis> {
  String? _foodname;
  final CollectionReference userInfo =
      FirebaseFirestore.instance.collection('caloriedata');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: Util().appBar,
        body: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.all(50.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Food Analysis Results",
                          style: AppText().secondaryStyle),
                      SizedBox(height: 20),
                      Text("Nutritional information and allergen check",
                          style: AppText().hintTextStyle),
                      SizedBox(height: 20),
                      Row(
                        children: [],
                      )
                    ]))));
  }
}
