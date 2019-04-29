import 'package:flutter/material.dart';
import 'package:dent_is_pasien/components/buttonGradient.dart';
import 'loginScreen.dart';
import 'signUpScreen.dart';

class InitialScreen extends StatefulWidget {
  InitialScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _InitialScreenState createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(bottom: 30.0),
                    height: 100.0,
                    width: 100.0,
                    decoration: BoxDecoration(image: DecorationImage(fit: BoxFit.contain,image: AssetImage("assets/logo.png"))),
                  ),
                  ButtonGradient(
                    height: 48,
                    width: 200,
                    text: "Masuk",
                    onTap: (){
                      Navigator.pushReplacement(
                      context, 
                      new MaterialPageRoute(
                          builder: (BuildContext context) =>
                          new LoginScreen()
                        )
                      );
                    },
                  ),
                  Container(height: 61.0,),
                  Text("Belum punya akun?"),
                  ButtonGradient(
                    height: 48,
                    width: 200,
                    text: "Buat Akun",
                    onTap: (){
                      Navigator.pushReplacement(
                      context, 
                      new MaterialPageRoute(
                          builder: (BuildContext context) =>
                          new SignUpScreen()
                        )
                      );
                    },
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
    );
  }
}
