import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:smk_losarangg/providers/p_bimbingan.dart';
import 'package:smk_losarangg/screen/login.dart';
import 'package:smk_losarangg/screen/siswa/siswa_home.dart';
import 'package:smk_losarangg/screen/siswa/siswa_mulaibimbingan.dart';
import 'package:smk_losarangg/screen/siswa/siswa_profil.dart';
import 'package:smk_losarangg/screen/siswa/siswa_riwayatbimbingan.dart';
import 'package:smk_losarangg/screen/tentang.dart';

class DataAbsen extends StatefulWidget {
  final String idKelas;
  final String tanggal;

  const DataAbsen({Key key, this.idKelas, this.tanggal}) : super(key: key);
  @override
  _DataAbsenState createState() => _DataAbsenState();
}

class _DataAbsenState extends State<DataAbsen> {
  String _myActivity;
  
@override
  void initState() {
    initializeDateFormatting('id', null);
    print(widget.idKelas);
    if(Provider.of<ProviderBimbingan>(context, listen: false).modelDataAbsen!=null){
      Provider.of<ProviderBimbingan>(context, listen: false).modelDataAbsen.data.clear();
    }
    Provider.of<ProviderBimbingan>(context, listen: false).getDataAbsen(idKelas: widget.idKelas, tanggal: widget.tanggal);
    
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Absensi'),
        backgroundColor: Colors.amber,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Padding(
          padding: const EdgeInsets.only(top: 15, left: 30,),
          child: Consumer<ProviderBimbingan>(
            builder: (context, value, child) {
              if(value.modelDataAbsen==null){
                return Center(
                  child: CircularProgressIndicator(),
                );
              
              }
              else{
                if(value.modelDataAbsen.data.length==0){
                  return Center(
                    child: Text("Data absen kosong"),
                  );
                }
                else{
                  return Align(
                    alignment: Alignment.topCenter,
                    child: DataTable(
                      
            columnSpacing: 100,
            columns: <DataColumn>[
             DataColumn(label: Text("NIS")),
              DataColumn(label: Text("Nama Siswa")),
              DataColumn(label: Text("Keterangan")),
            ],
            
            rows: value.modelDataAbsen.data.map<DataRow>((e) => DataRow(
                    cells: <DataCell>[
                      
                      DataCell(Text(e.nis)),
                      DataCell(Text(e.detailSiswa.namaSiswa)),
                      DataCell(Text(e.keterangan.toString())),
                    ],
              ),).toList()
          ),
                  );
                }
              }
            },
          )
        ),
      ),
    );
  }
}
