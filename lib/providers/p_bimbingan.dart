import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:ndialog/ndialog.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smk_losarangg/api-services/api.dart';
import 'package:smk_losarangg/models/m_absen.dart';
import 'package:smk_losarangg/models/m_data_absen.dart';
import 'package:smk_losarangg/models/m_jurusan.dart';
import 'package:smk_losarangg/models/m_kelas.dart';
import 'package:smk_losarangg/models/m_komentar.dart';
import 'package:smk_losarangg/models/m_list_bimbingan.dart';
import 'package:smk_losarangg/models/m_list_bimbingan_guru.dart';
import 'package:smk_losarangg/models/m_list_chat.dart';
import 'package:smk_losarangg/models/m_list_pengumuman.dart';
import 'package:smk_losarangg/models/m_rekapabsen.dart';
import 'package:smk_losarangg/models/m_siswa.dart';
import 'package:smk_losarangg/providers/p_users.dart';
import 'package:smk_losarangg/screen/chat_screen.dart';
import 'package:smk_losarangg/screen/pemberitahuan.dart';
import 'package:smk_losarangg/screen/siswa/v_chat_room.dart';

class ProviderBimbingan extends ChangeNotifier {
  Dio dio;

  bool _loadingbimbingan = true;
  int _codeAPibim;
  String _messageApibim;

  ModelBimbingan _modelBimbingan;

  bool get loadingbimbingan => _loadingbimbingan;

  set loadingbimbingan(bool value) {
    _loadingbimbingan = value;
  }

  int get codeAPibim => _codeAPibim;

  set codeAPibim(int value) {
    _codeAPibim = value;
  }

  String get messageApibim => _messageApibim;

  set messageApibim(String value) {
    _messageApibim = value;
    notifyListeners();
  }

  ModelBimbingan get modelBimbingan => _modelBimbingan;

  set modelBimbingan(ModelBimbingan value) {
    _modelBimbingan = value;
    notifyListeners();
  }

