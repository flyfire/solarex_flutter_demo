import 'package:flutter/material.dart';

class WidgetAnimateWidget extends StatefulWidget {
  const WidgetAnimateWidget({super.key});

  @override
  State<StatefulWidget> createState() {
    return _WidgetAnimateWidgetState();
  }
}

class _WidgetAnimateWidgetState extends State<WidgetAnimateWidget>
    with SingleTickerProviderStateMixin {

  late AnimationController controller;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 1000));
    final CurvedAnimation curve = CurvedAnimation(parent: controller, curve: Curves.elasticInOut);
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
        body: AnimatedLogo(listenable: animation),
      ),
    );
  }
}

class AnimatedLogo extends AnimatedWidget {
  const AnimatedLogo({super.key, required super.listenable});

  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = listenable as Animation<double>;
    return Center(
      child: SizedBox(
        height: animation.value,
        width: animation.value,
        child: const FlutterLogo(),
      ),
    );
  }

}
