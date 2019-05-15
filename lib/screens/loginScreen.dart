import 'package:flutter/material.dart';
import 'package:dent_is_pasien/components/buttonGradient.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'initialScreen.dart';
import 'package:flutter/services.dart';
import 'mainTabsScreen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  double opacity=0.0;
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  String alert = "";
  bool showPassword=false;

  login() async{
    setState(() {
      opacity=MediaQuery.of(context).size.height;
    });
    var response =  await http.post(
      'http://dent-is.herokuapp.com/pasien-login/',
      headers: {
        "Content-Type":"application/x-www-form-urlencoded",
      },
      body: {
        "username":usernameController.text,
        "password":passwordController.text
      }
    );
    if (response.statusCode==200){
      Directory tempDir = await getTemporaryDirectory();
      String tempPath = tempDir.path;
      
      PersistCookieJar cj=new PersistCookieJar(dir:tempPath);
      cj.delete(Uri.parse("http://dent-is.herokuapp.com/pasien-login/"));
      print(response.headers["set-cookie"].split(",")[0].split(";")[0].split("=")[1]);
      Cookie csrf = Cookie(response.headers["set-cookie"].split(",")[0].split(";")[0].split("=")[0],response.headers["set-cookie"].split(",")[0].split(";")[0].split("=")[1]);
      Cookie sessionid = Cookie(response.headers["set-cookie"].split(",")[2].split(";")[0].split("=")[0],response.headers["set-cookie"].split(",")[2].split(";")[0].split("=")[1]);
      cj.saveFromResponse(Uri.parse("http://dent-is.herokuapp.com/pasien-login/"), [csrf,sessionid]);
      List<Cookie> cookies = (cj.loadForRequest(Uri.parse("http://dent-is.herokuapp.com/pasien-login/")));
      print("this is the cookies: ${cookies}");
      
      Navigator.pushReplacement(
          context, 
          new MaterialPageRoute(
              builder: (BuildContext context) =>
              new MainTabsScreen()
            )
          );

      setState(() {
        alert="";
      });
    }
    else{
      setState(() {
        alert="Username atau password salah";
      });
    }
    setState(() {
      opacity=0.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: (){
        Navigator.of(context).pushReplacement(new MaterialPageRoute(
              builder: (BuildContext context) =>
              new InitialScreen()
            )
          );
      },
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
        body: Stack(
          children: <Widget>[
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                FocusScope.of(context).requestFocus(new FocusNode());
              },
              child://ListView(
                //children: [
                  Container(
                    height: MediaQuery.of(context).size.height,
                    child:Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(bottom: 10.0),
                                height: 100.0,
                                width: 100.0,
                                decoration: BoxDecoration(image: DecorationImage(fit: BoxFit.contain,image: AssetImage("assets/logo.png"))),
                              ),
                              Container(
                                margin: EdgeInsets.only(bottom: 15),
                                width: 250,
                                child: TextField(
                                  decoration: InputDecoration(
                                    labelText: "username",
                                  ),
                                  controller: usernameController,
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(bottom: 10),
                                    width: 200,
                                    child: TextField(
                                      decoration: InputDecoration(
                                        labelText: "password"
                                      ),
                                      controller: passwordController,
                                      obscureText: !this.showPassword
                                    ),
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.visibility),
                                    onPressed: (){
                                      setState(() {
                                        if (this.showPassword){
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
                              Text("${alert}",style: TextStyle(color: Colors.red, fontSize: 12),),
                              Container(height:30),
                              ButtonGradient(height: 48,width: 100,text: "Masuk",onTap:
                                login
                              ),
                            ],
                          ),
                        ),
                        Stack(
                          children: <Widget>[
                            Image.asset("assets/gradient-footer.png"),
                          ],
                        ),
                      ],
                    ),
                  ),
                //]
              //),
            ),
            new Opacity(
              opacity: 0.5,
              child: new Container(
                color: Colors.black,
                width: MediaQuery.of(context).size.width,
                height: opacity,
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
              height: opacity,
            )
          ],
        )
      )
    );
  }
}