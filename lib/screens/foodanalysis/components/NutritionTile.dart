import 'package:flutter/material.dart';
import 'package:safebite/util/AppText.dart';
import 'package:safebite/util/appColor.dart';

class Nutritiontile extends StatelessWidget {
  final String name;
  final value;
  const Nutritiontile({super.key, required this.name, required this.value});
  @override
  Widget build(BuildContext context) {
    return (Container(
      width: 120,
      height: 40,
      padding: EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColor.secondary,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(0, 2),
          )
        ],
      ),
      child: Center(child: Text(name+"\t"+value.toString()+" g", style: AppText().hintTextStyle)),
    ));
  }
}
