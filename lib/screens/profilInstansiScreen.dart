import 'package:flutter/material.dart';
import 'package:dent_is_pasien/components/buttonGradient.dart';
import 'error.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'package:cookie_jar/cookie_jar.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:convert';

class ProfilInstansiScreen extends StatefulWidget {
  @override
  _ProfilInstansiScreenState createState() => _ProfilInstansiScreenState();
}

class _ProfilInstansiScreenState extends State<ProfilInstansiScreen> {
  Map<String,dynamic> data = {};
  double height = 0;
  List<Widget> dokter = [];

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
      List<Cookie> cookies = (cj.loadForRequest(Uri.parse("http://api-dentis.herokuapp.com/pasien-login/")));
      var response =  await http.get(
        'http://api-dentis.herokuapp.com/instansi/',
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
      this.data=body[0];
      print(this.data["nama"]);
      var responseDokter =  await http.get(
        'http://api-dentis.herokuapp.com/dokter/',
        headers: {
          "Cookie":cookies[1].name+"="+cookies[1].value
        },
      );
      print(responseDokter.body);
      var bodyDokter = json.decode(responseDokter.body);
      dokter=[];
      for (Map<String,dynamic> a in bodyDokter){
        dokter.addAll(
          [
            Text("- ${a["nama"]}")
          ]
        );
      }
      setState(() {
        this.height=0;
      });
    } catch (e) {
      error();
    }
    
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    load();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        title: Text("Profil Instansi",style: TextStyle(color:Colors.black54),),
      ),
      body: Stack(
        children: <Widget>[
          ListView(
            padding: EdgeInsets.all(20),
            children: <Widget>[
              Column(
                children: <Widget>[
                  Text(data["nama"]!=null?data["nama"]:"",style: TextStyle(fontSize: 24,fontWeight: FontWeight.w900),),
                  Container(height: 15,),
                  Container(
                    width: 308,
                    height: 205,
                    decoration: BoxDecoration(
                      color: Colors.grey
                    ),
                  ),
                  Container(height: 15,),
                  ButtonGradient(
                    height: 40,
                    width: 200,
                    onTap: ()async{
                      await launch(
                            "tel:081284640615"
                          );
                    },
                    text: "emergency call",
                  ),
                  Container(height: 15,),
                  Divider(color: Colors.blue,),
                  Container(height: 15,),
                  Column(
                    children: <Widget>[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("Alamat",style: TextStyle(fontWeight: FontWeight.bold),),
                          Expanded(child: Container(),),
                          Container(
                            width: 200,
                            child: Text(data["alamat"]!=null?data["alamat"]:"")
                          )
                        ],
                      ),
                      Container(height:15),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("Email",style: TextStyle(fontWeight: FontWeight.bold),),
                          Expanded(child: Container(),),
                          Container(
                            width: 200,
                            child: Text(data["emailInstansi"]!=null?data["emailInstansi"]:"")
                          )
                        ],
                      ),
                      Container(height:15),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("Waktu Layanan",style: TextStyle(fontWeight: FontWeight.bold),),
                          Expanded(child: Container(),),
                          Container(
                            width: 200,
                            child: Text(data["waktuLayanan"]!=null?data["waktuLayanan"]:"")
                          )
                        ],
                      ),
                      Container(height:15),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("Telepon",style: TextStyle(fontWeight: FontWeight.bold),),
                          Expanded(child: Container(),),
                          Container(
                            width: 200,
                            child: Text(data["noTelepon"]!=null?data["noTelepon"]:"")
                          )
                        ],
                      ),
                    ],
                  ),
                  Container(height: 15,),
                  Divider(color: Colors.blue,),
                  Container(height: 15,),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text("Layanan",style: TextStyle(fontWeight: FontWeight.bold),),
                  ),
                  Container(height: 15,),
                  Container(
                    width: MediaQuery.of(context).size.width-20,
                    alignment: Alignment.centerLeft,
                    child: Text(data["layanan"]!=null?data["layanan"]:""),
                  ),
                  Container(height: 15,),
                  Divider(color: Colors.blue,),
                  Container(height: 15,),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text("Dokter",style: TextStyle(fontWeight: FontWeight.bold),),
                  ),
                  Container(height: 15,),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: dokter,
                    )
                  ),
                ],
              )
            ],
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
      )
    );
  }
}