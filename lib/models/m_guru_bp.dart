// To parse this JSON data, do
//
//     final modelGuruBk = modelGuruBkFromJson(jsonString);

import 'dart:convert';

ModelGuruBk modelGuruBkFromJson(String str) => ModelGuruBk.fromJson(json.decode(str));

String modelGuruBkToJson(ModelGuruBk data) => json.encode(data.toJson());

class ModelGuruBk {
  ModelGuruBk({
    this.status,
    this.code,
    this.message,
    this.data,
  });

  bool status;
  int code;
  String message;
  List<Datum> data;

  factory ModelGuruBk.fromJson(Map<String, dynamic> json) => ModelGuruBk(
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
    this.idGuru,
    this.namaGuru,
    this.alamatGuru,
    this.emailGuru,
    this.nik,
    this.idJabatan,
    this.idUser,
    this.idSekolah,
    this.idTingkatan,
    this.tokenFirebase,
    this.password,
    this.status,
    this.lastSeen,
    this.createdAt,
    this.updatedAt,
    this.namaJabatan,
    this.namaTingkatan,
    this.tingkatan,
    this.idJurusan,
  });

  String idGuru;
  String namaGuru;
  String alamatGuru;
  String emailGuru;
  String nik;
  String idJabatan;
  String idUser;
  String idSekolah;
  String idTingkatan;
  String tokenFirebase;
  String password;
  String status;
  DateTime lastSeen;
  DateTime createdAt;
  DateTime updatedAt;
  String namaJabatan;
  String namaTingkatan;
  String tingkatan;
  String idJurusan;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    idGuru: json["id_guru"],
    namaGuru: json["nama_guru"],
    alamatGuru: json["alamat_guru"],
    emailGuru: json["email_guru"],
    nik: json["nik"],
    idJabatan: json["id_jabatan"],
    idUser: json["id_user"],
    idSekolah: json["id_sekolah"],
    idTingkatan: json["id_tingkatan"],
    tokenFirebase: json["token_firebase"],
    password: json["password"],
    status: json["status"],
    lastSeen: DateTime.parse(json["last_seen"]),
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    namaJabatan: json["nama_jabatan"],
    namaTingkatan: json["nama_tingkatan"],
    tingkatan: json["tingkatan"],
    idJurusan: json["id_jurusan"],
  );

  Map<String, dynamic> toJson() => {
    "id_guru": idGuru,
    "nama_guru": namaGuru,
    "alamat_guru": alamatGuru,
    "email_guru": emailGuru,
    "nik": nik,
    "id_jabatan": idJabatan,
    "id_user": idUser,
    "id_sekolah": idSekolah,
    "id_tingkatan": idTingkatan,
    "token_firebase": tokenFirebase,
    "password": password,
    "status": status,
    "last_seen": lastSeen.toIso8601String(),
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "nama_jabatan": namaJabatan,
    "nama_tingkatan": namaTingkatan,
    "tingkatan": tingkatan,
    "id_jurusan": idJurusan,
  };
}
