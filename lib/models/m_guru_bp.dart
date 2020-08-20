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
    this.password,
    this.status,
    this.lastSeen,
    this.createdAt,
    this.updatedAt,
    this.namaJabatan,
  });

  String idGuru;
  String namaGuru;
  String alamatGuru;
  String emailGuru;
  String nik;
  String idJabatan;
  String idUser;
  String idSekolah;
  String password;
  String status;
  dynamic lastSeen;
  DateTime createdAt;
  DateTime updatedAt;
  String namaJabatan;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    idGuru: json["id_guru"].toString(),
    namaGuru: json["nama_guru"],
    alamatGuru: json["alamat_guru"],
    emailGuru: json["email_guru"],
    nik: json["nik"].toString(),
    idJabatan: json["id_jabatan"].toString(),
    idUser: json["id_user"],
    idSekolah: json["id_sekolah"].toString(),
    password: json["password"],
    status: json["status"],
    lastSeen: json["last_seen"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    namaJabatan: json["nama_jabatan"],
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
    "password": password,
    "status": status,
    "last_seen": lastSeen,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "nama_jabatan": namaJabatan,
  };
}
