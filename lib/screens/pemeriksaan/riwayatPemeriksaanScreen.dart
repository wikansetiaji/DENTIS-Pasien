import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'package:cookie_jar/cookie_jar.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:convert';
import 'package:dent_is_pasien/screens/error.dart';
import 'detailPemeriksaanScreen.dart';
import 'package:dent_is_pasien/utils/utils.dart';

class RiwayatPemeriksaanScreen extends StatefulWidget {
  @override
  _RiwayatPemeriksaanScreenState createState() => _RiwayatPemeriksaanScreenState();
}

class _RiwayatPemeriksaanScreenState extends State<RiwayatPemeriksaanScreen> {
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
        'http://10.0.2.2:8000/pasien-rekam-medis/',
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
            InkWell(
              onTap: (){
                Navigator.push(
                  context, 
                  new MaterialPageRoute(
                      builder: (BuildContext context) =>
                      new DetailPemeriksaanScreen(data: a,)
                    )
                  );
              },
              child: Container(
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
                child: Row(
                  children: <Widget>[
                    Container(
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        color: Colors.grey,
                        image: DecorationImage(
                          image: NetworkImage(
                            a["fotorontgen_set"].length!=0?"http://10.0.2.2:8000${a["fotorontgen_set"][0]["foto"]}":""
                          ),
                          fit: BoxFit.fitWidth
                        )
                      ),
                    ),
                    Container(
                      width: 15,
                    ),
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            child: Text("${Util.convertToDateString(a["created_at"].split("T")[0])}", style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                          ),
                          Container(height: 10,),
                          Container(
                            child: Text("${a["dokter"]["nama"]}", style: TextStyle(fontSize: 12),)
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(),
                    ),
                    IconButton(
                      icon: Icon(Icons.navigate_next),
                      onPressed: (){
                      },
                    )
                  ],
                ),
              )
            ),
          ]
        );
      }
    } catch (e) {
      print(e);
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
    return WillPopScope(
      onWillPop: ()async{
        Navigator.of(context).pop();
      },
      child:Stack(
        children: <Widget>[
          Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              leading: IconButton(
                color: Colors.black,
                icon: Icon(Icons.arrow_back_ios),
                onPressed: ()async{
                  Navigator.of(context).pop();
                },
              ),
              centerTitle: true,
              title: Text("Riwayat Pemeriksaan",style: TextStyle(color:Colors.black54),),
            ),
            body: ListView(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
              children: this.body,
            ),
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
        ]
      )
    );
  }
}