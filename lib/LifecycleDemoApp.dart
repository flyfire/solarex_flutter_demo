import 'package:flutter/material.dart';
import 'package:solarex_flutter_demo/LifecycleDemoPage1.dart';

class LifecycleDemoApp extends StatelessWidget {
  const LifecycleDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "lifecycle demo",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LifecycleDemoPage1(),
    );
  }

}