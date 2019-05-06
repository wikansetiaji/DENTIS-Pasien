import 'package:flutter/material.dart';
import 'package:dent_is_pasien/components/buttonGradient.dart';
import 'package:dent_is_pasien/utils/utils.dart';
import 'pemeriksaanAwal.dart';

class DetailPemeriksaanScreen extends StatefulWidget {
  final Map<String,dynamic> data;

  DetailPemeriksaanScreen({
    @required this.data
  });

  @override
  _DetailPemeriksaanScreenState createState() => _DetailPemeriksaanScreenState();
}

class _DetailPemeriksaanScreenState extends State<DetailPemeriksaanScreen> {

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
              title: Text("Detail Pemeriksaan",style: TextStyle(color:Colors.black54),),
            ),
            body: ListView(
              padding: EdgeInsets.all(10),
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Container(height: 39,),
                    Container(
                      width: 200,
                      height: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: Colors.grey,
                        image: DecorationImage(
                          image: NetworkImage(
                            widget.data["fotorontgen_set"].length!=0?"http://10.0.2.2:8000${widget.data["fotorontgen_set"][0]["foto"]}":""
                          ),
                          fit: BoxFit.fitWidth
                        )
                      ),
                    ),
                    Container(height: 20,),
                    Container(
                      margin: EdgeInsets.all(15),
                      padding: EdgeInsets.all(15),
                      width: 330,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        border: Border.all(
                          color: Theme.of(context).accentColor,
                          width: 2.0
                        )
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("Data Umum",style: TextStyle(fontWeight: FontWeight.w900,fontSize: 18),),
                          Divider(
                            color: Theme.of(context).accentColor,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(height: 10,),
                                  Text("Nama Dokter"),
                                  Container(height: 10,),
                                  Text("Jenis Layanan"),
                                  Container(height: 10,),
                                  Text("Waktu Layanan")
                                ],
                              ),
                              Expanded(
                                child: Container(),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  Container(height: 10,),
                                  Text(widget.data["dokter"]["nama"]),
                                  Container(height: 10,),
                                  Text("Periksa Gigi"),
                                  Container(height: 10,),
                                  Text("${Util.convertToDateString(widget.data["created_at"].split("T")[0])}"),
                                  Text("${widget.data["created_at"].split("T")[1].substring(0,5)}")
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(15),
                      padding: EdgeInsets.all(15),
                      width: 330,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        border: Border.all(
                          color: Theme.of(context).accentColor,
                          width: 2.0
                        )
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("Rekam Medis",style: TextStyle(fontWeight: FontWeight.w900,fontSize: 18),),
                          Divider(
                            color: Theme.of(context).accentColor,
                          ),
                          Container(height: 10,),
                          Text("Rekam medis berisi pemeriksaan awal, diagnosa, serta layanan yang dilakukan dokter ke setiap pasien."),
                          Container(height: 10,),
                          Container(
                            alignment: Alignment.center,
                            child: ButtonGradient(
                              height: 40,
                              width: 140,
                              onTap: (){
                                Navigator.push(
                                  context, 
                                  new MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                      new PemeriksaanAwal(
                                        data: widget.data,
                                      )
                                    )
                                );
                              },
                              text: "Lihat Rekam Medis",
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(15),
                      padding: EdgeInsets.all(15),
                      width: 330,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        border: Border.all(
                          color: Theme.of(context).accentColor,
                          width: 2.0
                        )
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("Tagihan",style: TextStyle(fontWeight: FontWeight.w900,fontSize: 18),),
                          Divider(
                            color: Theme.of(context).accentColor,
                          ),
                          Container(height: 10,),
                          Row(
                            children: <Widget>[
                              Text("Total tagihan"),
                              Expanded(child: Container(),),
                              Text("Rp. 200000")
                            ],
                          ),
                          Container(height: 10,),
                          Container(
                            alignment: Alignment.center,
                            child: ButtonGradient(
                              height: 40,
                              width: 140,
                              onTap: (){},
                              text: "Lihat Tagihan",
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ]
      )
    );
  }
}