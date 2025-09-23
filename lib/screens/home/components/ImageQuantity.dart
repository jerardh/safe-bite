import 'dart:ffi';

import 'package:safebite/util/AppColor.dart';
import 'package:safebite/util/AppText.dart';
import 'package:flutter/material.dart';

class ImageQunatity extends StatefulWidget {
  final Function(String) onDataChanged;
  const ImageQunatity({super.key, required this.onDataChanged});
  @override
  State<StatefulWidget> createState() {
    return ImageQuantityState();
  }
}

class ImageQuantityState extends State<ImageQunatity> {
  var _quantity = 0.3; //300 grams as initial value
  final TextEditingController _controller =
      TextEditingController(text: "300.00");
  @override
  Widget build(BuildContext context) {
    return (Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
      Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
                width: 230,
                child: Slider(
                  value: _quantity,
                  activeColor: AppColor.primaryDarker,
                  inactiveColor: AppColor.divider,
                  onChanged: (double value) {
                    setState(() {
                      _quantity = value;
                      _controller.text = (_quantity * 1000).toStringAsFixed(2);
                    });
                  },
                )),
            SizedBox(
                width: 80,
                child: TextField(
                    controller: _controller,
                    onChanged: (String value) {
                      setState(() {
                        _quantity = double.parse(value) / 1000;
                        widget.onDataChanged(value);
                      });
                    },
                    maxLength: 6,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        counterText: "",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8)))))
          ]),
      Container(
          margin: const EdgeInsets.only(right: 30, top: 5),
          child: Text("grams", style: AppText().hintTextStyle))
    ]));
  }
}
