import 'package:flutter/material.dart';
import 'package:solarex_flutter_demo/count_container.dart';
import 'package:solarex_flutter_demo/event_bus_page.dart';
import 'package:solarex_flutter_demo/notification_widget.dart';

void main() => runApp(DataTransferApp());

class DataTransferApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Flutter data transfer demo",
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const DataTransferHomePage(title: "Flutter data transfer demo"),
    );
  }

}

class DataTransferHomePage extends StatelessWidget {
  final String title;

  const DataTransferHomePage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return const DefaultTabController(
        length: 3,
        child: Scaffold(
          body: TabBarView(
              physics: NeverScrollableScrollPhysics(),
              children: [
                CounterPage(),
                NotificationWidget(),
                DataTransferFirstPage()
              ]
          ),
          bottomNavigationBar: TabBar(
            tabs: [
              Tab(icon: Icon(Icons.home), text: "InheritedWidget",),
              Tab(icon: Icon(Icons.rss_feed), text: "Notification",),
              Tab(icon: Icon(Icons.perm_identity), text: "EventBus",)
            ],
            unselectedLabelColor: Colors.blueGrey,
            labelColor: Colors.blue,
            indicatorColor: Colors.red,
            indicatorSize: TabBarIndicatorSize.label,
          ),
        )
    );
  }

}