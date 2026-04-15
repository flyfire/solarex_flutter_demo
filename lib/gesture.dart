import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class ListenerWidget extends StatelessWidget {
  const ListenerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Listener(
        child: Container(
          color: Colors.red,
          width: 300,
          height: 300,
        ),
        onPointerDown: (event) => print("down $event"),
        onPointerMove: (event) => print("move $event"),
        onPointerUp: (event) => print("up $event"),
      ),
    );
  }
}

class DragWidget extends StatefulWidget {
  const DragWidget({super.key});

  @override
  State<StatefulWidget> createState() {
    return _DragState();
  }
}

class _DragState extends State<DragWidget> {
  double _top = 0.0;
  double _left = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("demo"),
      ),
      body: Stack(
        children: [
          Positioned(
              top: _top,
              left: _left,
              child: GestureDetector(
                child: Container(
                  color: Colors.red,
                  width: 50,
                  height: 50,
                ),
                onTap: () => print("tap"),
                onDoubleTap: () => print("double tap"),
                onLongPress: () => print("long press"),
                onPanUpdate: (e) {
                  setState(() {
                    _left += e.delta.dx;
                    _top += e.delta.dy;
                  });
                },
              ))
        ],
      ),
    );
  }
}

class DoubleGestureWidget extends StatelessWidget {
  const DoubleGestureWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RawGestureDetector(
        gestures: {
          MultipleTapGestureRecognizer: GestureRecognizerFactoryWithHandlers<
                  MultipleTapGestureRecognizer>(
              () => MultipleTapGestureRecognizer(), (t) {
            t.onTap = () => print('parent taped');
          })
        },
        child: Container(
          color: Colors.pinkAccent,
          child: Center(
            child: GestureDetector(
              onTap: () => print("child tapped"),
              child: Container(
                color: Colors.blueAccent,
                width: 200.0,
                height: 200.0,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class MultipleTapGestureRecognizer extends TapGestureRecognizer {
  @override
  void rejectGesture(int pointer) {
    acceptGesture(pointer);
  }
}

class GestureHomePage extends StatelessWidget {
  final String? title;

  const GestureHomePage({super.key, this.title});

  @override
  Widget build(BuildContext context) {
    return const DefaultTabController(
      length: 3,
      child: Scaffold(
        body: TabBarView(
            physics: NeverScrollableScrollPhysics(),
            children: [ListenerWidget(), DragWidget(), DoubleGestureWidget()]),
        bottomNavigationBar: TabBar(
          tabs: [
            Tab(
              icon: Icon(Icons.home),
              text: "指针事件",
            ),
            Tab(
              icon: Icon(Icons.rss_feed),
              text: "手势",
            ),
            Tab(
              icon: Icon(Icons.perm_identity),
              text: "手势冲突",
            )
          ],
          unselectedLabelColor: Colors.blueGrey,
          labelColor: Colors.blue,
          indicatorSize: TabBarIndicatorSize.label,
          indicatorColor: Colors.red,
        ),
      ),
    );
  }
}

class GestureApp extends StatelessWidget {
  const GestureApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Gesture Demo",
      theme: ThemeData(
        primarySwatch: Colors.blue
      ),
      home: const GestureHomePage(title: "Gesture Demo Home Page",),
    );
  }

}

void main() => runApp(const GestureApp());
