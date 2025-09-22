import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:safebite/screens/foodanalysis/FoodAnalysis.dart';
import 'package:safebite/util/AppText.dart';
import 'package:safebite/util/PreProcessImage.dart';
import 'package:safebite/util/appColor.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class UploadButton extends StatelessWidget {
  File ImageFile;
  UploadButton({super.key, required this.ImageFile});
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10),
        child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
                onPressed: () => {classifyImage(context)},
                style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.primaryDarker,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)))),
                child: Text("Find Food", style: AppText().textStyle))));
  }

  Future<void> classifyImage(BuildContext context) async {
    print("Got final image");
    final url = Uri.parse("http://192.168.29.85:5000/predict");
    var request = http.MultipartRequest('POST', url);
    request.files.add(await http.MultipartFile.fromPath(
      'image', // field name -> must match Flask's request.files['image']
      ImageFile.path, // local file path
    ));
    print("Image Path=" + ImageFile.path);
    var response = await request.send();
    if (response.statusCode == 200) {
      final responseString = await response.stream.bytesToString();
      print("FINAL Prediction");
      final data = jsonDecode(responseString);
      String classname = data['predicted_class'];
      String probs = data['prediction_prob'].toString();
      print("FOOD_NAME" + classname + " CONFIDENCE" + probs);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => FoodAnalysis(
              foodname: classname, probs: data['prediction_prob'], foodImage: ImageFile),
        ),
      );
    } else {
      print("Error: ${response.statusCode}");
    }
  }
}
