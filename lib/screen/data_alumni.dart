import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datepicker_single/flutter_datepicker_single.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:smk_losarangg/models/m_alumni.dart';
import 'package:smk_losarangg/providers/p_bimbingan.dart';

class DataAlumni extends StatefulWidget {
  @override
  _DataAlumniState createState() => _DataAlumniState();
}

class _DataAlumniState extends State<DataAlumni> {
  String _myActivity;
  List<String> listDropdown = [
    '2017',
    '2018',
    '2019',
    '2020',
    '2021',
    '2022',
    '2023',
    '2024',
    '2025',
    '2026',
    '2027',
    '2028',
  ];
  String dropdownValue;
  final DateTime now = DateTime.now();
  DateTime _selectedDate;
  FlutterDatePickerMode _mode;
  int _result;
  TextEditingController _controller = TextEditingController();
  TextEditingController _controllerCari = TextEditingController();
  List<DataAlumni2> listCari = [];

  @override
  void initState() {
    super.initState();
    _result = 0;
    _selectedDate = now;
    setState(() {
      _controller.text = now.year.toString();
    });
    Provider.of<ProviderBimbingan>(context, listen: false)
        .getAlumni(tahunLulus: now.year.toString());
  }

  // Demonstrates the dialog flow and Y-M-D cascading using showDatePicker,
  // for comparison.
  Future<DateTime> selectDateWithDatePicker(BuildContext context) async {
    return await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      initialDatePickerMode: DatePickerMode.year,
      firstDate: DateTime(0),
      lastDate: DateTime(9999),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Text("Data Alumni"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Stack(
          children: [
            Positioned(
              left: 0,
              right: 0,
              child: Column(
                children: [
                  InkWell(
                    onTap: () async {
                      DateTime selected = await showYearPicker(
                        context: context,
                        title: Text("Pilih Tahun"),
                        initialDate: _selectedDate,
                      );

                      if (selected != null) {
                        setState(() {
                          _selectedDate = selected;
                          _mode = FlutterDatePickerMode.year;
                          _result = selected.year;
                          _controller.text = selected.year.toString();
                          Provider.of<ProviderBimbingan>(context, listen: false)
                              .getAlumni(tahunLulus: selected.year.toString());
                        });
                      }
                    },
                    child: TextField(
                      controller: _controller,
                      enabled: false,
                      decoration: InputDecoration(
                        hintText: "Pilih Tahun",
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextField(
                    controller: _controllerCari,
                    onChanged: (value) {
                     setState(() {
                       listCari.clear();
                       // _controllerCari.text="";
                       Provider.of<ProviderBimbingan>(context, listen: false)
                           .modelAlumni
                           .data
                           .forEach((element) {
                         if (element.namaSiswa.toLowerCase().contains(value) ||
                             element.status.toLowerCase().contains(value) ||
                             element.detailUniv.namaUniversitas
                                 .toLowerCase()
                                 .contains(value)) {
                           setState(() {
                             listCari.add(element);
                             print(listCari.length);
                           });
                         }
                       });
                     });
                    },
                    decoration: InputDecoration(
                      hintText: "Cari  Alumni",
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
                left: 0,
                right: 0,
                top: 120,
                bottom: 0,
                child: Consumer<ProviderBimbingan>(
                  builder: (context, data, _) {
                    if (data.modelAlumni == null) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      if (listCari.length == 0 &&
                          _controllerCari.text.isEmpty) {
                        return ListView.builder(
                            itemCount: data.modelAlumni.data.length,
                            itemBuilder: (c, i) {
                              return Card(
                                elevation: 3,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Flexible(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text("Nama Lengkap"),
                                                Divider(),
                                                Text(
                                                  "${data.modelAlumni.data[i].namaSiswa}",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Flexible(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                Text("Status"),
                                                Divider(),
                                                Text(
                                                  "${data.modelAlumni.data[i].status}",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 18,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Flexible(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text("Alamat Lengkap"),
                                                Divider(),
                                                Text(
                                                  "${data.modelAlumni.data[i].alamatSiswa}",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Flexible(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                Text("Keterangan"),
                                                Divider(),
                                                Text(
                                                  data.modelAlumni.data[i]
                                                              .detailUniv ==
                                                          null
                                                      ? "${data.modelAlumni.data[i].keterangan}"
                                                      : "${data.modelAlumni.data[i].detailUniv.namaUniversitas} - ${data.modelAlumni.data[i].keterangan}",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            });
                      } else if (listCari.length == 0) {
                        return Center(
                          child: Text("Data tidak ditemukan"),
                        );
                      } else {
                        return ListView.builder(
                            itemCount: listCari.length,
                            itemBuilder: (c, i) {
                              return Card(
                                elevation: 3,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Flexible(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text("Nama Lengkap"),
                                                Divider(),
                                                Text(
                                                  "${listCari[i].namaSiswa}",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Flexible(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                Text("Status"),
                                                Divider(),
                                                Text(
                                                  "${listCari[i].status}",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 18,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Flexible(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text("Alamat Lengkap"),
                                                Divider(),
                                                Text(
                                                  "${listCari[i].alamatSiswa}",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Flexible(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                Text("Keterangan"),
                                                Divider(),
                                                Text(
                                                  listCari[i].detailUniv == null
                                                      ? "${listCari[i].keterangan}"
                                                      : "${listCari[i].detailUniv.namaUniversitas} - ${listCari[i].keterangan}",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            });
                      }
                    }
                  },
                ))
          ],
        ),
      ),
    );
  }

//  body: SingleChildScrollView(
//  physics: const ClampingScrollPhysics(), //buat scroll
//  child: Center(
//  child: Form(
//  child: Column(
//  mainAxisAlignment: MainAxisAlignment.start,
//  children: <Widget>[
//  Container(
//  margin: const EdgeInsets.only(left: 25, right: 25, top: 20),
//  decoration: BoxDecoration(
//  borderRadius: BorderRadius.circular(15),
//  border: Border.all(color: Colors.amber)),
//  padding: EdgeInsets.all(5),
//  child: DropdownButtonHideUnderline(
//  child: Padding(
//  padding: const EdgeInsets.only(left: 20),
//  child: DropdownButton<String>(
//  elevation: 3,
//  value: dropdownValue,
//  isExpanded: true,
//  hint: Text('Tahun Lulus'),
//  onChanged: (String newValue) {
//  if(Provider.of<ProviderBimbingan>(context, listen: false).modelRekapAbsen!=null){
//  Provider.of<ProviderBimbingan>(context, listen: false).modelRekapAbsen.data.clear();
//  }
//  setState(() {
//  dropdownValue = newValue;
//  });
//  if(newValue=='Januari'){
//  Provider.of<ProviderBimbingan>(context, listen: false).getRekapAbsen(month: "01", year: DateFormat("yyyy").format(DateTime.now()));
//  } else if(newValue=='Februari'){
//  Provider.of<ProviderBimbingan>(context, listen: false).getRekapAbsen(month: "02", year: DateFormat("yyyy").format(DateTime.now()));
//  } else if(newValue=='Maret'){
//  Provider.of<ProviderBimbingan>(context, listen: false).getRekapAbsen(month: "03", year: DateFormat("yyyy").format(DateTime.now()));
//  } else if(newValue=='April'){
//  Provider.of<ProviderBimbingan>(context, listen: false).getRekapAbsen(month: "04", year: DateFormat("yyyy").format(DateTime.now()));
//  } else if(newValue=='Mei'){
//  Provider.of<ProviderBimbingan>(context, listen: false).getRekapAbsen(month: "05", year: DateFormat("yyyy").format(DateTime.now()));
//  } else if(newValue=='Juni'){
//  Provider.of<ProviderBimbingan>(context, listen: false).getRekapAbsen(month: "06", year: DateFormat("yyyy").format(DateTime.now()));
//  } else if(newValue=='Juli'){
//  Provider.of<ProviderBimbingan>(context, listen: false).getRekapAbsen(month: "07", year: DateFormat("yyyy").format(DateTime.now()));
//  } else if(newValue=='Agustus'){
//  Provider.of<ProviderBimbingan>(context, listen: false).getRekapAbsen(month: "08", year: DateFormat("yyyy").format(DateTime.now()));
//  } else if(newValue=='September'){
//  Provider.of<ProviderBimbingan>(context, listen: false).getRekapAbsen(month: "09", year: DateFormat("yyyy").format(DateTime.now()));
//  } else if(newValue=='Oktober'){
//  Provider.of<ProviderBimbingan>(context, listen: false).getRekapAbsen(month: "10", year: DateFormat("yyyy").format(DateTime.now()));
//  } else if(newValue=='November'){
//  Provider.of<ProviderBimbingan>(context, listen: false).getRekapAbsen(month: "11", year: DateFormat("yyyy").format(DateTime.now()));
//  } else if(newValue=='Desember'){
//  Provider.of<ProviderBimbingan>(context, listen: false).getRekapAbsen(month: "12", year: DateFormat("yyyy").format(DateTime.now()));
//  }
//  else {
//  setState(() {
//  dropdownValue="Tahun Lulus";
//  });
//  }
//  },
//  items: listDropdown
//      .map<DropdownMenuItem<String>>((String value) {
//  return DropdownMenuItem<String>(
//  value: value,
//  child: Text(value),
//  );
//  }).toList(),
//  ),
//  ),
//  ),
//  ),
//  SingleChildScrollView(
//  scrollDirection: Axis.horizontal,
//  child: Padding(
//  padding: const EdgeInsets.only(top: 15, left: 30,),
//  child: Consumer<ProviderBimbingan>(
//  builder: (context, value, child) {
//  print(dropdownValue);
//  if(dropdownValue=="Tahun Lulus" || dropdownValue==null ){
//  return Center(
//  child: Text("Tahun Lulus"),
//  );
//  } else {
//  if(value.modelRekapAbsen==null){
//  return Center(
//  child: CircularProgressIndicator(),
//  );
//
//  }
//  else{
//  if(value.modelRekapAbsen.data.length==0){
//  return Center(
//  child: Text("Data absen kosong"),
//  );
//  }
//  else{
//  return Align(
//  alignment: Alignment.topCenter,
//  child: DataTable(
//
//  columnSpacing: 100,
//  columns: <DataColumn>[
//  DataColumn(label: Text("NIS")),
//  DataColumn(label: Text("Nama Siswa")),
//  DataColumn(label: Text("Kelas")),
//  DataColumn(label: Text("Sakit")),
//  DataColumn(label: Text("Izin")),
//  DataColumn(label: Text("Absen")),
//  ],
//
//  rows: value.modelRekapAbsen.data.map<DataRow>((e) => DataRow(
//  cells: <DataCell>[
//
//  DataCell(Text(e.nis)),
//  DataCell(Text(e.namaSiswa)),
//  DataCell(Text(e.kelas)),
//  DataCell(Text(e.sakit.toString())),
//  DataCell(Text(e.izin.toString())),
//  DataCell(Text(e.alfa.toString())),
//  ],
//  ),).toList()
//  ),
//  );
//  }
//  }
//  }
//  },
//  )
//  ),
//  ),
//  ],
//  ),
//  ),
//  ),
//  ),
}
