// To parse this JSON data, do
//
//     final modelJurusan = modelJurusanFromJson(jsonString);

import 'dart:convert';

ModelJurusan modelJurusanFromJson(String str) => ModelJurusan.fromJson(json.decode(str));

String modelJurusanToJson(ModelJurusan data) => json.encode(data.toJson());

class ModelJurusan {
    ModelJurusan({
        this.status,
        this.code,
        this.message,
        this.data,
    });

    bool status;
    int code;
    String message;
    List<Datum> data;

    factory ModelJurusan.fromJson(Map<String, dynamic> json) => ModelJurusan(
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
        this.idJurusan,
        this.namaJurusan,
        this.idSekolah,
    });

    String idJurusan;
    String namaJurusan;
    String idSekolah;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        idJurusan: json["id_jurusan"],
        namaJurusan: json["nama_jurusan"],
        idSekolah: json["id_sekolah"],
    );

    Map<String, dynamic> toJson() => {
        "id_jurusan": idJurusan,
        "nama_jurusan": namaJurusan,
        "id_sekolah": idSekolah,
    };
}
