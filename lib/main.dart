import 'package:flutter/material.dart';
import 'package:safebite/firebase_options.dart';
import 'package:safebite/screens/home/components/Heading.dart';
import 'package:safebite/screens/home/home.dart';
import 'package:safebite/util/util.dart';
import 'package:safebite/util/appColor.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions
        .currentPlatform, // Add this if using firebase_options.dart
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              seedColor: Color.fromARGB(255, 129, 250, 82)),
          useMaterial3: true,
          scaffoldBackgroundColor: AppColor.background),
      home: Scaffold(
          appBar: AppBar(title: Heading(), backgroundColor: AppColor.primary),
          body: Home()),
    );
  }
}
