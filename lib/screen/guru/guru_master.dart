import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smk_losarangg/screen/guru/guru_datajurusan.dart';
import 'package:smk_losarangg/screen/guru/guru_datasiswa.dart';

class DataMaster extends StatefulWidget {
  @override
  _DataMasterState createState() => _DataMasterState();
}

class _DataMasterState extends State<DataMaster> with SingleTickerProviderStateMixin {
  TabController controller;

  @override
  void initState(){
    controller = TabController(vsync: this, length: 2);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Text("Data Master"),
        bottom: TabBar(
           controller: controller,
           tabs: <Widget>[
             Tab(text: "Data Siswa"),
             Tab(text: "Data Jurusan",)
           ],
        ),
      ),
      body: TabBarView(
        controller: controller,
        children: <Widget>[
          DataSiswa(),
          DataJurusan()
        ],
      ),
    );
}
}
