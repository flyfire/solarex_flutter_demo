import 'package:flutter/material.dart';

class CounterPage extends StatefulWidget {
  const CounterPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return CounterPageState();
  }

}

class CounterPageState extends State<CounterPage> {
  int count = 0;

  void _incrementCounter() {
    setState(() {
      count++;
    });
  }
  @override
  Widget build(BuildContext context) {
    return CountContainer(count: count, increment: _incrementCounter, child: const Counter());
  }

}

class CountContainer extends InheritedWidget {

  static CountContainer of(BuildContext context) {
    final container = context.dependOnInheritedWidgetOfExactType<CountContainer>();
    assert(container != null, "No CountContainer found in context");
    return container!;
  }
  final int count;
  final Function() increment;
  const CountContainer({super.key, required this.count, required this.increment, required super.child});

  @override
  bool updateShouldNotify(CountContainer oldWidget) {
    return count != oldWidget.count;
  }

}

class Counter extends StatelessWidget {
  const Counter({super.key});

  @override
  Widget build(BuildContext context) {
    CountContainer state = CountContainer.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text("InheritedWidget demo"),),
      body: Text("you have pushed the button this many times: ${state.count}"),
      floatingActionButton: FloatingActionButton(onPressed: state.increment),
    );
  }

}