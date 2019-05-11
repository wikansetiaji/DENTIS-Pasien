import 'package:flutter/material.dart';
import 'package:dent_is_pasien/components/buttonGradient.dart';

class UploadFoto extends StatefulWidget {
  final Map<String,dynamic> data;

  UploadFoto({
    @required this.data
  });
  
  @override
  _UploadFotoState createState() => _UploadFotoState();
}

class _UploadFotoState extends State<UploadFoto> {
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
        title: Text("DENT-IS",style: TextStyle(color:Colors.black54),),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/wallpapers/wallpaper2.png"),
            fit: BoxFit.cover
          )
        ),
        child: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                Container(height: 28,),
                Text(
                  "Foto",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 40
                  ),
                ),
                Container(
                  height: 54,
                ),
                Container(
                  height: 300,
                  width: 300,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    image: DecorationImage(
                      image: NetworkImage(
                        widget.data["fotorontgen_set"].length!=0?"http://api-dentis.herokuapp.com${widget.data["fotorontgen_set"][0]["foto"]}":""
                      ),
                      fit: BoxFit.fitWidth
                    )
                  ),
                ),
                Container(height:20),
              ]
            )
          ]
        )
      )
    );
  }
}