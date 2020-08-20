// To parse this JSON data, do
//
//     final modelAbsen = modelAbsenFromJson(jsonString);

import 'dart:convert';

ModelAbsen modelAbsenFromJson(String str) => ModelAbsen.fromJson(json.decode(str));

String modelAbsenToJson(ModelAbsen data) => json.encode(data.toJson());

class ModelAbsen {
    ModelAbsen({
        this.status,
        this.code,
        this.message,
        this.data,
    });

    bool status;
    int code;
    String message;
    List<Datum> data;

    factory ModelAbsen.fromJson(Map<String, dynamic> json) => ModelAbsen(
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
        this.idAbsensi,
        this.nis,
        this.tanggal,
        this.keterangan,
        this.idJurusan,
    });

    String idAbsensi;
    String nis;
    DateTime tanggal;
    String keterangan;
    String idJurusan;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        idAbsensi: json["id_absensi"],
        nis: json["NIS"],
        tanggal: DateTime.parse(json["tanggal"]),
        keterangan: json["Keterangan"],
        idJurusan: json["id_jurusan"],
    );

    Map<String, dynamic> toJson() => {
        "id_absensi": idAbsensi,
        "NIS": nis,
        "tanggal": "${tanggal.year.toString().padLeft(4, '0')}-${tanggal.month.toString().padLeft(2, '0')}-${tanggal.day.toString().padLeft(2, '0')}",
        "Keterangan": keterangan,
        "id_jurusan": idJurusan,
    };
}