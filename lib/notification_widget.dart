import 'package:flutter/material.dart';

class CustomNotification extends Notification {
  final String msg;

  CustomNotification(this.msg);
}

class CustomChild extends StatelessWidget {
  const CustomChild({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () {
          CustomNotification("hi").dispatch(context);
        },
        child: const Text("Fire Notification"));
  }
}

class NotificationWidget extends StatefulWidget {
  const NotificationWidget({super.key});

  @override
  State<StatefulWidget> createState() {
    return _NotificationState();
  }
}

class _NotificationState extends State<NotificationWidget> {
  String _msg = "通知: ";

  @override
  Widget build(BuildContext context) {
    return NotificationListener<CustomNotification>(
        onNotification: (notification) {
          setState(() {
            _msg += "${notification.msg}  ";
          });
          return true;
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_msg),
            const CustomChild(),
          ],
        ));
  }
}
