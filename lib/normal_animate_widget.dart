import 'package:flutter/material.dart';

class NormalAnimateWidget extends StatefulWidget {
  const NormalAnimateWidget({super.key});

  @override
  State<StatefulWidget> createState() {
    return _NormalAnimateState();
  }

}

class _NormalAnimateState extends State<NormalAnimateWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 1000));
    final CurvedAnimation curve = CurvedAnimation(parent: controller, curve: Curves.elasticInOut);
    animation = Tween(begin: 50.0, end: 200.0).animate(curve)..addListener(() => setState(() {

    }));
    controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: SizedBox(
            width: animation.value,
            height: animation.value,
            child: const FlutterLogo(),
          ),
        ),
      ),
    );
  }
}