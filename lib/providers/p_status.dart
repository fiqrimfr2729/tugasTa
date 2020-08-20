import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smk_losarangg/api-services/api.dart';
import 'package:smk_losarangg/models/m_status_siswa.dart';

class UserStatus{
  ModelStatusSiswa _modelStatusSiswa;

  ModelStatusSiswa get modelStatusSiswa => _modelStatusSiswa;

  set modelStatusSiswa(ModelStatusSiswa value) {
    _modelStatusSiswa = value;

  }

  Future<ModelStatusSiswa> getStatusSiswa({BuildContext context,String idUser})async{
    SharedPreferences pref=await SharedPreferences.getInstance();
    var idSekolah=pref.get('id_sekolah');
    var dio=new Dio();
    print("fasfdsf");
    Response response;
    String url="${ApiServer.updateStatusSiswa}/$idUser";

    response = await dio.get(url);
    print(response.data);
    if(response.statusCode==200){
      modelStatusSiswa=ModelStatusSiswa.fromJson(response.data);

    }

    return modelStatusSiswa;
  }
}