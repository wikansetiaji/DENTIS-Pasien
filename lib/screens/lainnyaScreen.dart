import 'package:flutter/material.dart';
import 'faqScreen.dart';
import 'profilInstansiScreen.dart';

class LainnyaScreen extends StatefulWidget {
  @override
  _LainnyaScreenState createState() => _LainnyaScreenState();
}

class _LainnyaScreenState extends State<LainnyaScreen> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Divider(),
        ListTile(
          onTap: (){
            Navigator.of(context).push(
              new MaterialPageRoute(
                  builder: (BuildContext context) =>
                  new FAQScreen()
                )
              );
          },
          leading: Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/faqs.png')
              )
            ),
          ),
          title: Text("FAQ / Bantuan"),
          trailing: Icon(Icons.navigate_next),
        ),
        Divider(),
        ListTile(
          onTap: (){
            Navigator.of(context).push(
              new MaterialPageRoute(
                  builder: (BuildContext context) =>
                  new ProfilInstansiScreen()
                )
              );
          },
          leading: Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/instansi.png')
              )
            ),
          ),
          title: Text("Profil Instansi & Layanannya"),
          trailing: Icon(Icons.navigate_next),
        ),
        Divider(),
      ],
    );
  }
}