import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:dent_is_pasien/components/buttonGradient.dart';
import 'uploadFoto.dart';

class JenisPenanganan extends StatefulWidget {
  Map<String,dynamic> data;

  JenisPenanganan({
    @required this.data
  });

  @override
  _JenisPenangananState createState(){
    return _JenisPenangananState();
  }
}

class _JenisPenangananState extends State<JenisPenanganan> {
  final lainnyaController = TextEditingController();
  String alert="";
  Map<String,dynamic> penanganan = {
    "dhe":false,
    "cpp_acp":false,
    "sp":false,
    "fs":false,
    "art":false,
    "eks":false,
    "lainnya":false
  };

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    print(widget.data["penanganan"]);
    setState(() {
      if (widget.data["penanganan"]!=null){
        penanganan = new Map<String, dynamic>.from(widget.data["penanganan"]);
        lainnyaController.text = widget.data["penanganan"]["lainnya"];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child:WillPopScope(
        onWillPop: (){
          SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]);
          Navigator.of(context).pop();
        },
        child:Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            leading: IconButton(
              color: Colors.black,
              icon: Icon(Icons.arrow_back_ios),
              onPressed: (){
                SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]);
                Navigator.of(context).pop();
              },
            ),
            centerTitle: true,
            title: Text("Rekam Medis",style: TextStyle(color:Colors.black54),),
          ),
          body: ListView(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Container(height: 28,),
                  Text(
                    "Jenis Penanganan",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 40
                    ),
                  ),
                  Container(
                    height: 10,
                  ),
                  new CheckboxListTile(
                    value: penanganan["dhe"],
                    title: new Text('DHE'),
                    controlAffinity: ListTileControlAffinity.leading,
                  ),
                  new CheckboxListTile(
                    value: penanganan["cpp_acp"],
                    title: new Text('Aplikasi CPP ACP'),
                    controlAffinity: ListTileControlAffinity.leading,
                  ),
                  new CheckboxListTile(
                    value: penanganan["sp"],
                    title: new Text('Surface Protection'),
                    controlAffinity: ListTileControlAffinity.leading,
                  ),
                  new CheckboxListTile(
                    value: penanganan["fs"],
                    title: new Text('Fissure Sealant'),
                    controlAffinity: ListTileControlAffinity.leading,
                  ),
                  new CheckboxListTile(
                    value: penanganan["art"],
                    title: new Text('Penambahan Art'),
                    controlAffinity: ListTileControlAffinity.leading,
                  ),
                  new CheckboxListTile(
                    value: penanganan["eks"],
                    title: new Text('Pencabutan / Ekstraksi'),
                    controlAffinity: ListTileControlAffinity.leading,
                  ),
                  new CheckboxListTile(
                    value: penanganan["lainnya"]!="" && widget.data["penanganan"]!=null,
                    title: new Text('Lainnya'),
                    controlAffinity: ListTileControlAffinity.leading,
                  ),
                  Container(
                    height: 80,
                    width: 325,
                    child: new TextField(
                      controller: lainnyaController,
                      enabled: false,
                      decoration: new InputDecoration(
                        border: new OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: new BorderSide(color: Colors.blue)),
                        hintText: 'Co: rujukan rumah sakit',
                        labelText: 'Lainnya',
                      ),
                    ),
                  ),
                  Container(
                    height: 20,
                    child: Text(
                      "$alert",
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                  ButtonGradient(
                    height: 40,
                    width: 130,
                    text: "Lanjut",
                    onTap: (){
                      Navigator.of(context).push(
                        new MaterialPageRoute(
                          builder: (BuildContext context) =>
                            new UploadFoto(data: widget.data,)
                          )
                      );
                    },
                  ),
                  Container(height: 20,)
                ],
              )
            ],
          )
        )
      )
    );
  }
}