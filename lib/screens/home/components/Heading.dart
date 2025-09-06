import 'package:safebite/util/AppColor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:safebite/util/AppText.dart';

class Heading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(
      AppText.title,
      style:
          TextStyle(color: AppColor.textPrimary, fontSize: AppText.primarySize),
    );
  }
}
