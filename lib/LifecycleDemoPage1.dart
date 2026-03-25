import 'package:flutter/material.dart';
import 'package:solarex_flutter_demo/LifecycleDemoPage2.dart';

class LifecycleDemoPage1 extends StatefulWidget {
  const LifecycleDemoPage1({super.key});

  @override
  State<StatefulWidget> createState() {
    return _LifecycleDemoPage1State();
  }
}

class _LifecycleDemoPage1State extends State<LifecycleDemoPage1>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    print("page1 initState");
    WidgetsBinding.instance.addObserver(this);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      print("单次Frame绘制回调"); //只回调一次
    });
    WidgetsBinding.instance.addPersistentFrameCallback((_) {
      print("实时Frame绘制回调"); //每帧都回调
    });
  }

  @override
  void setState(VoidCallback fn) {
    super.setState(fn);
    print("page1 setState");
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print("page1 didChangeDependencies");
  }

  @override
  Widget build(BuildContext context) {
    print("page1 build....");
    return Scaffold(
      appBar: AppBar(title: const Text("Lifecycle Demo Page1"),),
      body: Center(
        child: Column(
          children: <Widget>[
            ElevatedButton(
                child: const Text("打开/关闭新页面查看状态变化"),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const LifecycleDemoPage2()));
                }
            ),
          ],
        ),
      ),
    );
  }

  @override
  void didUpdateWidget(covariant LifecycleDemoPage1 oldWidget) {
    super.didUpdateWidget(oldWidget);
    print("page1 didUpdateWidget");
  }

  @override
  void deactivate() {
    super.deactivate();
    print("page1 deactivate");
  }

  @override
  void dispose() {
    super.dispose();
    print('page1 dispose');
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    print("page1 app lifecycle state = $state");
  }
}
