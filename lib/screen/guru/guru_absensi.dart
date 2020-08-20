import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:md2_tab_indicator/md2_tab_indicator.dart';
import 'package:smk_losarangg/screen/guru/guru_absenharian.dart';
import 'package:smk_losarangg/screen/guru/guru_rekapabsen.dart';

class Absensi extends StatefulWidget {
  @override
  _AbsensiState createState() => _AbsensiState();
}

class _AbsensiState extends State<Absensi> with SingleTickerProviderStateMixin{
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
        title: Text("Data Absensi"),
        bottom: TabBar(
           controller: controller,
           tabs: <Widget>[
             Tab(text: "Absensi Harian"),
             Tab(text: "Rekap Absensi",)
           ],
        ),
      ),
      body: TabBarView(
        controller: controller,
        children: <Widget>[
          new AbsenHarian(),
          new RekapAbsen(),
        ],
      ),
    );
}
}