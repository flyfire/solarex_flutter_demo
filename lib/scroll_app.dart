import 'package:flutter/material.dart';

void main() {
  runApp(const ScrollApp());
}

class ScrollApp extends StatelessWidget {
  const ScrollApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Colors.lightBlue[800]),
      home: const ScrollAppHomePage(title: "Scroll App"),
    );
  }
}

class ParallelWidget extends StatelessWidget {
  const ParallelWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          title: const Text("CustomScrollView Demo"),
          floating: true,
          flexibleSpace: Image.network(
            "https://media-cdn.tripadvisor.com/media/photo-s/13/98/8f/c2/great-wall-hiking-tours.jpg",
            fit: BoxFit.cover,),
          expandedHeight: 280,
        ),
        SliverList(delegate: SliverChildBuilderDelegate(
              (context, index) {
            return ListTile(title: Text("Item #$index"),);
          },
          childCount: 100,
        )),
      ],
    );
  }

}

class ScrollNotificationWidget extends StatelessWidget {
  const ScrollNotificationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Scroll Notification Demo",
      home: Scaffold(
        appBar: AppBar(title: const Text("ScrollController Demo"),),
        body: NotificationListener<ScrollNotification>(
          child: ListView.builder(
            itemBuilder: (context, index) =>
                ListTile(title: Text("Index: $index"),),
            itemCount: 100,
          ),
          onNotification: (scrollNotification) {
            if (scrollNotification is ScrollStartNotification) {
              print('scroll start');
            } else if (scrollNotification is ScrollUpdateNotification) {
              print('scroll update');
            } else if (scrollNotification is ScrollEndNotification) {
              print('scroll end');
            }
            return true;
          },
        ),
      ),
    );
  }

}

class ScrollControllerWidget extends StatefulWidget {
  const ScrollControllerWidget({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ScrollControllerState();
  }

}

class _ScrollControllerState extends State<ScrollControllerWidget> {
  late ScrollController _controller;
  bool isToTop = false;

  @override
  void initState() {
    _controller = ScrollController();
    _controller.addListener(() {
      if (_controller.offset > 1000) {
        setState(() {
          isToTop = true;
        });
      } else if (_controller.offset < 300) {
        setState(() {
          isToTop = false;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Scroll Controller Widget"),),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 40.0,
            child: ElevatedButton(onPressed: (
                isToTop ? () {
                  if (isToTop) {
                    _controller.animateTo(
                        .0, duration: const Duration(milliseconds: 200),
                        curve: Curves.ease);
                  }
                } : null
            ), child: const Text("Top")),
          ),
          Expanded(child:
            ListView.builder(
              itemBuilder: (context, index) => ListTile(title: Text("Index: $index"),),
              itemCount: 100,
              controller: _controller,
            )
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

}

class ScrollAppHomePage extends StatelessWidget {
  final String title;
  const ScrollAppHomePage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return const DefaultTabController(
        length: 3,
        child: Scaffold(
          body: TabBarView(children: [
            ParallelWidget(),
            ScrollNotificationWidget(),
            ScrollControllerWidget(),
          ]),
          bottomNavigationBar: TabBar(
            tabs: [
              Tab(icon: Icon(Icons.home), text: "视差",),
              Tab(icon: Icon(Icons.rss_feed), text: "Notification",),
              Tab(icon: Icon(Icons.perm_identity), text: "Controller",)
            ],
            unselectedLabelColor: Colors.blueGrey,
            labelColor: Colors.blue,
            indicatorSize: TabBarIndicatorSize.label,
            indicatorColor: Colors.red,
          ),
        ));
  }
  
}