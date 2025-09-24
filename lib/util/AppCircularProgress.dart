import 'package:flutter/material.dart';
import 'package:safebite/util/appColor.dart';

class Appcircularprogress extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return (Container
    (color: Colors.white,
      child: CircularProgressIndicator(
      strokeWidth: 5,
      backgroundColor: AppColor.secondary,
      valueColor: const AlwaysStoppedAnimation(AppColor.primaryDarkest),
    )));
  }
}
