import 'package:flutter/material.dart';
import 'package:safebite/util/AppText.dart';
import 'package:safebite/util/appColor.dart';

class UploadButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(10),
        child: SizedBox(
            child: ElevatedButton(
                child: Text("Find Food", style: AppText().textStyle),
                onPressed: () => {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.primaryDarker,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))))),
            width: double.infinity));
  }
}
