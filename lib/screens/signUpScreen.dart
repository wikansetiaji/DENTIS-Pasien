import 'package:flutter/material.dart';
import 'package:dent_is_pasien/components/buttonGradient.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:cookie_jar/cookie_jar.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:dent_is_pasien/screens/error.dart';
import 'initialScreen.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  double height=0;
  bool showPassword = false;

  String jenisKelamin="l";
  TextEditingController namaController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController noHpController = TextEditingController();
  TextEditingController tanggalLahirController = TextEditingController();
  TextEditingController nomorTeleponController = TextEditingController();
  TextEditingController alamatController = TextEditingController();
  String alertNama="";
  String alertUsername="";
  String alertPassword="";
  String alertEmail="";
  String alertNomorTelepon="";
  String alertTanggalLahir="";
  String alertAlamat="";
  DateTime tanggalLahir;

  error()async{
    await Navigator.of(context).pushReplacement(
      new MaterialPageRoute(
          builder: (BuildContext context) =>
          new ErrorScreen()
        )
      );
  }

  bool isNumeric(String s) {
    if(s == null) {
      return false;
    }
    return double.parse(s, (e) => null) != null;
  }

  submit()async{
    try{
    setState(() {
      alertNama="";
      alertUsername="";
      alertPassword="";
      alertEmail="";
      alertNomorTelepon="";
      alertTanggalLahir="";
      alertAlamat="";
    });
    bool pass = true;
    String p = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    RegExp regExp = new RegExp(p);
    if (namaController.text==""){
      pass= false;
      setState(() {
        alertNama="Wajib diisi";
      });
    }
    if(usernameController.text==""){
      pass= false;
      setState(() {
        alertUsername="Wajib diisi";
      });
    }
    if(passwordController.text.length<6){
      pass= false;
      setState(() {
        alertPassword="Minimal 6 character";
      });
    }
    if(passwordController.text==""){
      pass= false;
      setState(() {
        alertPassword="Wajib diisi";
      });
    }
    if(!regExp.hasMatch(emailController.text)){
      pass= false;
      setState(() {
        alertEmail="Format Salah";
      });
    }
    if(emailController.text==""){
      pass= false;
      setState(() {
        alertEmail="Wajib diisi";
      });
    }
    if (pass){
      setState(() {
        height=MediaQuery.of(context).size.height;
      });
      Map<String,dynamic> bodyJson;
      if (tanggalLahirController.text==""){
        bodyJson = {
          "nama":namaController.text,
          "username":usernameController.text,
          "password":passwordController.text,
          "email":emailController.text,
          "no_hp":noHpController.text,
          "jenisKelamin":jenisKelamin,
          "alamat":alamatController.text,
        };
      }
      else{
        bodyJson = {
          "nama":namaController.text,
          "username":usernameController.text,
          "password":passwordController.text,
          "email":emailController.text,
          "no_hp":noHpController.text,
          "jenisKelamin":jenisKelamin,
          "alamat":alamatController.text,
          "tanggalLahir":tanggalLahirController.text
        };
      }
      var response =  await http.post(
        'http://dent-is.herokuapp.com/pasien/',
        body: bodyJson
      );
      if (response.statusCode!=200 && response.statusCode!=201){
        print(response.body);
        error();
      }
      var body = json.decode(response.body);
      print(body);
      setState(() {
        height=0;
      });
      Fluttertoast.showToast(
        msg: "Pasien berhasil ditambah",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        backgroundColor: Colors.black45,
        textColor: Colors.white,
        fontSize: 16.0
      );
      Navigator.of(context).pushReplacement(new MaterialPageRoute(
              builder: (BuildContext context) =>
              new InitialScreen()
            )
          );
    }
    }
    catch(e){
      error();
    }
    
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
        Navigator.of(context).pushReplacement(new MaterialPageRoute(
              builder: (BuildContext context) =>
              new InitialScreen()
            )
          );
              
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
                  Navigator.of(context).pushReplacement(new MaterialPageRoute(
              builder: (BuildContext context) =>
              new InitialScreen()
            )
          );
                },
              ),
              centerTitle: true,
              title: Text("Buat Akun",style: TextStyle(color:Colors.black54),),
            ),
            body: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                FocusScope.of(context).requestFocus(new FocusNode());
              },
              child:ListView(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(5),
                          alignment: Alignment.centerLeft,
                          child: Text(" ${alertNama}",style: TextStyle(color: Colors.red),),
                        ),
                        Container(
                          height: 60,
                          width: 325,
                          child: new TextField(
                            controller: namaController,
                            decoration: new InputDecoration(
                              border: new OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                                borderSide: new BorderSide(color: Colors.blue)),
                              hintText: 'Nama Lengkap*',
                              labelText: 'Nama Lengkap*',
                            ),
                          ),
                        ),
                        Container(height: 10,),
                        Container(
                          padding: EdgeInsets.all(5),
                          alignment: Alignment.centerLeft,
                          child: Text(" ${alertUsername}",style: TextStyle(color: Colors.red),),
                        ),
                        Container(
                          height: 60,
                          width: 325,
                          child: new TextField(
                            controller: usernameController,
                            decoration: new InputDecoration(
                              border: new OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                                borderSide: new BorderSide(color: Colors.blue)),
                              hintText: 'Username*',
                              labelText: 'Username*',
                            ),
                          ),
                        ),
                        Container(height: 10,),
                        Container(
                          padding: EdgeInsets.all(5),
                          alignment: Alignment.centerLeft,
                          child: Text(" ${alertPassword}",style: TextStyle(color: Colors.red),),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              height: 60,
                              width: 275,
                              child: new TextField(
                                controller: passwordController,
                                obscureText: !this.showPassword,
                                decoration: new InputDecoration(
                                  border: new OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                    borderSide: new BorderSide(color: Colors.blue)),
                                  hintText: 'Password*',
                                  labelText: 'Password*',
                                ),
                              ),
                            ),
                            IconButton(
                              icon: Icon(Icons.visibility),
                              onPressed: (){
                                setState(() {
                                  if(this.showPassword){
                                    this.showPassword=false;
                                  }
                                  else{
                                    this.showPassword=true;
                                  }
                                });
                              },
                            )
                          ],
                        ),
                        Container(height: 10,),
                        Container(
                          padding: EdgeInsets.all(5),
                          alignment: Alignment.centerLeft,
                          child: Text(" ${alertEmail}",style: TextStyle(color: Colors.red),),
                        ),
                        Container(
                          height: 60,
                          width: 325,
                          child: new TextField(
                            controller: emailController,
                            decoration: new InputDecoration(
                              border: new OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                                borderSide: new BorderSide(color: Colors.blue)),
                              hintText: 'Email*',
                              labelText: 'Email*',
                            ),
                          ),
                        ),
                        
                        Container(height: 50,),
                        ButtonGradient(
                          height: 40,
                          width: 130,
                          text: "Simpan",
                          onTap: (){
                            submit();
                          },
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
          ),
          new Opacity(
            opacity: 0.5,
            child: new Container(
              color: Colors.black,
              width: MediaQuery.of(context).size.width,
              height: height,
            ),
          ),
          new Container(
            child: new Center(
              child:new Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircularProgressIndicator(),
                ],
              )
            ),
            height: height,
          )
        ],
      )
    );
  }
}