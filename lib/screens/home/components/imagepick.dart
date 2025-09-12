import 'package:safebite/screens/home/components/QRImagePicker.dart';
import 'package:safebite/screens/home/components/uploadButton.dart';
import 'package:safebite/util/AppText.dart';
import 'package:safebite/util/appColor.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:safebite/screens/home/components/ImageQuantity.dart';

class ImagePick extends StatefulWidget {
  @override
  State<ImagePick> createState() {
    return ImagePickState();
  }
}

class ImagePickState extends State<ImagePick> {
  @override
  Widget build(BuildContext context) {
    return (Padding(
        padding: EdgeInsets.all(30),
        child: SizedBox(
            height: 500,
            width: double.infinity,
            child: Card(
                elevation: 3,
                shadowColor: AppColor.textSecondary,
                color: AppColor.surface,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 20),
                    Text("Scan Your Food", style: AppText().secondaryStyle),
                    SizedBox(height: 20),
                    SizedBox(width: 200, child: QRImagePicker()),
                    SizedBox(height: 10),
                    ImageQunatity(),
                    UploadButton()
                  ],
                )))));
  }
}
