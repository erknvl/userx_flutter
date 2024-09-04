import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:userx_flutter/userx_flutter.dart';
import 'package:userx_flutter/attributes/attribute.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String? _platformVersion = 'Unknown';

  @override
  void initState() {
    super.initState();
    initPlatformState();

    UserX.start("YOUR_API_KEY");
    UserX.addEvent("TestEvent", {"AppState": "Started"});
    UserX.setUserId("TestUserId");

    UserX.applyUserAttributes([
      Attribute.bool("logged_in", value: true),
      Attribute.string("user_name", value: "j2001"),
      Attribute.int("age", value: 25),
      Attribute.double("weight", value: 77),
      Attribute.counter("launch_count", value: 3),
    ]);

    UserX.applyUserAttributes([
      Attribute.increasedCounter("launch_count"),
    ]);
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String? platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      platformVersion = await UserX.platformVersion;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Text('Running on: $_platformVersion\n'),
        ),
      ),
    );
  }
}
