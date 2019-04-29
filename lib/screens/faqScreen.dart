import 'package:flutter/material.dart';
import 'package:dent_is_pasien/components/buttonGradient.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'package:cookie_jar/cookie_jar.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:convert';
import 'package:dent_is_pasien/screens/error.dart';


class FAQScreen extends StatefulWidget {
  @override
  _FAQScreenState createState() => _FAQScreenState();
}

class _FAQScreenState extends State<FAQScreen> {
  double height=0;
  List<Widget> body=[];

  error()async{
    await Navigator.of(context).pushReplacement(
      new MaterialPageRoute(
          builder: (BuildContext context) =>
          new ErrorScreen()
        )
      );
  }

  load()async{
    try {
      setState(() {
        this.height=MediaQuery.of(context).size.height;
      });
      Directory tempDir = await getTemporaryDirectory();
      String tempPath = tempDir.path;
      
      PersistCookieJar cj=new PersistCookieJar(dir:tempPath);
      List<Cookie> cookies = (cj.loadForRequest(Uri.parse("http://10.0.2.2:8000/pasien-login/")));
      var response =  await http.get(
        'http://10.0.2.2:8000/faqs/',
        headers: {
          "Cookie":cookies[1].name+"="+cookies[1].value
        },
      );
      if(response.statusCode!=200 && response.statusCode!=201){
        await error();
        setState(() {
          height=0;
        });
        return;
      }
      var body = json.decode(response.body);
      setState(() {
        this.height=0;
      });
      this.body=[];
      for (var a in body){
        this.body.addAll(
          [
            Container(
              margin: EdgeInsets.all(15),
              padding: EdgeInsets.all(15),
              width: 330,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                color: Colors.white,
                border: Border.all(
                  color: Theme.of(context).accentColor,
                  width: 2.0
                )
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                        width: 245,
                        child: Text(a["question"], style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14),),
                      ),
                    ],
                  ),
                  Container(height: 10,),
                  Text(a["answer"], style: TextStyle(fontSize: 12),)
                ],
              )
            ),
          ]
        );
      }
    } catch (e) {
      error();
    }
    
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    load();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            leading: IconButton(
              color: Colors.black,
              icon: Icon(Icons.arrow_back_ios),
              onPressed: (){
                Navigator.of(context).pop();
              },
            ),
            centerTitle: true,
            title: Text("FAQ / Bantuan",style: TextStyle(color:Colors.black54),),
          ),
          body: ListView(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Container(height: 33,),
                  Column(
                    children: this.body,
                  ),
                  Container(height: 33,),
                  Text(
                    "Kontak kami",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  Container(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.mail_outline),
                        color: Colors.black,
                        onPressed: ()async{
                          await launch(
                            "mailto:help@dentis.com?subject=QNA Help"
                          );
                        },
                      ),
                      Text("help@dentis.com")
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.phone),
                        color: Colors.black,
                        onPressed: ()async{
                          await launch(
                            "tel:081229079453"
                          );
                        },
                      ),
                      Text("081229079453")
                    ],
                  )
                ],
              ),
            ],
          )
        ),
        Container(
          height: this.height,
          width: MediaQuery.of(context).size.width,
          color: Colors.white,
        ),
        Container(
          height: this.height,
          width: MediaQuery.of(context).size.width,
          child: Center(
            child: CircularProgressIndicator(),
          ),
        )
      ],
    );
  }
}