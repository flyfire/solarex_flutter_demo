import 'package:flutter/material.dart';

class LifecycleDemoPage2 extends StatefulWidget {
  const LifecycleDemoPage2({super.key});

  @override
  State<StatefulWidget> createState() {
    return _LifecycleDemoPage2State();
  }

}

class _LifecycleDemoPage2State extends State<LifecycleDemoPage2> {
  int _counter = 0;

  @override
  void initState() {
    super.initState();
    print('page2 initState');
  }

  @override
  void setState(VoidCallback fn) {
    super.setState(fn);
    print('page2 setState');
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print('page2 didChangeDependencies');
  }

  @override
  Widget build(BuildContext context) {
    print('page2 build...');
    return Scaffold(
      appBar: AppBar(title: const Text("setState demo"),),
      body: Center(
        child: ElevatedButton(onPressed: () {
          setState(() {
            _counter++;
          });
        }, child: Child(solarexcount: _counter)),
      ),
    );
  }

  @override
  void didUpdateWidget(covariant LifecycleDemoPage2 oldWidget) {
    super.didUpdateWidget(oldWidget);
    print('page2 didUpdateWidget');
  }

  @override
  void deactivate() {
    super.deactivate();
    print('page2 deactivate');
  }

  @override
  void dispose() {
    super.dispose();
    print('page2 dispose');
  }

}

class Child extends StatefulWidget {
  final int solarexcount;
  const Child({super.key, required this.solarexcount});

  @override
  State<StatefulWidget> createState() {
    return _ChildState();
  }

}

class _ChildState extends State<Child> {
  @override
  Widget build(BuildContext context) {
    print('page2 child build...');
    return Text("点击按钮查看状态变化 count: ${widget.solarexcount}");
  }

  @override
  void initState() {
    super.initState();
    print('page2 child initState');
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print('page2 child didChangeDependencies');
  }

  @override
  void didUpdateWidget(covariant Child oldWidget) {
    super.didUpdateWidget(oldWidget);
    print('page2 child didUpdateWidget');
  }

  @override
  void deactivate() {
    super.deactivate();
    print('page2 child deactivate');
  }

  @override
  void dispose() {
    super.dispose();
    print('page2 child dispose');
  }

}