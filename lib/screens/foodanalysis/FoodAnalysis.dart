import 'dart:ffi';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:safebite/util/AppText.dart';
import 'package:safebite/util/util.dart';

class FoodAnalysis extends StatefulWidget {
  final String foodname;
  final File foodImage;
  final double? probs;
  const FoodAnalysis(
      {super.key,
      required this.foodname,
      required this.foodImage,
      required this.probs});
  @override
  State<StatefulWidget> createState() {
    return FoodAnalysisState();
  }
}

class FoodAnalysisState extends State<FoodAnalysis> {
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
                          SizedBox(width: 50),
                          Text(widget.foodname, style: AppText().secondaryStyle)
                        ],
                      )
                    ]))));
  }
}
