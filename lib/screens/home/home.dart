import 'package:flutter/widgets.dart';
import 'package:safebite/screens/home/components/CalorieInfo.dart';
import 'package:safebite/screens/home/components/imagepick.dart' as picker;

class Home extends StatefulWidget {
  @override
  State<Home> createState() {
    return HomeState();
  }
}

class HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(child: Calorieinfo(), height: 200),
            picker.ImagePick()
          ]),
    );
  }
}
