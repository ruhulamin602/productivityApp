import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:productivity_timer/screens/countdowntimer.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
      .then((_) {
    runApp(new MyApp());
  });
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Work Timer',
      theme: ThemeData(
        primarySwatch: Colors.cyan,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        splashColor: Colors.amberAccent,
      ),
      home: MyWorkTimer(title: 'My Work Timer'),
    );
  }
}
