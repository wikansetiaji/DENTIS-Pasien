import 'package:flutter/material.dart';
import 'package:dent_is_pasien/components/buttonGradient.dart';

class DetailGigi4 extends StatefulWidget {
  bool ohis;
  String code;
  Map<String, dynamic> conditions;
  Map<String, dynamic> ohisData;


  DetailGigi4({
    @required this.ohis,
    @required this.code,
    @required this.conditions,
    this.ohisData
  });

  @override
  _DetailGigi4State createState() => _DetailGigi4State();
}

class _DetailGigi4State extends State<DetailGigi4> {
  bool d = false;
  bool l = false;
  bool m = false;
  bool v = true;

  int ci=0;
  int di=0;

  String selected = "o";

  String tab = "status";

  Map<String,dynamic> values; 

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    values = widget.conditions ;  
    if (widget.ohis){
      di = widget.ohisData[widget.code]["di"];
      ci = widget.ohisData[widget.code]["ci"];
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.ohis){
      return WillPopScope(
        onWillPop: (){
          Navigator.pop(context, {"condition":widget.conditions,"ohis":{"kode":widget.code,"di":di,"ci":ci}});
        },
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            leading: IconButton(
              color: Colors.black,
              icon: Icon(Icons.arrow_back_ios),
              onPressed: (){
                Navigator.pop(context, {"condition":widget.conditions,"ohis":{"kode":widget.code,"di":di,"ci":ci}});
              },
            ),
            centerTitle: true,
            title: Text("DENT-IS",style: TextStyle(color:Colors.black54),),
          ),
          body: ListView(
            children: <Widget>[
              Container(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(widget.code,style: TextStyle(fontSize: 40,fontWeight: FontWeight.w900),),
                      Stack(
                        children: <Widget>[

                          //image
                          Container(
                            height: 200,
                            width: 200,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage("assets/detailGigi/gigi4/bg.png")
                              )
                            ),
                          ),
                          Container(
                            height: v?200:0,
                            width: 200,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage("assets/detailGigi/gigi4/v.png")
                              )
                            ),
                          ),
                          Container(
                            height: m?200:0,
                            width: 200,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage("assets/detailGigi/gigi4/m.png")
                              )
                            ),
                          ),
                          Container(
                            height: l?200:0,
                            width: 200,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage("assets/detailGigi/gigi4/l.png")
                              )
                            ),
                          ),
                          Container(
                            height: d?200:0,
                            width: 200,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage("assets/detailGigi/gigi4/d.png")
                              )
                            ),
                          ),

                          //text
                          Row(
                            children: <Widget>[
                              Container(
                                height: 200,
                                width: 55,
                                alignment: Alignment.center,
                                child: Text(
                                  "${values["d"]!=-1?values["d"]:""}",
                                  style: TextStyle(
                                    fontSize: 36,
                                    fontWeight: FontWeight.w900
                                  ),
                                ),
                              ),
                              Column(
                                children: <Widget>[
                                  Container(
                                    height: 100,
                                    width: 90,
                                    alignment: Alignment.center,
                                    child: Text(
                                      "${values["v"]!=-1?values["v"]:""}",
                                      style: TextStyle(
                                        fontSize: 36,
                                        fontWeight: FontWeight.w900
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 100,
                                    width: 90,
                                    alignment: Alignment.center,
                                    child: Text(
                                      "${values["l"]!=-1?values["l"]:""}",
                                      style: TextStyle(
                                        fontSize: 36,
                                        fontWeight: FontWeight.w900
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              Container(
                                height: 200,
                                width: 55,
                                alignment: Alignment.center,
                                child: Text(
                                  "${values["m"]!=-1?values["m"]:""}",
                                  style: TextStyle(
                                    fontSize: 36,
                                    fontWeight: FontWeight.w900
                                  ),
                                ),
                              ),
                            ],
                          ),

                          //Button
                          Row(
                            children: <Widget>[
                              InkWell(
                                onTap: (){
                                  setState(() {
                                    v=false;
                                    l=false;
                                    m=false;
                                    d=true;
                                    selected="d";
                                  });
                                },
                                child: Container(
                                  height: 200,
                                  width: 55,
                                ),
                              ),
                              Column(
                                children: <Widget>[
                                  InkWell(
                                    onTap: (){
                                      setState(() {
                                        v=true;
                                        l=false;
                                        m=false;
                                        d=false;
                                        selected="v";
                                      });
                                    },
                                    child: Container(
                                      height: 100,
                                      width: 90,
                                    ),
                                  ),
                                  InkWell(
                                    onTap: (){
                                      setState(() {
                                        v=false;
                                        l=true;
                                        m=false;
                                        d=false;
                                        selected="l";
                                      });
                                    },
                                    child: Container(
                                      height: 100,
                                      width: 90,
                                    ),
                                  )
                                ],
                              ),
                              InkWell(
                                onTap: (){
                                  setState(() {
                                    v=false;
                                    l=false;
                                    m=true;
                                    d=false;
                                    selected="m";
                                  });
                                },
                                child: Container(
                                  height: 200,
                                  width: 55,
                                )
                              ),
                            ],
                          ),
                        ],
                      ),
                      Container(height: 10,),
                    ],
                  ),
                  Container(width: 30,),
                    Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              InkWell(
                                onTap: (){
                                  setState(() {
                                    tab="status";
                                  });
                                },
                                child: Stack(
                                  children: <Widget>[
                                    Container(
                                      width: 165,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage("assets/tabs/status-selected.png")
                                        )
                                      ),
                                    ),
                                    Container(
                                      width: 165,
                                      height: tab=="ohis"?40:0,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage("assets/tabs/status.png")
                                        )
                                      ),
                                    ),
                                  ],
                                )
                              ),
                              InkWell(
                                onTap: (){
                                  setState(() {
                                    tab="ohis";
                                  });
                                },
                                child: Stack(
                                  children: <Widget>[
                                    Container(
                                      width: 165,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage("assets/tabs/ohis.png")
                                        )
                                      ),
                                    ),
                                    Container(
                                      width: 165,
                                      height: tab=="ohis"?40:0,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage("assets/tabs/ohis-selected.png")
                                        )
                                      ),
                                    ),
                                  ],
                                )
                              ),
                            ],
                          ),
                          Stack(
                            children: <Widget>[
                              Container(
                                height: tab=="status"?500:0,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: <Widget>[
                                        Row(
                                          children: <Widget>[
                                            Radio(
                                              value: 0,
                                              groupValue: values[selected],
                                            ),
                                            InkWell(
                                              child: Text("0 = Sound"),
                                            )
                                          ],
                                        ),
                                        Row(
                                          children: <Widget>[
                                            Radio(
                                              value: 1,
                                              groupValue: values[selected],
                                            ),
                                            InkWell(
                                              child: Text("1 = Caries"),
                                            )
                                            
                                          ],
                                        ),
                                        Row(
                                          children: <Widget>[
                                            Radio(
                                              value: 2,
                                              groupValue: values[selected],
                                            ),
                                            InkWell(
                                              child: Text("2 = Filled with caries"),
                                            )
                                          ],
                                        ),
                                        Row(
                                          children: <Widget>[
                                            Radio(
                                              value: 3,
                                              groupValue: values[selected],
                                            ),
                                            InkWell(
                                              child: Text("3 = Filled no caries"),
                                            )
                                          ],
                                        ),
                                        Row(
                                          children: <Widget>[
                                            Radio(
                                              value: 4,
                                              groupValue: values[selected],
                                            ),
                                            InkWell(
                                              child: Text("4 = Missing due caries"),
                                            )
                                          ],
                                        ),
                                        Row(
                                          children: <Widget>[
                                            Radio(
                                              value: 5,
                                              groupValue: values[selected],
                                            ),
                                            InkWell(
                                              child: Text("5 = Missing for another\nreason"),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: <Widget>[
                                        Row(
                                          children: <Widget>[
                                            Radio(
                                              value: 6,
                                              groupValue: values[selected],
                                            ),
                                            InkWell(
                                              child: Text("6 = Fissure sealant"),
                                            )
                                            
                                          ],
                                        ),
                                        Row(
                                          children: <Widget>[
                                            Radio(
                                              value: 7,
                                              groupValue: values[selected],
                                            ),
                                            InkWell(
                                              child: Text("7 = Fix dental\nprosthesis / crown,\nabutment, veneer"),
                                            )
                                          ],
                                        ),
                                        Row(
                                          children: <Widget>[
                                            Radio(
                                              value: 8,
                                              groupValue: values[selected],
                                            ),
                                            InkWell(
                                              child: Text("8 = Unerupted"),
                                            )
                                          ],
                                        ),
                                        Row(
                                          children: <Widget>[
                                            Radio(
                                              value: 9,
                                              groupValue: values[selected],
                                            ),
                                            InkWell(
                                              child: Text("9 = Not Recorded"),
                                            )
                                          ],
                                        ),
                                        Row(
                                          children: <Widget>[
                                            Radio(
                                              value: 10,
                                              groupValue: values[selected],
                                            ),
                                            InkWell(
                                              child: Text("10 = Whitespot"),
                                            ),
                                          ],
                                        ),
                                        
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                  alignment: Alignment.center,
                                  height: tab=="ohis"?500:0,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Container(height: 53,),
                                      Row(
                                        children: <Widget>[
                                          Container(width: 70,),
                                          Text(
                                            "DI",
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold
                                            ),
                                          ),
                                          Container(
                                            width: 20,
                                          ),
                                          Column(
                                            children: <Widget>[
                                              Text("0"),
                                              Radio(
                                                value: 0,
                                                groupValue: di,
                                              ),
                                            ],
                                          ),
                                          Column(
                                            children: <Widget>[
                                              Text("1"),
                                              Radio(
                                                value: 1,
                                                groupValue: di,
                                              ),
                                            ],
                                          ),
                                          Column(
                                            children: <Widget>[
                                              Text("2"),
                                              Radio(
                                                value: 2,
                                                groupValue: di,
                                              ),
                                            ],
                                          ),
                                          Column(
                                            children: <Widget>[
                                              Text("3"),
                                              Radio(
                                                value: 3,
                                                groupValue: di,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Container(height: 20,),
                                      Row(
                                        children: <Widget>[
                                          Container(width: 70,),
                                          Text(
                                            "CI",
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold
                                            ),
                                          ),
                                          Container(
                                            width: 20,
                                          ),
                                          Column(
                                            children: <Widget>[
                                              Text("0"),
                                              Radio(
                                                value: 0,
                                                groupValue: ci,
                                              ),
                                            ],
                                          ),
                                          Column(
                                            children: <Widget>[
                                              Text("1"),
                                              Radio(
                                                value: 1,
                                                groupValue: ci,
                                              ),
                                            ],
                                          ),
                                          Column(
                                            children: <Widget>[
                                              Text("2"),
                                              Radio(
                                                value: 2,
                                                groupValue: ci,
                                              ),
                                            ],
                                          ),
                                          Column(
                                            children: <Widget>[
                                              Text("3"),
                                              Radio(
                                                value: 3,
                                                groupValue: ci,
                                                onChanged: (value){
                                                  setState(() {
                                                    ci=value;
                                                  });
                                                },
                                              ),
                                            ],
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                            ],
                          ),
                        ],
                      ),
                    )
                ],
              )
            ],
          ),
        )
      );
    }
    else{
      return WillPopScope(
        onWillPop: (){
          Navigator.pop(context, widget.conditions);
        },
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            leading: IconButton(
              color: Colors.black,
              icon: Icon(Icons.arrow_back_ios),
              onPressed: (){
                Navigator.pop(context, widget.conditions);
              },
            ),
            centerTitle: true,
            title: Text("DENT-IS",style: TextStyle(color:Colors.black54),),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(height:20),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(widget.code,style: TextStyle(fontSize: 40,fontWeight: FontWeight.w900),),
                      Stack(
                        children: <Widget>[

                          //image
                          Container(
                            height: 200,
                            width: 200,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage("assets/detailGigi/gigi4/bg.png")
                              )
                            ),
                          ),
                          Container(
                            height: v?200:0,
                            width: 200,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage("assets/detailGigi/gigi4/v.png")
                              )
                            ),
                          ),
                          Container(
                            height: m?200:0,
                            width: 200,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage("assets/detailGigi/gigi4/m.png")
                              )
                            ),
                          ),
                          Container(
                            height: l?200:0,
                            width: 200,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage("assets/detailGigi/gigi4/l.png")
                              )
                            ),
                          ),
                          Container(
                            height: d?200:0,
                            width: 200,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage("assets/detailGigi/gigi4/d.png")
                              )
                            ),
                          ),

                          //text
                          Row(
                            children: <Widget>[
                              Container(
                                height: 200,
                                width: 55,
                                alignment: Alignment.center,
                                child: Text(
                                  "${values["d"]!=-1?values["d"]:""}",
                                  style: TextStyle(
                                    fontSize: 36,
                                    fontWeight: FontWeight.w900
                                  ),
                                ),
                              ),
                              Column(
                                children: <Widget>[
                                  Container(
                                    height: 100,
                                    width: 90,
                                    alignment: Alignment.center,
                                    child: Text(
                                      "${values["v"]!=-1?values["v"]:""}",
                                      style: TextStyle(
                                        fontSize: 36,
                                        fontWeight: FontWeight.w900
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 100,
                                    width: 90,
                                    alignment: Alignment.center,
                                    child: Text(
                                      "${values["l"]!=-1?values["l"]:""}",
                                      style: TextStyle(
                                        fontSize: 36,
                                        fontWeight: FontWeight.w900
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              Container(
                                height: 200,
                                width: 55,
                                alignment: Alignment.center,
                                child: Text(
                                  "${values["m"]!=-1?values["m"]:""}",
                                  style: TextStyle(
                                    fontSize: 36,
                                    fontWeight: FontWeight.w900
                                  ),
                                ),
                              ),
                            ],
                          ),

                          //Button
                          Row(
                            children: <Widget>[
                              InkWell(
                                onTap: (){
                                  setState(() {
                                    v=false;
                                    l=false;
                                    m=false;
                                    d=true;
                                    selected="d";
                                  });
                                },
                                child: Container(
                                  height: 200,
                                  width: 55,
                                ),
                              ),
                              Column(
                                children: <Widget>[
                                  InkWell(
                                    onTap: (){
                                      setState(() {
                                        v=true;
                                        l=false;
                                        m=false;
                                        d=false;
                                        selected="v";
                                      });
                                    },
                                    child: Container(
                                      height: 100,
                                      width: 90,
                                    ),
                                  ),
                                  InkWell(
                                    onTap: (){
                                      setState(() {
                                        v=false;
                                        l=true;
                                        m=false;
                                        d=false;
                                        selected="l";
                                      });
                                    },
                                    child: Container(
                                      height: 100,
                                      width: 90,
                                    ),
                                  )
                                ],
                              ),
                              InkWell(
                                onTap: (){
                                  setState(() {
                                    v=false;
                                    l=false;
                                    m=true;
                                    d=false;
                                    selected="m";
                                  });
                                },
                                child: Container(
                                  height: 200,
                                  width: 55,
                                )
                              ),
                            ],
                          ),
                        ],
                      ),
                      Container(height: 10,),
                    ],
                  ),
                  Container(width: 30,),
                      Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Status",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w900
                              ),
                            ),
                            Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          Radio(
                                            value: 0,
                                            groupValue: values[selected],
                                          ),
                                          InkWell(
                                            child: Text("0 = Sound"),
                                          )
                                        ],
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Radio(
                                            value: 1,
                                            groupValue: values[selected],
                                          ),
                                          InkWell(
                                            child: Text("1 = Caries"),
                                          )
                                          
                                        ],
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Radio(
                                            value: 2,
                                            groupValue: values[selected],
                                          ),
                                          InkWell(
                                            child: Text("2 = Filled with caries"),
                                          )
                                        ],
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Radio(
                                            value: 3,
                                            groupValue: values[selected],
                                          ),
                                          InkWell(
                                            child: Text("3 = Filled no caries"),
                                          )
                                        ],
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Radio(
                                            value: 4,
                                            groupValue: values[selected],
                                          ),
                                          InkWell(
                                            child: Text("4 = Missing due caries"),
                                          )
                                        ],
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Radio(
                                            value: 5,
                                            groupValue: values[selected],
                                          ),
                                          InkWell(
                                            child: Text("5 = Missing for another\nreason"),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          Radio(
                                            value: 6,
                                            groupValue: values[selected],
                                          ),
                                          InkWell(
                                            child: Text("6 = Fissure sealant"),
                                          )
                                          
                                        ],
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Radio(
                                            value: 7,
                                            groupValue: values[selected],
                                          ),
                                          InkWell(
                                            child: Text("7 = Fix dental\nprosthesis / crown,\nabutment, veneer"),
                                          )
                                        ],
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Radio(
                                            value: 8,
                                            groupValue: values[selected],
                                          ),
                                          InkWell(
                                            child: Text("8 = Unerupted"),
                                          )
                                        ],
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Radio(
                                            value: 9,
                                            groupValue: values[selected],
                                          ),
                                          InkWell(
                                            child: Text("9 = Not Recorded"),
                                          )
                                        ],
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Radio(
                                            value: 10,
                                            groupValue: values[selected],
                                          ),
                                          InkWell(
                                            child: Text("10 = Whitespot"),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Container(width: 10,),
                                          
                                        ],
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      )
                ],
              )
            ],
          ),
        )
      );
    }
  }
}