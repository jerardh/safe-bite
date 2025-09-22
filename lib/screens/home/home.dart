import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:safebite/screens/home/components/CalorieInfo.dart';
import 'package:safebite/screens/home/components/imagepick.dart' as picker;
import 'package:safebite/util/AppText.dart';
import 'package:safebite/util/appColor.dart';
import 'package:safebite/util/util.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() {
    return HomeState();
  }
}

class HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    print("started app");
    return Scaffold(
        appBar: Util().appBar,
        body: SingleChildScrollView(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [picker.ImagePick()]),
        ));
  }
}
