import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/second': (context) => SecondPage(),
      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String detectedPose = 'unknown';
  static const platform =
      const MethodChannel('com.souvikbiswas.pose_test/pose');

  // final _eventChannel = const EventChannel('platform_channel_events/pose');

  Future<void> _getPoseName() async {
    String poseName;
    try {
      await platform.invokeMethod('getPoseName');
      // final String result = await platform.invokeMethod('getPoseName');
      // poseName = result;
    } on PlatformException catch (e) {
      poseName = "Failed to get pose name: '${e.message}'.";
    }

    // setState(() {
    //   detectedPose = poseName;
    // });
  }

  _navigateSecond() {
    Navigator.pushNamed(context, "/second");
  }

  @override
  Widget build(BuildContext context) {
    // final networkStream = _eventChannel
    //     .receiveBroadcastStream()
    //     .distinct()
    //     .map((dynamic event) => event as String);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Pose Test Native'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              child: Text('Get Pose Name'),
              onPressed: _getPoseName,
            ),
            // Text(detectedPose),
            // StreamBuilder<String>(
            //   initialData: 'unknown',
            //   stream: networkStream,
            //   builder: (context, snapshot) {
            //     final String poseName = snapshot.data ?? 'unknown';
            //     return Text(poseName);
            //   },
            // ),
          ],
        ),
      ),
    );

    // return Center(
    //   child: Column(
    //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //     children: [
    //       ElevatedButton(
    //         child: Text('Get Pose Name'),
    //         onPressed: _getPoseName,
    //       ),
    //     ],
    //   ),
    // );
  }
}

class SecondPage extends StatefulWidget {
  static const platform =
      const MethodChannel('com.souvikbiswas.pose_test/pose');

  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  String pose = '';
  String accuracy = '';

  Future<void> _getAccuracy() async {
    String poseName = '';
    try {
      await SecondPage.platform.invokeMethod('getAccuracy');
      final List<String> result =
          (await SecondPage.platform.invokeMethod('getAccuracy')).split('#');
      print("FLUTTER ACCURACY: $result");

      String newPose = result.first;
      String newAccuracy = result.last;

      setState(() {
        pose = newPose;
        accuracy = newAccuracy;
      });
    } on PlatformException catch (e) {
      poseName = "Failed to get pose name: '${e.message}'.";
      print(poseName);
    }
  }

  _startResultFetcher() {
    const oneSec = const Duration(seconds: 1);
    new Timer.periodic(oneSec, (Timer t) => _getAccuracy());
  }

  @override
  void initState() {
    super.initState();

    _startResultFetcher();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // ElevatedButton(
            //   onPressed: _getAccuracy,
            //   child: Text("get accuracy"),
            // ),
            SizedBox(height: 16.0),
            Text('$pose ($accuracy)'),
          ],
        ),
      ),
    );
  }
}
