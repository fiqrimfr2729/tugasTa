// To parse this JSON data, do
//
//     final modelKelas = modelKelasFromJson(jsonString);

import 'dart:convert';

ModelKelas modelKelasFromJson(String str) => ModelKelas.fromJson(json.decode(str));

String modelKelasToJson(ModelKelas data) => json.encode(data.toJson());

class ModelKelas {
    ModelKelas({
        this.status,
        this.code,
        this.message,
        this.data,
    });

    bool status;
    int code;
    String message;
    List<Datum> data;

    factory ModelKelas.fromJson(Map<String, dynamic> json) => ModelKelas(
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
        this.idKelas,
        this.namaKelas,
        this.idJurusan,
        this.totalSiswa,
    });

    String idKelas;
    String namaKelas;
    String idJurusan;
    int totalSiswa;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        idKelas: json["id_kelas"],
        namaKelas: json["nama_kelas"],
        idJurusan: json["id_jurusan"],
        totalSiswa: json["total_siswa"],
    );

    Map<String, dynamic> toJson() => {
        "id_kelas": idKelas,
        "nama_kelas": namaKelas,
        "id_jurusan": idJurusan,
        "total_siswa": totalSiswa,
    };
}
