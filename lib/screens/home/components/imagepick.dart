
import 'package:safebite/screens/home/components/customButton.dart';
import 'package:safebite/screens/home/components/uploadButton.dart';
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
  Image _img = Image.asset('assets/images/bir.png', height: 200, width: 200);
  String _hasImage = "False";
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
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 20),
                    SizedBox(
                        width: 200,
                        child: ElevatedButton(
                            onPressed: () => {getImage()},
                            child: Custombutton())),
                    SizedBox(height: 20),
                    _img,
                    SizedBox(height: 10),
                    ImageQunatity(),
                    UploadButton()
                  ],
                )))));
  }

  void getImage() async {
    ImagePicker imagePicker = ImagePicker();
    XFile? image = await imagePicker.pickImage(source: ImageSource.camera);
    if (image != null) {
      setState(() {
        _img = Image.file(File(image.path),
            width: 200,
            height:
                200); //creating Image Object using path in XFile;Xfile-->File-->Image
        _hasImage = "True";
      });
    }
  }
}
