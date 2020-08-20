import 'dart:async';

import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:smk_losarangg/providers/p_bimbingan.dart';
import 'package:smk_losarangg/screen/chat_screen.dart';

class MulaiBimbingan extends StatefulWidget {
  @override
  _MulaiBimbinganState createState() => _MulaiBimbinganState();
}

class _MulaiBimbinganState extends State<MulaiBimbingan> {
  String _myActivity;
  List<String> listDropdown = ['Akademik', 'Sekolah', 'Pribadi'];
  String dropdownValue;
  final formKey = new GlobalKey<FormState>();
  TextEditingController _controller=TextEditingController();
  final RoundedLoadingButtonController _btnController =
      new RoundedLoadingButtonController();

  void _doSomething() async {
    Timer(Duration(seconds: 3), () {
      _btnController.success();


    });
  }

  @override
  void initState() {
    initializeDateFormatting('id-ID');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bimbingan'),
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
                        hint: Text('Pilih Kategori'),
                        onChanged: (String newValue) {
                          setState(() {
                            dropdownValue = newValue;
                          });
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
                        labelText: 'Isi Bimbingan',
                      ),
                    )),
                RoundedLoadingButton(
                  color: Colors.amber,
                  child: Text('Kirim', style: TextStyle(color: Colors.white)),
                  controller: _btnController,
                  onPressed: ()async{
                    if(dropdownValue.isEmpty || _controller.text.isEmpty){
                      Fluttertoast.showToast(msg: "Form tidak boleh ada yang kosong",textColor: Colors.white,
                      toastLength: Toast.LENGTH_LONG,
                        gravity: ToastGravity.TOP,
                        backgroundColor: Colors.red,
                      );
                    }else{
                      Provider.of<ProviderBimbingan>(context,listen: false).tambahBimbingan(
                        context: context,
                        isiBimbingan: _controller.text,
                        subject: dropdownValue
                      );
                    }
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
