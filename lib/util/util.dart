import 'package:flutter/material.dart';
import 'package:safebite/screens/home/components/Heading.dart';
import 'package:safebite/util/appColor.dart';

class Util {
  static const title = "Safe Bite";
  static const host = "http://192.168.1.11:5000/";
  var appBar = AppBar(title: Heading(), backgroundColor: AppColor.primary);
  var appTextFieldDecoration = InputDecoration(
    floatingLabelStyle: TextStyle(color: AppColor.primaryDarkest),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
      borderSide: BorderSide(
        color: AppColor.primaryDarkest,
        width: 1.0,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
      borderSide: BorderSide(
        color: AppColor.primaryDarkest,
        width: 2.0,
      ),
    ),
  );
}
