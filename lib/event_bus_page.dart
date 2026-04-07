import 'dart:async';

import "package:event_bus/event_bus.dart";
import 'package:flutter/material.dart';

class CustomEvent {
  String msg;

  CustomEvent(this.msg);
}

EventBus eventBus = EventBus();

class DataTransferFirstPage extends StatefulWidget {
  const DataTransferFirstPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _DataTransferFirstPageState();
  }

}

class _DataTransferFirstPageState extends State<DataTransferFirstPage> {
  String msg = "通知: ";
  late StreamSubscription subscription;

  @override
  void initState() {
    subscription = eventBus.on<CustomEvent>().listen((event) {
      print(event);
      setState(() {
        msg += event.msg;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("First page"),),
      body: Text(msg),
      floatingActionButton: FloatingActionButton(onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => const DataTransferSecondPage()));
      }),
    );
  }

}

class DataTransferSecondPage extends StatelessWidget {
  const DataTransferSecondPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Second Page"),),
      body: TextButton(onPressed: () {
        eventBus.fire(CustomEvent("hello"));
      }, child: Text("Fire event")),
    );
  }

}
