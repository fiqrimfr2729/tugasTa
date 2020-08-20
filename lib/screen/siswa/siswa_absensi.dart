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

class Absensi extends StatefulWidget {
  @override
  _AbsensiState createState() => _AbsensiState();
}

class _AbsensiState extends State<Absensi> {
  String _myActivity;

  @override
  void initState() {
    initializeDateFormatting('id', null);

    Provider.of<ProviderBimbingan>(context, listen: false).getAbsen();

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
            padding: const EdgeInsets.only(
              top: 15,
              left: 30,
            ),
            child: Consumer<ProviderBimbingan>(
              builder: (context, value, child) {
                if (value.modelAbsen == null) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  if (value.modelAbsen.data.length == 0) {
                    return Center(
                      child: Text("Data absen kosong"),
                    );
                  } else {
                    return Align(
                      alignment: Alignment.topCenter,
                      child: DataTable(
                          columnSpacing: 100,
                          columns: <DataColumn>[
                            DataColumn(label: Text("Tanggal")),
                            DataColumn(label: Text("Keterangan")),
                          ],
                          rows: value.modelAbsen.data
                              .map<DataRow>(
                                (e) => DataRow(
                                  cells: <DataCell>[
                                    DataCell(Text(DateFormat(
                                            "EEEE, dd MMMM yyyy", "id-ID")
                                        .format(e.tanggal))),
                                    DataCell(Text(e.keterangan.toString())),
                                  ],
                                ),
                              )
                              .toList()),
                    );
                  }
                }
              },
            )),
      ),
    );
    // body:  Center(
    //     child: Form(
    //       child: Column(
    //         mainAxisAlignment: MainAxisAlignment.start,
    //         children: <Widget>[
    //           Container(
    //             margin: const EdgeInsets.only(left: 25, right: 25, top: 20),
    //             decoration: BoxDecoration(
    //                 borderRadius: BorderRadius.circular(15),
    //                 border: Border.all(color: Colors.amber)),
    //             padding: EdgeInsets.all(5),
    //             child: DropdownButtonHideUnderline(
    //               child: Padding(
    //                 padding: const EdgeInsets.only(left: 20),
    //                 child: DropdownButton<String>(
    //                   elevation: 3,
    //                   value: dropdownValue,
    //                   isExpanded: true,
    //                   hint: Text('Pilih Bulan'),
    //                   onChanged: (String newValue) {
    //                     setState(() {
    //                       dropdownValue = newValue;
    //                     });
    //                   },
    //                   items: listDropdown
    //                       .map<DropdownMenuItem<String>>((String value) {
    //                     return DropdownMenuItem<String>(
    //                       value: value,
    //                       child: Text(value),
    //                     );
    //                   }).toList(),
    //                 ),
    //               ),
    //             ),
    //           ),

    //         ],
    //       ),
    //     ),
    //   ),

    // );
  }
}
