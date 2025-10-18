import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:safebite/util/appColor.dart';

class AppText {
  static const title = "SafeBite";
  static const numclasses = 20; //Number of food classes
  final TextStyle primaryStyle = GoogleFonts.lato(
      fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold);
  final TextStyle secondaryStyle = GoogleFonts.lato(
      fontSize: 30, color: AppColor.primaryDarker, fontWeight: FontWeight.w800);
  final TextStyle textStyle = GoogleFonts.lato(
      fontSize: 15, color: Colors.white, fontWeight: FontWeight.w800);
  final TextStyle hintTextStyle = GoogleFonts.lato(
      fontSize: 15, color: AppColor.primaryDarker, fontWeight: FontWeight.w800);
  final TextStyle alertTextStyle = GoogleFonts.lato(
      fontSize: 15, color: Colors.white, fontWeight: FontWeight.w800);
  final TextStyle secondaryhintTextStyle = GoogleFonts.lato(
      fontSize: 15, color: Colors.white, fontWeight: FontWeight.w800);
  final TextStyle analysistextStyle = GoogleFonts.lato(
      fontSize: 20, color: AppColor.primaryDarker, fontWeight: FontWeight.w800);
  final TextStyle contenttextStyle = GoogleFonts.lato(
      fontSize: 15, color: AppColor.textSecondary, fontWeight: FontWeight.w600);
  final TextStyle activitydesctextStyle = GoogleFonts.lato(
      fontSize: 15, color: AppColor.textSecondary, fontWeight: FontWeight.w600);
  final TextStyle activitydurctextStyle = GoogleFonts.lato(
      fontSize: 15, color: AppColor.textSecondary, fontWeight: FontWeight.w400);
}