  Future<ModelBimbingan> getListBimbingan() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var nis = pref.get("nis");
    String url = "${ApiServer.getBimbingan}/$nis";
    Response response;
    dio = new Dio();
    response = await dio.get(url);
    if (response.statusCode == 200) {
      loadingbimbingan = false;
      modelBimbingan = ModelBimbingan.fromJson(response.data);
    }
    return modelBimbingan;
  }

  ModelBimbinganGuru _modelBimbinganGuru;

  ModelBimbinganGuru get modelBimbinganGuru => _modelBimbinganGuru;

  set modelBimbinganGuru(ModelBimbinganGuru value) {
    _modelBimbinganGuru = value;
    notifyListeners();
  }

  Future<ModelBimbinganGuru> getListBimbinganGuru() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var nis = pref.get("id_sekolah");
    var tingkatan = pref.get("id_tingkatan");
    String url = "${ApiServer.getBimbinganGuru}/$nis";
    Response response;
    dio = new Dio();
    response = await dio.get(url, queryParameters: {
      "id_tingkatan" : "$tingkatan"
    });
    if (response.statusCode == 200) {
      loadingbimbingan = false;
      modelBimbinganGuru = ModelBimbinganGuru.fromJson(response.data);
    }
    return modelBimbinganGuru;
  }

  Future<bool> tambahBimbingan(
      {BuildContext context, String subject, String isiBimbingan}) async {
    bool result = false;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var nis = prefs.get("nis");
    var idSekolah = prefs.get("id_sekolah");
    var nik;
    Provider.of<ProviderUsers>(context, listen: false)
        .getGuruBK()
        .then((value) {
      nik = value.data[0].nik;
    });

    ProgressDialog pg = new ProgressDialog(context, message: Text("Loading"));
    pg.show();
    initializeDateFormatting('id-ID');
    var tgl = DateFormat('yyyy-MM-dd', 'id-ID').format(DateTime.now());
    var id_tingkatan = prefs.get('id_tingkatan');
    print(tgl);
    dio = new Dio();
    Response response;
    response = await dio.post(ApiServer.tambahBimbingan, data: {
      "nis": "$nis",
      "subject": "$subject",
      "isi_bim": "$isiBimbingan",
      "tgl_bim": "$tgl",
      "id_tingkatan": "$id_tingkatan",
      "id_sekolah": "$idSekolah",
      "timestamps": "${DateTime.now().millisecondsSinceEpoch.toString()}"
    });
    print(response.data);
    if (response.statusCode == 200) {
      pg.dismiss();
      if (response.data['code'] == 200) {
        Fluttertoast.showToast(
            msg: "Data Bimbingan Berhasil dibuat",
            backgroundColor: Colors.green,
            gravity: ToastGravity.TOP,
            toastLength: Toast.LENGTH_SHORT,
            textColor: Colors.white);
        Provider.of<ProviderUsers>(context, listen: false)
            .getGuruBK()
            .then((res) {
          Provider.of<ProviderBimbingan>(context, listen: false)
              .getListBimbingan()
              .then((value) {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => ViewChatRoom(
                          isiBimbingan: isiBimbingan,
                          idBimbigan: response.data['data'].toString(),
                          peerId: nik.toString(),
                          isSiswa: true,
                          idUser: res.data[0].idUser.toString(),
                        )));
          });
        });
      } else {
        Fluttertoast.showToast(
            msg: "Data Bimbingan gagal dibuat",
            backgroundColor: Colors.red,
            gravity: ToastGravity.TOP,
            toastLength: Toast.LENGTH_SHORT,
            textColor: Colors.white);
        Navigator.pop(context);
      }
    }

    return result;
  }

  Future<bool> updateStatusBimbingan(
      {BuildContext context, String idBimbingan, bool isSiswa = false}) async {
    bool result = true;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var nis = prefs.get("nis");

    initializeDateFormatting('id-ID');
    var tgl = DateFormat('yyyy-MM-dd', 'id-ID').format(DateTime.now());
    print(tgl);
    dio = new Dio();
    Response response;
    String url = "${ApiServer.updateStatusBimbingan}/$idBimbingan";
    if (isSiswa == false) {
      response = await dio.post(url);
    } else {
      response = await dio.post(url, queryParameters: {"isSiswa": "true"});
    }
    print(response.data);

    return result;
  }

  ModelListChat _modelListChat;

  ModelListChat get modelListChat => _modelListChat;

  set modelListChat(ModelListChat value) {
    _modelListChat = value;
    notifyListeners();
  }

  Future<ModelListChat> getListChat(
      {String nikGuru,
      String nis,
      bool guru = false,
      String idBimbingan}) async {
    dio = new Dio();
    SharedPreferences pref = await SharedPreferences.getInstance();

    Response response;
    response = await dio.get(ApiServer.listChat,
        queryParameters: {"id_bimbingan": "$idBimbingan"});

    if (response.statusCode == 200) {
      modelListChat = ModelListChat.fromJson(response.data);
    }

    return modelListChat;
  }

  //ini
  ModelListPengumuman _modelListPengumuman;
  ModelListPengumuman get modelListPengumuman => _modelListPengumuman;
  set modelListPengumuman(ModelListPengumuman value) {
    _modelListPengumuman = value;
    notifyListeners();
  }
  Future<ModelListPengumuman> getListPengumuman() async {
    dio = new Dio();

    SharedPreferences pref = await SharedPreferences.getInstance();
    var id_sekolah = pref.get('id_sekolah');
    Response response;
    response = await dio.get(ApiServer.listPengumuman,
        queryParameters: {"id_sekolah": "$id_sekolah"});

    if (response.statusCode == 200) {
      modelListPengumuman = ModelListPengumuman.fromJson(response.data);
    }

    return modelListPengumuman;
  }


  ModelKomentar _komentar; //yang ada _ itu privat
  ModelKomentar get komentar => _komentar;
  set komentar(ModelKomentar value) {
    _komentar = value;
    notifyListeners();
  }
  Future<ModelKomentar> getListKomentar({String idPengumuman}) async {
    dio = new Dio();

    SharedPreferences pref = await SharedPreferences.getInstance();
   
    Response response;
    response = await dio.get(ApiServer.komentar,
        queryParameters: {"id_pengumuman": "$idPengumuman"});

    if (response.statusCode == 200) {
      komentar = ModelKomentar.fromJson(response.data);
    }

    return komentar;
  }



  Future<bool> sendChat(
      {String idBimbigan,
      String nik,
      String nis,
      String content,
      String senderId}) async {
    String url = "${ApiServer.sendChat}/$idBimbigan";

    dio = new Dio();
    Response response;
    response = await dio.post(url, data: {
      "nik": "$nik",
      "nis": "$nis",
      "content": "$content",
      "sender_id": "$senderId"
    });

    if (response.statusCode == 200) {}

    return true;
  }

  Future<bool> addKomentar(
      {String idPengumuman,
      String isiKomentar
      }) async {
    String url = "${ApiServer.addKomentar}";
    SharedPreferences pref = await SharedPreferences.getInstance();
    var idUser=pref.get('id_user');

    dio = new Dio();
    Response response;
    response = await dio.post(url, data: {
      "id_pengumuman": "$idPengumuman",
      "isi_komentar": "$isiKomentar",
      "id_user": "$idUser"
    });

    if (response.statusCode == 200) {}

    return true;
  }

  Future<bool> addPengumuman(
      {String isiPengumuman,
      File file,
      BuildContext context,
      }) async {
    String url = "${ApiServer.pengumuman}";
    SharedPreferences pref = await SharedPreferences.getInstance();
    var idUser=pref.get('id_user');
    var idSekolah=pref.get('id_sekolah');
    ProgressDialog pg = new ProgressDialog(context, message: Text("Menyimpan"),dismissable: false);
    pg.show();
    dio = new Dio();
    Response response;
   if(file.path.isEmpty){
      response = await dio.post(url, data: {
      
      "isi_pengumuman": "$isiPengumuman",
      "id_sekolah": "$idSekolah",


      "id_user": "$idUser"
    });

   } else {
     var formdata = FormData.fromMap({
      "isi_pengumuman": "$isiPengumuman",
      "id_sekolah": "$idSekolah",
      "id_user" : "$idUser",
      "file": await MultipartFile.fromFile(file.path.toString(),
          filename: file.path.split("/").last.toString()),
    });

    response=await dio.post(url, data: formdata);
   }
    if (response.statusCode == 200) {
      pg.dismiss();
      Provider.of<ProviderBimbingan>(context, listen: false).getListPengumuman();
      Navigator.pop(context);
    }

    return true;
  }

  ModelAbsen _modelAbsen;

  ModelAbsen get modelAbsen => _modelAbsen;

  set modelAbsen(ModelAbsen value) {
    _modelAbsen = value;
    notifyListeners();
  }

  Future<ModelAbsen> getAbsen(
      ) async {
    dio = new Dio();
    SharedPreferences pref = await SharedPreferences.getInstance();
    var nis=pref.get('nis');
    Response response;
    var url=ApiServer.getAbsen+"/$nis";
    response = await dio.get(url);

    if (response.statusCode == 200) {
      modelAbsen = ModelAbsen.fromJson(response.data);
    }

    return modelAbsen;
  }

  ModelKelas _modelKelas;

  ModelKelas get modelKelas => _modelKelas;

  set modelKelas(ModelKelas value) {
    _modelKelas = value;
    notifyListeners();
  }

  Future<ModelKelas> getKelas(
      ) async {
    dio = new Dio();
    SharedPreferences pref = await SharedPreferences.getInstance();
    var id_sekolah=pref.get('id_sekolah');
    Response response;
    var url=ApiServer.getKelas;
    response = await dio.get(url, queryParameters: {
      "id_sekolah": "$id_sekolah"
    });

    if (response.statusCode == 200) {
      modelKelas = ModelKelas.fromJson(response.data);
    }

    return modelKelas;
  }

  ModelDataAbsen _modelDataAbsen;

  ModelDataAbsen get modelDataAbsen => _modelDataAbsen;

  set modelDataAbsen(ModelDataAbsen value) {
    _modelDataAbsen = value;
    notifyListeners();
  }

  Future<ModelDataAbsen> getDataAbsen({String idKelas, String tanggal}) async {
    dio = new Dio();
    SharedPreferences pref = await SharedPreferences.getInstance();
    
    Response response;
    var url=ApiServer.getDataAbsen;
    response = await dio.get(url, queryParameters: {
      "id_kelas": "$idKelas",//yang pertama itu ngkutin data base
      "tanggal": "$tanggal"
    });

    if (response.statusCode == 200) {
      modelDataAbsen = ModelDataAbsen.fromJson(response.data);
    }

    return modelDataAbsen;
  }

  ModelRekapAbsen _modelRekapAbsen;

  ModelRekapAbsen get modelRekapAbsen => _modelRekapAbsen;

  set modelRekapAbsen(ModelRekapAbsen value) {
    _modelRekapAbsen = value;
    notifyListeners();
  }

  Future<ModelRekapAbsen> getRekapAbsen({String year, String month}) async {
    dio = new Dio();
    SharedPreferences pref = await SharedPreferences.getInstance();
    var idSekolah= pref.get("id_sekolah");
    Response response;
    var url=ApiServer.getRekapAbsen;
    response = await dio.get(url, queryParameters: {
      "id_sekolah": "$idSekolah",//yang pertama itu ngkutin data base
      "year": "$year",
      "month": "$month"
    });

    if (response.statusCode == 200) {
      modelRekapAbsen = ModelRekapAbsen.fromJson(response.data);
    }

    return modelRekapAbsen;
  }

  ModelJurusan _modelJurusan;

  ModelJurusan get modelJurusan => _modelJurusan;

  set modelJurusan(ModelJurusan value) {
    _modelJurusan = value;
    notifyListeners();
  }

  Future<ModelJurusan> getJurusan() async {
    dio = new Dio();
    SharedPreferences pref = await SharedPreferences.getInstance();
    var idSekolah= pref.get("id_sekolah");
    Response response;
    var url=ApiServer.getJurusan;
    response = await dio.get(url, queryParameters: {
      "id_sekolah": "$idSekolah",//yang pertama itu ngkutin data base
    });

    if (response.statusCode == 200) {
      modelJurusan = ModelJurusan.fromJson(response.data);
    }

    return modelJurusan;
  }

  ModelSiswa _modelSiswa;

  ModelSiswa get modelSiswa => _modelSiswa;

  set modelSiswa(ModelSiswa value) {
    _modelSiswa = value;
    notifyListeners();
  }

  Future<ModelSiswa> getSiswa({String idKelas}) async {
    dio = new Dio();
    SharedPreferences pref = await SharedPreferences.getInstance();
    var idSekolah= pref.get("id_sekolah");
    Response response;
    var url=ApiServer.getSiswa;
    response = await dio.get(url, queryParameters: {
      "id_sekolah": "$idSekolah",
      "id_kelas": "$idKelas"//yang pertama itu ngkutin data base
    });

    if (response.statusCode == 200) {
      modelSiswa = ModelSiswa.fromJson(response.data);
    }

    return modelSiswa;
  }
}
