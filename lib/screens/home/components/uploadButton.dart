import 'dart:io';

import 'package:flutter/material.dart';
import 'package:safebite/util/AppText.dart';
import 'package:safebite/util/PreProcessImage.dart';
import 'package:safebite/util/appColor.dart';

class UploadButton extends StatelessWidget {
  File ImageFile;
  UploadButton({Key? key, required this.ImageFile}) : super(key: key);
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(10),
        child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
                onPressed: () => {classifyImage()},
                style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.primaryDarker,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)))),
                child: Text("Find Food", style: AppText().textStyle))));
  }

  void classifyImage() async {
    if (ImageFile != null) {
      List<List<List<List<double>>>> preProcessedImage =
          await PreProcessImage().preprocessImage(ImageFile);
      print("Got final image");
    } else {
      print("did not get the image");
    }
  }
}
