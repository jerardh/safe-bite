import 'package:flutter/material.dart';
import 'package:safebite/screens/home/components/Heading.dart';
import 'package:safebite/util/appColor.dart';

class Util {
  static const title = "Safe Bite";
  var appBar = AppBar(title: Heading(), backgroundColor: AppColor.primary);
}
