import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:safebite/util/appColor.dart';

class Calorieinfo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CalorieInfoState();
  }
}

class CalorieInfoState extends State<Calorieinfo> {
  var carbs = 0.7, protein = 0.8, calories = 0.9;
  var radius = 50.0, linewidth = 12.0;
  @override
  Widget build(BuildContext context) {
    return Container(
        color: AppColor.primary,
        child: SizedBox(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CircularPercentIndicator(
              radius: radius,
              lineWidth: linewidth,
              percent: carbs,
              center: Text("Carbs\n " + carbs.toString()),
              progressColor: AppColor.primaryDarker,
            ),
            CircularPercentIndicator(
                radius: radius,
                lineWidth: linewidth,
                percent: protein,
                center: Text("Protein\n " + protein.toString()),
                progressColor: AppColor.primaryDarker),
            CircularPercentIndicator(
                radius: radius,
                lineWidth: linewidth,
                percent: calories,
                center: Text("Calories\n " + calories.toString()),
                progressColor: AppColor.primaryDarker)
          ],
        )));
  }
}
