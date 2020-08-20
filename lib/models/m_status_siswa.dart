// To parse this JSON data, do
//
//     final modelStatusSiswa = modelStatusSiswaFromJson(jsonString);

import 'dart:convert';

ModelStatusSiswa modelStatusSiswaFromJson(String str) => ModelStatusSiswa.fromJson(json.decode(str));

String modelStatusSiswaToJson(ModelStatusSiswa data) => json.encode(data.toJson());

class ModelStatusSiswa {
  ModelStatusSiswa({
    this.status,
    this.code,
    this.message,
    this.data,
  });

  bool status;
  int code;
  String message;
  List<Datum> data;

  factory ModelStatusSiswa.fromJson(Map<String, dynamic> json) => ModelStatusSiswa(
    status: json["status"],
    code: json["code"],
    message: json["message"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "code": code,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    this.idSiswa,
    this.nis,
    this.nisn,
    this.namaSiswa,
    this.jkSiswa,
    this.ttlSiswa,
    this.emailSiswa,
    this.alamatSiswa,
    this.noHp,
    this.foto,
    this.idJurusan,
    this.idKelas,
    this.idSekolah,
    this.idTingkatan,
    this.idUser,
    this.password,
    this.status,
    this.lastSeen,
    this.createdAt,
    this.updatedAt,
  });

  String idSiswa;
  String nis;
  String nisn;
  String namaSiswa;
  String jkSiswa;
  String ttlSiswa;
  String emailSiswa;
  String alamatSiswa;
  String noHp;
  String foto;
  String idJurusan;
  String idKelas;
  String idSekolah;
  String idTingkatan;
  String idUser;
  String password;
  String status;
  String lastSeen;
  DateTime createdAt;
  DateTime updatedAt;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    idSiswa: json["id_siswa"],
    nis: json["nis"],
    nisn: json["nisn"],
    namaSiswa: json["nama_siswa"],
    jkSiswa: json["jk_siswa"],
    ttlSiswa: json["ttl_siswa"],
    emailSiswa: json["email_siswa"],
    alamatSiswa: json["alamat_siswa"],
    noHp: json["no_hp"],
    foto: json["foto"],
    idJurusan: json["id_jurusan"],
    idKelas: json["id_kelas"],
    idSekolah: json["id_sekolah"],
    idTingkatan: json["id_tingkatan"],
    idUser: json["id_user"],
    password: json["password"],
    status: json["status"],
    lastSeen: json["last_seen"],
//    createdAt: DateTime.parse(json["created_at"]),
//    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id_siswa": idSiswa,
    "nis": nis,
    "nisn": nisn,
    "nama_siswa": namaSiswa,
    "jk_siswa": jkSiswa,
    "ttl_siswa": ttlSiswa,
    "email_siswa": emailSiswa,
    "alamat_siswa": alamatSiswa,
    "no_hp": noHp,
    "foto": foto,
    "id_jurusan": idJurusan,
    "id_kelas": idKelas,
    "id_sekolah": idSekolah,
    "id_tingkatan": idTingkatan,
    "id_user": idUser,
    "password": password,
    "status": status,
    "last_seen": lastSeen,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
