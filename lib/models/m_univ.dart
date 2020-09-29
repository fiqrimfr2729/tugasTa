// To parse this JSON data, do
//
//     final modelUniv = modelUnivFromJson(jsonString);

import 'dart:convert';

ModelUniv modelUnivFromJson(String str) => ModelUniv.fromJson(json.decode(str));

String modelUnivToJson(ModelUniv data) => json.encode(data.toJson());

class ModelUniv {
  ModelUniv({
    this.status,
    this.code,
    this.message,
    this.data,
  });

  bool status;
  int code;
  String message;
  List<Datum> data;

  factory ModelUniv.fromJson(Map<String, dynamic> json) => ModelUniv(
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
    this.id,
    this.namaUniversitas,
  });

  String id;
  String namaUniversitas;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    namaUniversitas: json["nama_universitas"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "nama_universitas": namaUniversitas,
  };
}
