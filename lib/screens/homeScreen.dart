import 'package:flutter/material.dart';
import 'package:dent_is_pasien/components/buttonCard.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:dent_is_pasien/screens/initialScreen.dart';
import 'pemeriksaan/riwayatPemeriksaanScreen.dart';
import 'dentalNews.dart';
import 'appointmentScreen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/wallpapers/wallpaper1.png"),
          fit: BoxFit.cover
        )
      ),
      child: Padding(
        padding: EdgeInsets.only(left: 35,right: 35),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(height: 40.0,),
            Text(
              "Halo,\nPasien!",
              style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold),
            ),
            Container(height: 30,),
            ButtonCard(
              onTap: (){
                Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context) =>
                    new AppointmentScreen()
                  )
                );
              },
              child: Row(
                children: <Widget>[
                  Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                      image: DecorationImage(image: AssetImage("assets/appointments.png"))
                    ),
                  ),
                  Container(width:10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(height: 10,),
                      Text(
                        "Appointment",
                        style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),
                      ),
                      Container(height: 4,),
                      Container(
                        width: 200,
                        height: 30,
                        child: Text(
                          "Buat appointment baru atau kelola appointment yang sudah ada",
                          style: TextStyle(fontSize: 12),
                        )
                      ),
                    ],
                  )
                ],
              ),
            ),
            Container(height: 30,),
            ButtonCard(
              onTap: (){
                Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context) =>
                    new RiwayatPemeriksaanScreen()
                  )
                );
              },
              child: Row(
                children: <Widget>[
                  Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                      image: DecorationImage(image: AssetImage("assets/folder.png"))
                    ),
                  ),
                  Container(width:10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(height: 10,),
                      Text(
                        "Riwayat Pemeriksaan",
                        style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),
                      ),
                      Container(height: 4,),
                      Container(
                        width: 200,
                        height: 30,
                        child: Text(
                          "Lihat riwayat pemeriksaan yang telah Anda jalani! Mulai dari rekam medis, foto rontgen, hingga tagihan.",
                          style: TextStyle(fontSize: 12),
                        )
                      ),
                    ],
                  )
                ],
              ),
            ),
            Container(height: 30,),
            ButtonCard(
              onTap: (){
                Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context) =>
                    new DentalNews()
                  )
                );
              },
              child: Row(
                children: <Widget>[
                  Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                      image: DecorationImage(image: AssetImage("assets/news.png"))
                    ),
                  ),
                  Container(width:10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(height: 10,),
                      Text(
                        "Health News",
                        style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),
                      ),
                      Container(height: 4,),
                      Container(
                        width: 200,
                        height: 30,
                        child: Text(
                          "Lihat berbagai berita terkini mengenai kesehatan!",
                          style: TextStyle(fontSize: 12),
                        )
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      )
    );
  }
}