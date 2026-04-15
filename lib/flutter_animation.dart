import 'package:flutter/material.dart';
import 'package:solarex_flutter_demo/builder_animate_widget.dart';
import 'package:solarex_flutter_demo/hero_transition.dart';
import 'package:solarex_flutter_demo/normal_animate_widget.dart';
import 'package:solarex_flutter_demo/widget_animate_widget.dart';

class FlutterAnimationPage extends StatelessWidget {
  final String title;

  const FlutterAnimationPage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return const DefaultTabController(
        length: 4,
        child: Scaffold(
          body: TabBarView(children: [
            NormalAnimateWidget(),
            BuilderAnimateWidget(),
            WidgetAnimateWidget(),
            HeroPage1()
          ]),
          bottomNavigationBar: TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.home),
                text: "普通动画",
              ),
              Tab(
                icon: Icon(Icons.rss_feed),
                text: "Builder动画",
              ),
              Tab(
                icon: Icon(Icons.perm_identity),
                text: "Widget动画",
              ),
              Tab(
                icon: Icon(Icons.message),
                text: "hero动画",
              )
            ],
            unselectedLabelColor: Colors.blueGrey,
            labelColor: Colors.blue,
            indicatorSize: TabBarIndicatorSize.label,
            indicatorColor: Colors.red,
          ),
        ));
  }
}

class FlutterAnimationApp extends StatelessWidget {
  const FlutterAnimationApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "flutter animation demo",
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const FlutterAnimationPage(title: "animation demo"),
    );
  }

}

void main() => runApp(const FlutterAnimationApp());
