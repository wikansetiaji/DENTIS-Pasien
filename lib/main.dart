import 'package:flutter/material.dart';
import 'screens/splashScreen.dart';
import 'package:flutter/services.dart';

void main() => SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
    .then((_) {
      runApp(new MyApp());
    });

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(),
      routes: <String, WidgetBuilder>{
       
      },
    );
  }
}