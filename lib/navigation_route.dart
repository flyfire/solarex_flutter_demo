import 'package:flutter/material.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _FirstPageState();
  }
  
}

class _FirstPageState extends State<FirstPage> {
  String _msg = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("first screen"),),
      body: Column(
        children: [
          TextButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const SecondPage())), child: const Text("基本路由")),
          TextButton(onPressed: () => Navigator.pushNamed(context, "second_page"), child: const Text("命名路由")),
          TextButton(onPressed: () => Navigator.pushNamed(context, "third_page", arguments: "Hey").then((msg){
            setState(() {
              _msg = msg as String;
            });
          }), child: const Text("命名路由(参数&回调)")),
          Text('message from second screen: $_msg'),
          TextButton(onPressed: () => Navigator.pushNamed(context, "unknown_page"), child: const Text('命名路由异常处理'))
        ],
      ),
    );
  }
  
}

class SecondPage extends StatelessWidget {
  const SecondPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("second screen"),),
      body: TextButton(onPressed: () => Navigator.pop(context), child: const Text("back to first screen")),
    );
  }

}

class UnknownPage extends StatelessWidget {
  const UnknownPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("unknown screen"),),
      body: TextButton(onPressed: () => Navigator.pop(context), child: const Text("back")),
    );
  }

}

class ThirdPage extends StatelessWidget {
  const ThirdPage({super.key});

  @override
  Widget build(BuildContext context) {
    String msg = ModalRoute.of(context)?.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(title: const Text("third screen"),),
      body: Column(
        children: [
          Text('message from first screen: $msg'),
          TextButton(onPressed: () => Navigator.pop(context, "hi"), child: const Text("back"))
        ],
      ),
    );
  }

}

class NavigationRouteApp extends StatelessWidget {
  const NavigationRouteApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "navigation",
      routes: {
        "second_page": (context) => const SecondPage(),
        "third_page": (context) => const ThirdPage()
      },
      onUnknownRoute: (RouteSettings setting) => MaterialPageRoute(builder: (context) => const UnknownPage()),
      home: const FirstPage(),
    );
  }

}

void main() => runApp(const NavigationRouteApp());