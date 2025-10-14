import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:safebite/screens/foodanalysis/FoodAnalysis.dart';
import 'package:safebite/util/AppCircularProgress.dart';
import 'package:safebite/util/AppText.dart';
import 'package:safebite/util/PreProcessImage.dart';
import 'package:safebite/util/appColor.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:safebite/util/util.dart';

class UploadButton extends StatefulWidget {
  final File ImageFile;
  const UploadButton({super.key, required this.ImageFile});

  @override
  _UploadButtonState createState() => _UploadButtonState();
}

class _UploadButtonState extends State<UploadButton> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: isLoading ? null : () => classifyImage(context),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColor.primaryDarker,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
          ),
          child: isLoading
              ? SizedBox(
                  width: 24,
                  height: 24,
                  child: Appcircularprogress(),
                )
              : Text("Find Food", style: AppText().textStyle),
        ),
      ),
    );
  }

  Future<void> classifyImage(BuildContext context) async {
    setState(() {
      isLoading = true; // show progress
    });

    try {
      print("Got final image");
      String tempurl = "${Util.host}predict";
      final url = Uri.parse(tempurl);
      print("URL=" + tempurl);
      var request = http.MultipartRequest('POST', url);
      request.files.add(await http.MultipartFile.fromPath(
        'image',
        widget.ImageFile.path,
      ));
      print("Image Path=" + widget.ImageFile.path);

      var response = await request.send();

      if (response.statusCode == 200) {
        final responseString = await response.stream.bytesToString();
        final data = jsonDecode(responseString);
        String classname = data['predicted_class'];
        print(
            "FOOD_NAME: $classname CONFIDENCE: ${data['prediction_prob'].toString()}");

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FoodAnalysis(
              foodname: classname,
              probs: data['prediction_prob'],
              foodImage: widget.ImageFile,
              amount: 100,
            ),
          ),
        );
      } else {
        print("Error: ${response.statusCode}");
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Upload failed!")));
      }
    } catch (e) {
      print("Exception: $e");
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Something went wrong!")));
    }

    setState(() {
      isLoading = false; // hide progress
    });
  }
}
