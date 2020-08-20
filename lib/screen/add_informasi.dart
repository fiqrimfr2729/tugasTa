import 'dart:async';
import 'dart:io';

import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:smk_losarangg/providers/p_bimbingan.dart';
import 'package:smk_losarangg/screen/chat_screen.dart';

class TambahInformasi extends StatefulWidget {
  @override
  _TambahInformasiState createState() => _TambahInformasiState();
}

class _TambahInformasiState extends State<TambahInformasi> {
  String _myActivity;

  final formKey = new GlobalKey<FormState>();
  TextEditingController _controller = TextEditingController();
  final RoundedLoadingButtonController _btnController =
      new RoundedLoadingButtonController();
      String path;
      String name_file;
      String ekstensi;

  File img;

  void _doSomething() async {
    Timer(Duration(seconds: 3), () {
      _btnController.success();
    });
  }

  void filePicker() async {
    _image = await FilePicker.getFile();
    setState(() {
      img=File(_image.path);
      path=_image.path;
      name_file=path.split("/").last;
      ekstensi=name_file.split(".").last;
      print(ekstensi);
    });
  }

  void showBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: 120,
          child: Column(
            children: <Widget>[
              ListTile(
                onTap: () {
                  getImage(ImageSource.camera);
                },
                leading: Icon(Icons.camera),
                title: Text("Ambil Gambar dari Kamera"),
              ),
              ListTile(
                onTap: () {
                  getImage(ImageSource.gallery);
                },
                leading: Icon(Icons.photo),
                title: Text("Ambil Gambar dari Galeri"),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void initState() {
    initializeDateFormatting('id-ID');
    super.initState();
  }

  File _image;
  final picker = ImagePicker();

  Future getImage(ImageSource imageSource) async {
    final pickedFile = await picker.getImage(source: imageSource);

    setState(() {
      _image = File(pickedFile.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah Informasi'),
        backgroundColor: Colors.amber,
        actions: <Widget>[
          FlatButton(
              onPressed: () {
                Provider.of<ProviderBimbingan>(context, listen: false)
                    .addPengumuman(
                        isiPengumuman: _controller.text,
                        file: _image,
                        context: context);
              },
              child: Text(
                "Kirim",
                style: TextStyle(fontSize: 18, color: Colors.white),
              ))
        ],
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
                        labelText: 'Detail Informasi',
                      ),
                    )),
                Center(
                  child: _image == null
                      ? Text('Tidak ada file yang dipilih.')
                      : ekstensi.toLowerCase() == "jpg" || ekstensi.toLowerCase() == "jpeg" || ekstensi.toLowerCase() == "png" ? Image.file(
                          img,
                          height: 250,
                          width: 250,
                        ) : Text(name_file)
                ) ,
                FlatButton(
                  onPressed: filePicker,
                  child: Text(
                    "Tambah File",
                    style: TextStyle(color: Colors.white),
                  ),
                  color: Colors.amber,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
