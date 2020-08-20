// To parse this JSON data, do
//
//     final modelRekapAbsen = modelRekapAbsenFromJson(jsonString);

import 'dart:convert';

ModelRekapAbsen modelRekapAbsenFromJson(String str) => ModelRekapAbsen.fromJson(json.decode(str));

String modelRekapAbsenToJson(ModelRekapAbsen data) => json.encode(data.toJson());

class ModelRekapAbsen {
    ModelRekapAbsen({
        this.status,
        this.code,
        this.message,
        this.data,
    });

    bool status;
    int code;
    String message;
    List<Datum> data;

    factory ModelRekapAbsen.fromJson(Map<String, dynamic> json) => ModelRekapAbsen(
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
        this.nis,
        this.namaSiswa,
        this.kelas,
        this.sakit,
        this.izin,
        this.alfa,
    });

    String nis;
    String namaSiswa;
    String kelas;
    int sakit;
    int izin;
    int alfa;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        nis: json["nis"],
        namaSiswa: json["nama_siswa"],
        kelas: json["kelas"],
        sakit: json["sakit"],
        izin: json["izin"],
        alfa: json["alfa"],
    );

    Map<String, dynamic> toJson() => {
        "nis": nis,
        "nama_siswa": namaSiswa,
        "kelas": kelas,
        "sakit": sakit,
        "izin": izin,
        "alfa": alfa,
    };
}
