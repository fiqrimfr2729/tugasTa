import 'dart:async';

import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:find_dropdown/find_dropdown.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:smk_losarangg/providers/p_bimbingan.dart';
import 'package:smk_losarangg/providers/p_users.dart';
import 'package:smk_losarangg/screen/chat_screen.dart';

class FormAlumni extends StatefulWidget {
  final String nis;

  const FormAlumni({Key key, this.nis}) : super(key: key);
  @override
  _FormAlumniState createState() => _FormAlumniState();
}

class _FormAlumniState extends State<FormAlumni> {
  String _myActivity;
  List<String> listDropdown = [
    'Politeknik Negeri Indramayu',
    'Institut Teknologi Bandung',
    'Perguruan Tinggi Swasta',
    'Lainnya'
  ];
  String dropdownValue;
  final formKey = new GlobalKey<FormState>();
  TextEditingController _controller = TextEditingController();
  TextEditingController _controllerTahun = TextEditingController();
  final RoundedLoadingButtonController _btnController =
      new RoundedLoadingButtonController();

  bool visibel=false;

  var status;
  var idUniv;

  void _doSomething() async {
    Timer(Duration(seconds: 3), () {
      _btnController.success();
    });
  }

  @override
  void initState() {
    initializeDateFormatting('id-ID');

    Provider.of<ProviderBimbingan>(context,listen: false).getUniv();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Form Alumi'),
        backgroundColor: Colors.amber,
      ),
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(), //buat scroll
        child: Center(
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left:20.0,right: 20.0,top:15.0),
                  child: FindDropdown(
                    items: ["Kerja", "Kuliah"],
                    label: "Pilih Status",
                    onChanged: (String item) {
                      if(item=="Kerja"){
                        setState(() {
                          visibel=false;
                          status=item;
                        });
                      }else{
                        setState(() {
                          visibel=true;
                          status=item;
                        });
                      }
                    },
                    selectedItem: "Kerja",
                    labelStyle: TextStyle(fontSize: 16),

                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left:20.0,right: 20.0,top:15.0),
                  child: Consumer<ProviderBimbingan>(builder: (context,data,_){
                    if(data.modelUniv==null){
                      return Center(child: CircularProgressIndicator(),);
                    }else{
                      return Visibility(
                        visible: visibel,
                        child: FindDropdown(

                          items: data.modelUniv.data.map((e) => e.namaUniversitas.toString()).toList(),
                          label: "Pilih Universitas",
                          onChanged: (String item) {
                            print(item);
                            setState(() {
//                              var univ=data.modelUniv.data.where((element) => element.namaUniversitas.toLowerCase()==item);
//                              print(univ);
                              data.modelUniv.data.forEach((element) {
                                if(element.namaUniversitas.toLowerCase()==item.toLowerCase()){
//                                  print(element.id);
                                idUniv=element.id;
                                }
                              });
                            });
                          },
                          selectedItem: data.modelUniv.data[0].namaUniversitas,
                          labelStyle: TextStyle(fontSize: 16),

                        ),
                      );
                    }
                  }),
                ),

                Padding(
                    padding: const EdgeInsets.only(right:20,left: 20,top: 10),
                    child: TextField(
                      controller: _controllerTahun,
                      cursorColor: Colors.amber,
                      cursorWidth: 3.0,
                      keyboardType: TextInputType.number,
                      style: TextStyle(height: 0.3),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        labelText: 'tahun lulus',
                        hintText: '2020',
                      ),
                    )),
                Padding(
                    padding: const EdgeInsets.all(25),
                    child: TextField(
                      controller: _controller,
                      cursorColor: Colors.amber,
                      cursorWidth: 3.0,
                      maxLines: 8,
                      style: TextStyle(height: 2.0),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25)),
                        labelText: 'Keterangan',
                        hintText: 'Nama Perusahaan/Jurusan/Lainnya',
                      ),
                    )),
                RoundedLoadingButton(
                  color: Colors.amber,
                  child: Text('Kirim', style: TextStyle(color: Colors.white)),
                  controller: _btnController,
                  onPressed: () async {

                    Provider.of<ProviderBimbingan>(context,listen: false).saveAlumni(
                      nis: widget.nis,
                      context: context,
                      status:  status,
                      keterangan: _controller.text,
                      tahun_lulus: _controllerTahun.text,
                      idUniv: idUniv

                    );
//                    if (dropdownValue.isEmpty || _controller.text.isEmpty) {
//                      Fluttertoast.showToast(
//                        msg: "Form tidak boleh ada yang kosong",
//                        textColor: Colors.white,
//                        toastLength: Toast.LENGTH_LONG,
//                        gravity: ToastGravity.TOP,
//                        backgroundColor: Colors.red,
//                      );
//                    } else {
//                      Provider.of<ProviderBimbingan>(context, listen: false)
//                          .tambahBimbingan(
//                              context: context,
//                              isiBimbingan: _controller.text,
//                              subject: dropdownValue);
//                    }

                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
