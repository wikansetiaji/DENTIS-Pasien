import 'package:flutter/material.dart';
import 'package:dent_is_pasien/components/buttonGradient.dart';
import 'odontogram.dart';
import 'package:flutter/services.dart';

class PemeriksaanAwal extends StatefulWidget {
  Map<String,dynamic> data;

  PemeriksaanAwal({
    @required this.data
  });

  @override
  _PemeriksaanAwalState createState() => _PemeriksaanAwalState();
}

class _PemeriksaanAwalState extends State<PemeriksaanAwal> {
  TextEditingController anamnesaController = TextEditingController();
  TextEditingController alergiController = TextEditingController();
  TextEditingController riwayatController = TextEditingController();
  TextEditingController tekananDarahController = TextEditingController();
  TextEditingController beratController = TextEditingController();
  TextEditingController tinggiController = TextEditingController();

  String alertAnamnesa="";
  String alertTekananDarah="";
  String alertBerat="";
  String alertTinggi="";

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    setState(() {
      
      anamnesaController.text =widget.data["anamnesa"].toString();
      alergiController.text = widget.data["alergi"].toString();
      riwayatController.text = widget.data["riwayat_penyakit"].toString();
      tekananDarahController.text = widget.data["tekanan_darah"].toString();
      beratController.text = widget.data["berat"].toString();
      tinggiController.text = widget.data["tinggi"].toString();

    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child:Scaffold(
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
          title: Text("Pemeriksaan Awal",style: TextStyle(color:Colors.black54),),
        ),
        body: 
        ListView(
          children: <Widget>[
            Center(
              child: Column(
                children: <Widget>[
                  Container(height: 28,),
                  Container(
                    height: 80,
                    width: 325,
                    child: new TextField(
                      enabled: false,
                      controller: anamnesaController,
                      maxLines: 5,
                      decoration: new InputDecoration(
                        border: new OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: new BorderSide(color: Colors.blue)),
                        hintText: 'Isi Anamnesis',
                        labelText: 'Anamnesis*',
                      ),
                    ),
                  ),
                  Container(
                    height: 44,
                  ),
                  Container(
                    height: 30,
                    child: Text(
                      "$alertAnamnesa",
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                  Container(
                    height: 80,
                    width: 325,
                    child: new TextField(
                      enabled: false,
                      controller: alergiController,
                      decoration: new InputDecoration(
                        border: new OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: new BorderSide(color: Colors.blue)),
                        hintText: 'Alergi',
                        labelText: 'Alergi',
                      ),
                    ),
                  ),
                  Container(
                    height: 80,
                    width: 325,
                    child: new TextField(
                      enabled: false,
                      controller: riwayatController,
                      decoration: new InputDecoration(
                        border: new OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: new BorderSide(color: Colors.blue)),
                        hintText: 'Riwayat Penyakit',
                        labelText: 'Riwayat Penyakit',
                      ),
                    ),
                  ),
                  Container(
                    height: 60,
                    width: 325,
                    child: new TextField(
                      enabled: false,
                      controller: tekananDarahController,
                      decoration: new InputDecoration(
                        border: new OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: new BorderSide(color: Colors.blue)),
                        hintText: 'Tekanan Darah',
                        labelText: 'Tekanan Darah',
                      ),
                    ),
                  ),
                  Container(
                    height: 30,
                    child: Text(
                      "${alertTekananDarah}",
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                  Container(
                    height: 60,
                    width: 325,
                    child: new TextField(
                      enabled: false,
                      controller: beratController,
                      decoration: new InputDecoration(
                        border: new OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: new BorderSide(color: Colors.blue)),
                        hintText: 'Berat',
                        labelText: 'Berat',
                      ),
                    ),
                  ),
                  Container(
                    height: 30,
                    child: Text(
                      "$alertBerat",
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                  Container(
                    height: 60,
                    width: 325,
                    child: new TextField(
                      enabled: false,
                      controller: tinggiController,
                      decoration: new InputDecoration(
                        border: new OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: new BorderSide(color: Colors.blue)),
                        hintText: 'Tinggi',
                        labelText: 'Tinggi',
                      ),
                    ),
                  ),
                  Container(
                    height: 30,
                    child: Text(
                      "$alertTinggi",
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                  ButtonGradient(
                    height: 48,
                    width: 100,
                    text: "Lanjut",
                    onTap: ()async{
                      SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]);
                      Navigator.push(
                        context, 
                        new MaterialPageRoute(
                            builder: (BuildContext context) =>
                            new Odontogram(
                              data: widget.data,
                            )
                          )
                      );
                      
                    },
                  ),
                  Container(height: 20,)
                ]
              )
            )
          ],
        )
      )
    );
  }
}