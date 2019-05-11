import 'package:flutter/material.dart';
import 'package:dent_is_pasien/components/buttonGradient.dart';
import 'package:http/http.dart' as http;
import 'package:cookie_jar/cookie_jar.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:convert';
import 'package:dent_is_pasien/screens/error.dart';
import 'editProfileScreen.dart';

class ProfilScreen extends StatefulWidget {
  @override
  _ProfilScreenState createState() => _ProfilScreenState();
}

class _ProfilScreenState extends State<ProfilScreen> {
  Map<String,dynamic> data = {};
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
      List<Cookie> cookies = (cj.loadForRequest(Uri.parse("http://api-dentis.herokuapp.com/pasien-login/")));
      var response =  await http.get(
        'http://api-dentis.herokuapp.com/pasien-profile/',
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
        this.data=body;
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
    return Stack(
      children: <Widget>[
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
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
                  children: <Widget>[
                    Text(data["nama"]!=null?data["nama"]:"",style: TextStyle(fontSize: 24,fontWeight: FontWeight.w900)),
                    Container(height: 18,),
                    ButtonGradient(
                      height: 40,
                      width: 131,
                      onTap: (){
                        Navigator.push(
                            context, 
                            new MaterialPageRoute(
                                builder: (BuildContext context) =>
                                new EditProfileScreen(
                                  id:data["id"],
                                  alamat: data["alamat"]!=null?data["alamat"]:"",
                                  email: data["user"]!=null?data["user"]["email"]:"",
                                  jenisKelamin: data["jenisKelamin"]!=null?data["jenisKelamin"]:"",
                                  nama: data["nama"],
                                  noHp: data["no_hp"]!=null?data["no_hp"]:"",
                                  tanggalLahir: data["tanggalLahir"]!=null?data["tanggalLahir"]:"",
                                  username: data["user"]!=null?data["user"]["username"]:"",
                                )
                              )
                            );
                      },
                      text: "Ubah Profil",
                    )
                  ],
                ),
              )
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
        ),
      ],
    );
  }
}