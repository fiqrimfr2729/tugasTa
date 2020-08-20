import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datepicker_single/flutter_datepicker_single.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:smk_losarangg/providers/p_bimbingan.dart';

class RekapAbsen extends StatefulWidget {
  @override
  _RekapAbsenState createState() => _RekapAbsenState();
}

class _RekapAbsenState extends State<RekapAbsen> {
  String _myActivity;
  List<String> listDropdown = ['Januari', 'Februari', 'Maret', 'April', 'Mei', 'Juni', 'Juli', 'Agustus', 'September', 'Oktober', 'November', 'Desember',];
  String dropdownValue;
  final DateTime now = DateTime.now();
  DateTime _selectedDate;
  FlutterDatePickerMode _mode;
  int _result;

  @override
  void initState() {
    super.initState();
    _result = 0;
    _selectedDate = now;
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
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(), //buat scroll
        child: Center(
          child: Form(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(left: 25, right: 25, top: 20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: Colors.amber)),
                  padding: EdgeInsets.all(5),
                  child: DropdownButtonHideUnderline(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: DropdownButton<String>(
                        elevation: 3,
                        value: dropdownValue,
                        isExpanded: true,
                        hint: Text('Pilih Bulan'),
                        onChanged: (String newValue) {
                          if(Provider.of<ProviderBimbingan>(context, listen: false).modelRekapAbsen!=null){
                            Provider.of<ProviderBimbingan>(context, listen: false).modelRekapAbsen.data.clear();
                          }
                          setState(() {
                            dropdownValue = newValue;
                          });
                          if(newValue=='Januari'){
                            Provider.of<ProviderBimbingan>(context, listen: false).getRekapAbsen(month: "01", year: DateFormat("yyyy").format(DateTime.now()));
                          } else if(newValue=='Februari'){
                            Provider.of<ProviderBimbingan>(context, listen: false).getRekapAbsen(month: "02", year: DateFormat("yyyy").format(DateTime.now()));
                          } else if(newValue=='Maret'){
                            Provider.of<ProviderBimbingan>(context, listen: false).getRekapAbsen(month: "03", year: DateFormat("yyyy").format(DateTime.now()));
                          } else if(newValue=='April'){
                            Provider.of<ProviderBimbingan>(context, listen: false).getRekapAbsen(month: "04", year: DateFormat("yyyy").format(DateTime.now()));
                          } else if(newValue=='Mei'){
                            Provider.of<ProviderBimbingan>(context, listen: false).getRekapAbsen(month: "05", year: DateFormat("yyyy").format(DateTime.now()));
                          } else if(newValue=='Juni'){
                            Provider.of<ProviderBimbingan>(context, listen: false).getRekapAbsen(month: "06", year: DateFormat("yyyy").format(DateTime.now()));
                          } else if(newValue=='Juli'){
                            Provider.of<ProviderBimbingan>(context, listen: false).getRekapAbsen(month: "07", year: DateFormat("yyyy").format(DateTime.now()));
                          } else if(newValue=='Agustus'){
                            Provider.of<ProviderBimbingan>(context, listen: false).getRekapAbsen(month: "08", year: DateFormat("yyyy").format(DateTime.now()));
                          } else if(newValue=='September'){
                            Provider.of<ProviderBimbingan>(context, listen: false).getRekapAbsen(month: "09", year: DateFormat("yyyy").format(DateTime.now()));
                          } else if(newValue=='Oktober'){
                            Provider.of<ProviderBimbingan>(context, listen: false).getRekapAbsen(month: "10", year: DateFormat("yyyy").format(DateTime.now()));
                          } else if(newValue=='November'){
                            Provider.of<ProviderBimbingan>(context, listen: false).getRekapAbsen(month: "11", year: DateFormat("yyyy").format(DateTime.now()));
                          } else if(newValue=='Desember'){
                            Provider.of<ProviderBimbingan>(context, listen: false).getRekapAbsen(month: "12", year: DateFormat("yyyy").format(DateTime.now()));
                          }
                          else {
                            setState(() {
                              dropdownValue="Pilih Bulan";
                            });
                          }
                        },
                        items: listDropdown
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
                SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Padding(
          padding: const EdgeInsets.only(top: 15, left: 30,),
          child: Consumer<ProviderBimbingan>(
            builder: (context, value, child) {
              print(dropdownValue);
              if(dropdownValue=="Pilih Bulan" || dropdownValue==null ){
                return Center(
                  child: Text("Pilih Bulan"),
                );
              } else {
                if(value.modelRekapAbsen==null){
                return Center(
                  child: CircularProgressIndicator(),
                );
              
              }
              else{
                if(value.modelRekapAbsen.data.length==0){
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
              DataColumn(label: Text("Kelas")),
              DataColumn(label: Text("Sakit")),
              DataColumn(label: Text("Izin")),
              DataColumn(label: Text("Absen")),
            ],
            
            rows: value.modelRekapAbsen.data.map<DataRow>((e) => DataRow(
                    cells: <DataCell>[
                      
                      DataCell(Text(e.nis)),
                      DataCell(Text(e.namaSiswa)),
                      DataCell(Text(e.kelas)),
                      DataCell(Text(e.sakit.toString())),
                      DataCell(Text(e.izin.toString())),
                      DataCell(Text(e.alfa.toString())),
                    ],
              ),).toList()
          ),
                  );
                }
              }
              }
            },
          )
        ),
      ),
              ],
            ),
          ),
        ),
      ),
    );
}
}