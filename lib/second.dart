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
        '/': (context) => SecondPage(),
      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: HomePage(),
    );
  }
}

class SecondPage extends StatelessWidget {
  static const platform =
      const MethodChannel('com.souvikbiswas.pose_test/pose');

  Future<void> _getAccuracy() async {
    String poseName = '';
    try {
      await platform.invokeMethod('getAccuracy');
      final String result = await platform.invokeMethod('getAccuracy');
      print("FLUTTER ACCURACY: $result");
    } on PlatformException catch (e) {
      poseName = "Failed to get pose name: '${e.message}'.";
      print(poseName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
          child: ElevatedButton(
        onPressed: _getAccuracy,
        child: Text("get accuracy"),
      )),
    );
  }
}
