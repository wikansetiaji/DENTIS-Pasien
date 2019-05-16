import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'gigi5.dart';
import 'gigi4.dart';
import 'package:dent_is_pasien/components/buttonGradient.dart';
import 'detailGigi5.dart';
import 'detailGigi4.dart';
import 'jenisPenanganan.dart';

class Odontogram extends StatefulWidget {
  Map<String,dynamic> data;

  Odontogram({
    @required this.data
  });

  @override
  _OdontogramState createState() => _OdontogramState();
}

class _OdontogramState extends State<Odontogram> {
  Map<String, Widget>gigi={};
  Map<String,dynamic> ohisData={};


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    for (Map<String,dynamic> a in widget.data["gigi_set"]){
      ohisData.addAll({a["kode"]:a});
    }
    print(ohisData);
  }

  openDetail(Map<String,dynamic> gigi) async{
    List<String> ohis=["11","16","26","31","36","46"];
    if (int.parse(gigi["kode"].substring(1))<4){
      if (ohis.contains(gigi["kode"])){
        await Navigator.push(
          context, 
          new MaterialPageRoute(
              builder: (BuildContext context) =>
                new DetailGigi4(ohisData:ohisData,ohis:true, code:gigi["kode"], conditions: gigi,)
              )
          );
        
      }
      else{
        await Navigator.push(
          context, 
          new MaterialPageRoute(
              builder: (BuildContext context) =>
                new DetailGigi4(ohis:false, code:gigi["kode"], conditions: gigi,)
              )
          );
      }
    }
    else{
      if (ohis.contains(gigi["kode"])){
        await Navigator.push(
          context, 
          new MaterialPageRoute(
              builder: (BuildContext context) =>
                new DetailGigi5(ohisData:ohisData,ohis:true, code:gigi["kode"], conditions: gigi,)
              )
          );
      }
      else{
        await Navigator.push(
          context, 
          new MaterialPageRoute(
              builder: (BuildContext context) =>
                new DetailGigi5(ohis:false, code:gigi["kode"], conditions: gigi,)
              )
          );
      }
    }
    setState(() {
      resetGigiDisplay();
    });
  }

  resetGigiDisplay(){
    gigi={};
    List<String> ohis=["11","16","26","31","36","46"];
    for (var gigi in widget.data["gigi_set"]){
      if (int.parse(gigi["kode"].substring(1))<4){
        int sum = 0;
        sum+=gigi["d"]+gigi["l"]+gigi["m"]+gigi["v"];
        if (sum==0){
          if (ohis.contains(gigi["kode"])){
            this.gigi.addAll({gigi["kode"]:Gigi4(ohis:true, code:gigi["kode"], onTap: (){openDetail(gigi);}, selected: false,)});
          }
          else{
            this.gigi.addAll({gigi["kode"]:Gigi4(ohis:false, code:gigi["kode"], onTap: (){openDetail(gigi);}, selected: false,)});
          }
        }
        else{
          if (ohis.contains(gigi["kode"])){
            this.gigi.addAll({gigi["kode"]:Gigi4(ohis:true, code:gigi["kode"], onTap: (){openDetail(gigi);}, selected: true,)});
          }
          else{
            this.gigi.addAll({gigi["kode"]:Gigi4(ohis:false, code:gigi["kode"], onTap: (){openDetail(gigi);}, selected: true,)});
          }
        }
      }
      else{
        int sum = 0;
        sum+=gigi["d"]+gigi["l"]+gigi["o"]+gigi["m"]+gigi["v"];
        if (sum==0){
          if (ohis.contains(gigi["kode"])){
            this.gigi.addAll({gigi["kode"]:Gigi5(ohis:true,code:gigi["kode"], onTap:(){openDetail(gigi);}, selected: false,)});
          }
          else{
            this.gigi.addAll({gigi["kode"]:Gigi5(ohis:false,code:gigi["kode"], onTap:(){openDetail(gigi);}, selected: false,)});
          }
        }
        else{
          if (ohis.contains(gigi["kode"])){
            this.gigi.addAll({gigi["kode"]:Gigi5(ohis:true,code:gigi["kode"], onTap: (){openDetail(gigi);}, selected: true,)});
          }
          else{
            this.gigi.addAll({gigi["kode"]:Gigi5(ohis:false,code:gigi["kode"], onTap: (){openDetail(gigi);}, selected: true,)});
          }
        }
      }
    }
  }

  @override
  void didChangeDependencies() {
    resetGigiDisplay();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: (){
        Navigator.of(context).pop(widget.data);
        SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            color: Colors.black,
            icon: Icon(Icons.arrow_back_ios),
            onPressed: (){
              SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
              Navigator.of(context).pop(widget.data);
            },
          ),
          centerTitle: true,
          title: Text("DENT-IS",style: TextStyle(color:Colors.black54),),
        ),
        body: ListView(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(height:12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        gigi["18"],
                        gigi["17"],
                        gigi["16"],
                        gigi["15"],
                        gigi["14"],
                        gigi["13"],
                        gigi["12"],
                        gigi["11"],
                      ]
                    ),
                    Container(width: 12,),
                    Row(
                      children: <Widget>[
                        gigi["21"],
                        gigi["22"],
                        gigi["23"],
                        gigi["24"],
                        gigi["25"],
                        gigi["26"],
                        gigi["27"],
                        gigi["28"],
                      ]
                    ),
                  ],
                ),
                Container(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        gigi["55"],
                        gigi["54"],
                        gigi["53"],
                        gigi["52"],
                        gigi["51"],
                      ]
                    ),
                    Container(width: 12,),
                    Row(
                      children: <Widget>[
                        gigi["61"],
                        gigi["62"],
                        gigi["63"],
                        gigi["64"],
                        gigi["65"],
                      ]
                    ),
                  ],
                ),
                Container(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        gigi["85"],
                        gigi["84"],
                        gigi["83"],
                        gigi["82"],
                        gigi["81"],
                      ]
                    ),
                    Container(width: 12,),
                    Row(
                      children: <Widget>[
                        gigi["71"],
                        gigi["72"],
                        gigi["73"],
                        gigi["74"],
                        gigi["75"],
                      ]
                    ),
                  ],
                ),
                Container(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        gigi["48"],
                        gigi["47"],
                        gigi["46"],
                        gigi["45"],
                        gigi["44"],
                        gigi["43"],
                        gigi["42"],
                        gigi["41"],
                      ]
                    ),
                    Container(width: 12,),
                    Row(
                      children: <Widget>[
                        gigi["31"],
                        gigi["32"],
                        gigi["33"],
                        gigi["34"],
                        gigi["35"],
                        gigi["36"],
                        gigi["37"],
                        gigi["38"],
                      ]
                    ),
                  ],
                ),
                Container(height: 6,),
                ButtonGradient(
                  height: 40,
                  width: 130,
                  text: "Lanjut",
                  onTap: (){
                    widget.data.addAll({"ohis":ohisData});
                    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
                    Navigator.of(context).push(
                      new MaterialPageRoute(
                        builder: (BuildContext context) =>
                          new JenisPenanganan(data: widget.data,)
                        )
                    );
                  },
                )
              ],
            )
          ],
        ),
      )
    );
  }
}