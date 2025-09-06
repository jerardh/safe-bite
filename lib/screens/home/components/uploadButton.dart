import 'package:flutter/material.dart';

class UploadButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(10),
        child: SizedBox(
            child: ElevatedButton(
                child: Text("Find Food",
                    style: TextStyle(fontWeight: FontWeight.w700)),
                onPressed: () => {},
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))))),
            width: double.infinity));
  }
}
