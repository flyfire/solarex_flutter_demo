import 'package:flutter/material.dart';

class BuilderAnimateWidget extends StatefulWidget {
  const BuilderAnimateWidget({super.key});

  @override
  State<StatefulWidget> createState() {
    return _BuilderAnimateState();
  }
}

class _BuilderAnimateState extends State<BuilderAnimateWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1000));
    final CurvedAnimation curve = CurvedAnimation(
        parent: controller, curve: Curves.elasticInOut);
    animation = Tween(begin: 50.0, end: 200.0).animate(curve);
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
          child: AnimatedBuilder(
              animation: animation,
              child: const FlutterLogo(),
              builder: (context, child) =>
                  SizedBox(
                    width: animation.value,
                    height: animation.value,
                    child: child,
                  )),
        ),
      ),
    );
  }
}
