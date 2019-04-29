import 'package:flutter/material.dart';
import 'homeScreen.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:dent_is_pasien/screens/initialScreen.dart';
import 'lainnyaScreen.dart';
import 'profilScreen.dart';

class MainTabsScreen extends StatefulWidget {
  @override
  _MainTabsScreenState createState() => _MainTabsScreenState();
}

class _MainTabsScreenState extends State<MainTabsScreen> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    HomeScreen(),
    ProfilScreen(),
    LainnyaScreen()
  ];
  
  void onTabTapped(int index) {
   setState(() {
     _currentIndex = index;
   });
 }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text("DENT-IS",style: TextStyle(color:Colors.black54),),
        actions: <Widget>[
          PopupMenuButton<String>(
            icon: Icon(Icons.more_vert,color: Colors.black,),
            padding: EdgeInsets.zero,
            onSelected: (String a)async{
              Directory tempDir = await getTemporaryDirectory();
              String tempPath = tempDir.path;
              
              PersistCookieJar cj=new PersistCookieJar(dir:tempPath);
              cj.delete(Uri.parse("http://api-dentis.herokuapp.com/pasien-login/"));
              Navigator.pushReplacement(context, new MaterialPageRoute(
                builder: (BuildContext context) =>
                new InitialScreen()
              )
            );
            },
            itemBuilder: (BuildContext context) => <PopupMenuItem<String>>[
              PopupMenuItem<String>(
                value: "logout",
                child: const Text('Logout'),
              ),
            ],
          ),
        ],
      ),
     body: _children[_currentIndex], // new
     bottomNavigationBar: BottomNavigationBar(
       onTap: onTabTapped,
       currentIndex: _currentIndex, // new
       items: [
         new BottomNavigationBarItem(
           icon: Icon(Icons.home),
           title: Text('Beranda'),
         ),
         new BottomNavigationBarItem(
           icon: Icon(Icons.account_circle),
           title: Text('Profil'),
         ),
         new BottomNavigationBarItem(
           icon: Icon(Icons.more_horiz),
           title: Text('Lainnya')
         )
       ],
     ),
   );
  }
}