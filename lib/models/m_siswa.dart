// To parse this JSON data, do
//
//     final modelSiswa = modelSiswaFromJson(jsonString);

import 'dart:convert';

ModelSiswa modelSiswaFromJson(String str) => ModelSiswa.fromJson(json.decode(str));

String modelSiswaToJson(ModelSiswa data) => json.encode(data.toJson());

class ModelSiswa {
    ModelSiswa({
        this.status,
        this.code,
        this.message,
        this.data,
    });

    bool status;
    int code;
    String message;
    List<Datum> data;

    factory ModelSiswa.fromJson(Map<String, dynamic> json) => ModelSiswa(
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
        this.namaSiswa,
        this.emailSiswa,
        this.alamatSiswa,
        this.noHp,
        this.idJurusan,
        this.idKelas,
        this.idSekolah,
        this.idTingkatan,
        this.idUser,
    });

    String idSiswa;
    String nis;
    String namaSiswa;
    String emailSiswa;
    String alamatSiswa;
    String noHp;
    String idJurusan;
    String idKelas;
    String idSekolah;
    String idTingkatan;
    String idUser;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        idSiswa: json["id_siswa"],
        nis: json["nis"],
        namaSiswa: json["nama_siswa"],
        emailSiswa: json["email_siswa"],
        alamatSiswa: json["alamat_siswa"],
        noHp: json["no_hp"],
        idJurusan: json["id_jurusan"],
        idKelas: json["id_kelas"],
        idSekolah: json["id_sekolah"],
        idTingkatan: json["id_tingkatan"],
        idUser: json["id_user"],
    );

    Map<String, dynamic> toJson() => {
        "id_siswa": idSiswa,
        "nis": nis,
        "nama_siswa": namaSiswa,
        "email_siswa": emailSiswa,
        "alamat_siswa": alamatSiswa,
        "no_hp": noHp,
        "id_jurusan": idJurusan,
        "id_kelas": idKelas,
        "id_sekolah": idSekolah,
        "id_tingkatan": idTingkatan,
        "id_user": idUser,
    };
}
