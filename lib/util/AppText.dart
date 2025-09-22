import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:safebite/util/appColor.dart';

class AppText {
  static const title = "NutriLens";
  static const numclasses = 80; //Number of food classes
  final TextStyle primaryStyle = GoogleFonts.lato(
      fontSize: 30,
      color: AppColor.primaryDarkest,
      fontWeight: FontWeight.bold);
  final TextStyle secondaryStyle = GoogleFonts.lato(
      fontSize: 30, color: AppColor.primaryDarker, fontWeight: FontWeight.w800);
  final TextStyle textStyle = GoogleFonts.lato(
      fontSize: 15, color: Colors.white, fontWeight: FontWeight.w800);
  final TextStyle hintTextStyle = GoogleFonts.lato(
      fontSize: 15, color: AppColor.primaryDarker, fontWeight: FontWeight.w800);
}
