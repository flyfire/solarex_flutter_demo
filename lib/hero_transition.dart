import 'package:flutter/material.dart';

class HeroPage1 extends StatelessWidget {
  const HeroPage1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("hero page1"),),
      body: GestureDetector(
        child: const Row(
          children: [
            Hero(tag: 'hero', child: SizedBox(width: 100, height: 100, child: FlutterLogo(),)),
            Text("点击logo查看hero效果")
          ],
        ),
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => const HeroPage2()));
        },
      ),
    );
  }
  
}

class HeroPage2 extends StatelessWidget {
  const HeroPage2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("hero page2"),),
      body: const Hero(tag: 'hero', child: SizedBox(
        width: 300,
        height: 300,
        child: FlutterLogo(),
      )),
    );
  }

}