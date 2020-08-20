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

class LihatDetailSiswa extends StatefulWidget {
  final String idKelas;

  const LihatDetailSiswa({Key key, this.idKelas}) : super(key: key);
  @override
  _LihatDetailSiswaState createState() => _LihatDetailSiswaState();
}

class _LihatDetailSiswaState extends State<LihatDetailSiswa> {
  String _myActivity;
  
@override
  void initState() {
    initializeDateFormatting('id', null);
    
    if(Provider.of<ProviderBimbingan>(context, listen: false).modelSiswa!=null){
      Provider.of<ProviderBimbingan>(context, listen: false).modelSiswa.data.clear();
    }
    Provider.of<ProviderBimbingan>(context, listen: false).getSiswa(idKelas: widget.idKelas);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Data Siswa'),
        backgroundColor: Colors.amber,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Padding(
          padding: const EdgeInsets.only(top: 15, left: 30,),
          child: Consumer<ProviderBimbingan>(
            builder: (context, value, child) {
              if(value.modelSiswa==null){
                return Center(
                  child: CircularProgressIndicator(),
                );
              
              }
              else{
                if(value.modelSiswa.data.length==0){
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
              DataColumn(label: Text("Alamat")),
            ],
            
            rows: value.modelSiswa.data.map<DataRow>((e) => DataRow(
                    cells: <DataCell>[
                      
                      DataCell(Text(e.nis)),
                      DataCell(Text(e.namaSiswa)),
                      DataCell(Text(e.alamatSiswa)),
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
