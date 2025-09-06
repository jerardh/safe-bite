import 'package:flutter/material.dart';

class Custombutton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Choose an Image"),
          IconButton(
              onPressed: () => {}, icon: Icon(Icons.camera_alt), iconSize: 30)
        ],
      ),
      width: 200,
    );
  }
}
