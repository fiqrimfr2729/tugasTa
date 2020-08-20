import 'package:dio/dio.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ndialog/ndialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smk_losarangg/api-services/api.dart';
import 'package:smk_losarangg/models/m_guru_bp.dart';
import 'package:smk_losarangg/models/m_status_siswa.dart';
import 'package:smk_losarangg/screen/guru/guru_home.dart';
import 'package:smk_losarangg/screen/siswa/siswa_home.dart';

class ProviderUsers extends ChangeNotifier {
  Dio dio;

  bool _loadingLoading = true;
  int _codeAPiLogin;
  String _messageApiLogin;

  bool get loadingLoading => _loadingLoading;

  set loadingLoading(bool value) {
    _loadingLoading = value;
  }

  int get codeAPiLogin => _codeAPiLogin;

  set codeAPiLogin(int value) {
    _codeAPiLogin = value;
  }

  String get messageApiLogin => _messageApiLogin;

  set messageApiLogin(String value) {
    _messageApiLogin = value;
    notifyListeners();
  }

  Future<bool> login(
      {BuildContext context, String nis, String password}) async {
    bool result = false;
    dio = new Dio();
    Response response;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    ProgressDialog pg = new ProgressDialog(context, message: Text("Loading.."));
    pg.show();
    response = await dio
        .post(ApiServer.login, data: {"nis": "$nis", "password": "$password"});
    if (response.statusCode == 200) {
      pg.dismiss();
      loadingLoading = false;
      if (response.data['code'] == 200) {
        prefs.setString('role', response.data['data']['role'].toString());
        if (response.data['data']['role'] == 'siswa') {
          prefs.setString('id_siswa',
              response.data['data']['detail_data']['id_siswa'].toString());
          prefs.setString(
              'nis', response.data['data']['detail_data']['nis'].toString());
          prefs.setString(
              'nisn', response.data['data']['detail_data']['nisn'].toString());
          prefs.setString(
              'nama_siswa', response.data['data']['detail_data']['nama_siswa']);
          prefs.setString(
              'jk_siswa', response.data['data']['detail_data']['jk_siswa']);
          prefs.setString('ttl_siswa',
              response.data['data']['detail_data']['ttl_siswa'].toString());
          prefs.setString('email_siswa',
              response.data['data']['detail_data']['email_siswa']);
          prefs.setString('alamat_siswa',
              response.data['data']['detail_data']['alamat_siswa']);
          prefs.setString('no_hp',
              response.data['data']['detail_data']['no_hp'].toString());
          prefs.setString(
              'foto', response.data['data']['detail_data']['foto'].toString());
          prefs.setString('id_user',
              response.data['data']['detail_data']['id_user'].toString());
          prefs.setString('nama_jurusan',
              response.data['data']['detail_data']['nama_jurusan'].toString());
          prefs.setString('nama_kelas',
              response.data['data']['detail_data']['nama_kelas'].toString());
          prefs.setString('nama_sekolah',
              response.data['data']['detail_data']['nama_sekolah']);
          prefs.setString(
              'nama_tingkatan',
              response.data['data']['detail_data']['nama_tingkatan']
                  .toString());
          prefs.setString(
              'id_tingkatan',
              response.data['data']['detail_data']['id_tingkatan']
                  .toString());
          prefs.setString('alamat_sekolah',
              response.data['data']['detail_data']['alamat_sekolah']);
          prefs.setString(
              'tingkatan', response.data['data']['detail_data']['tingkatan']);
          prefs.setString('id_sekolah',
              response.data['data']['detail_data']['id_sekolah'].toString());
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => HomePage()));
          return true;
        } else {
          prefs.setString("id_guru",
              response.data['data']['detail_data']['id_guru'].toString());
          prefs.setString("nama_guru",
              response.data['data']['detail_data']['nama_guru'].toString());
          prefs.setString("alamat_guru",
              response.data['data']['detail_data']['alamat_guru'].toString());
          prefs.setString("email_guru",
              response.data['data']['detail_data']['email_guru'].toString());
          prefs.setString(
              "nik", response.data['data']['detail_data']['nik'].toString());
          prefs.setString(
              "nik", response.data['data']['detail_data']['nik'].toString());
          prefs.setString("id_user",
              response.data['data']['detail_data']['id_user'].toString());
          prefs.setString("id_sekolah",
              response.data['data']['detail_data']['id_sekolah'].toString());
          prefs.setString("nama_sekolah",
              response.data['data']['detail_data']['nama_sekolah'].toString());
          prefs.setString("nama_jabatan",
              response.data['data']['detail_data']['nama_jabatan'].toString());
          prefs.setString(
              'id_tingkatan',
              response.data['data']['detail_data']['id_tingkatan']
                  .toString());
          prefs.setString(
              'tingkatan', response.data['data']['detail_data']['tingkatan']);
          prefs.setString(
              "alamat_sekolah",
              response.data['data']['detail_data']['alamat_sekolah']
                  .toString());
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => PageHome()));
        }
      } else {
        Flushbar(
          message: "Username atau Password salah!",
          icon: Icon(
            Icons.info_outline,
            size: 28.0,
            color: Colors.blue[300],
          ),
          duration: Duration(seconds: 3),
          leftBarIndicatorColor: Colors.blue[300],
        )..show(context);
      }
    }
  }

  ModelGuruBk _modelGuruBk;

  ModelGuruBk get modelGuruBk => _modelGuruBk;

  set modelGuruBk(ModelGuruBk value) {
    _modelGuruBk = value;
    notifyListeners();
  }

  Future<ModelGuruBk> getGuruBK() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var idSekolah = pref.get('id_sekolah');
    var tingkatan = pref.get('id_tingkatan');
    dio = new Dio();
    print("sad");
    Response response;
    String url = "${ApiServer.getGuruBK}/$idSekolah";

    response = await dio.get(url, queryParameters: {"id_tingkatan": "$tingkatan"});

    if (response.statusCode == 200) {
      modelGuruBk = ModelGuruBk.fromJson(response.data);
    }

    return modelGuruBk;
  }

  Future<bool> updateStatus({String status}) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var idUser = pref.get("id_user");

    dio = new Dio();
    Response response;
    response = await dio.post(ApiServer.updateStatus,
        queryParameters: {"id_user": "$idUser"}, data: {"status": "$status"});
    return true;
  }

  ModelStatusSiswa _modelStatusSiswa;

  ModelStatusSiswa get modelStatusSiswa => _modelStatusSiswa;

  set modelStatusSiswa(ModelStatusSiswa value) {
    _modelStatusSiswa = value;
    notifyListeners();
  }

  Future<ModelStatusSiswa> getStatusSiswa(
      {BuildContext context, String idUser}) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var idSekolah = pref.get('id_sekolah');
    dio = new Dio();
    print("fasfdsf");
    Response response;
    String url = "${ApiServer.updateStatusSiswa}/$idUser";

    response = await dio.get(url);
    print(response.data);
    if (response.statusCode == 200) {
      modelStatusSiswa = ModelStatusSiswa.fromJson(response.data);
    }

    return modelStatusSiswa;
  }

  Future<bool> updateToken({String token_firebase}) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var id_user = pref.get("id_user");
    dio = new Dio();
    print("sad");
    Response response;
    String url = "${ApiServer.updateToken}";

    response = await dio.post(url,
        queryParameters: {"id_user": "$id_user"},
        data: {"token_firebase": "$token_firebase"});
    return true;
  }

  Future<bool> sendNotif({String to, String title, String message}) async {
    dio = new Dio();
    Response response;
    String url = "${ApiServer.sendNotif}";

    response = await dio.post(url,
        data: {"title": "$title", "to": "$to", "message": "$message"});
    return true;
  }

  Future<bool> updatePassword({BuildContext context, String password}) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var id_user = pref.get("id_user");
    dio = new Dio();
    print("sad");
    Response response;
    String url = "${ApiServer.editPassword}";
    response = await dio
        .post(url, data: {"id_user": "$id_user", "password": "$password"});
    Navigator.pop(context); // buat ke halaman profil
    Flushbar(
      message: "Password berhasil diganti",
      icon: Icon(
        Icons.info_outline,
        size: 28.0,
        color: Colors.blue[300],
      ),
      duration: Duration(seconds: 3),
      leftBarIndicatorColor: Colors.blue[300],
    )..show(context);

    return true;
  }
}
