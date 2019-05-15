import 'package:flutter/material.dart';
import 'initialScreen.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:convert';
import 'mainTabsScreen.dart';
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void load() async{
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;
    
    PersistCookieJar cj=new PersistCookieJar(dir:tempPath);
    List<Cookie> cookies = (cj.loadForRequest(Uri.parse("http://dent-is.herokuapp.com/pasien-login/")));
    await new Future.delayed(const Duration(seconds: 3));
    print("haha");
    if (cookies.length!=0){
      Navigator.pushReplacement(
        context, 
        new MaterialPageRoute(
          builder: (BuildContext context) =>
          new MainTabsScreen()
        )
      );
    }
    else{
      Navigator.pushReplacement(
        context, 
        new MaterialPageRoute(
          builder: (BuildContext context) =>
          new InitialScreen(title:"Login Screen")
        )
      );
    }
  }

  @override
  void initState() {
    super.initState();
    load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(image: AssetImage("assets/logo.png"),width: 125,height: 144.56,)
          ],
        ),
      ),
    );
  }
}