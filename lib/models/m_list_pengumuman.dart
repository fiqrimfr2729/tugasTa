// To parse this JSON data, do
//
//     final modelListPengumuman = modelListPengumumanFromJson(jsonString);

import 'dart:convert';

ModelListPengumuman modelListPengumumanFromJson(String str) => ModelListPengumuman.fromJson(json.decode(str));

String modelListPengumumanToJson(ModelListPengumuman data) => json.encode(data.toJson());

class ModelListPengumuman {
    ModelListPengumuman({
        this.status,
        this.code,
        this.message,
        this.data,
    });

    bool status;
    int code;
    String message;
    List<Datum> data;

    factory ModelListPengumuman.fromJson(Map<String, dynamic> json) => ModelListPengumuman(
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
        this.idPengumuman,
        this.idUser,
        this.tglBuat,
        this.foto,
        this.isiPengumuman,
        this.createdAt,
        this.updatedAt,
        this.idSekolah,
        this.detailUser,
    });

    String idPengumuman;
    String idUser;
    DateTime tglBuat;
    String foto;
    String isiPengumuman;
    DateTime createdAt;
    DateTime updatedAt;
    String idSekolah;
    DetailUser detailUser;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        idPengumuman: json["id_pengumuman"],
        idUser: json["id_user"],
        tglBuat: DateTime.parse(json["tgl_buat"]),
        foto: json["foto"],
        isiPengumuman: json["isi_pengumuman"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        idSekolah: json["id_sekolah"],
        detailUser: DetailUser.fromJson(json["detail_user"]),
    );

    Map<String, dynamic> toJson() => {
        "id_pengumuman": idPengumuman,
        "id_user": idUser,
        "tgl_buat": tglBuat.toIso8601String(),
        "foto": foto,
        "isi_pengumuman": isiPengumuman,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "id_sekolah": idSekolah,
        "detail_user": detailUser.toJson(),
    };
}

class DetailUser {
    DetailUser({
        this.idGuru,
        this.namaGuru,
        this.alamatGuru,
        this.emailGuru,
        this.nik,
        this.idJabatan,
        this.idUser,
        this.idSekolah,
    });

    String idGuru;
    String namaGuru;
    String alamatGuru;
    String emailGuru;
    String nik;
    String idJabatan;
    String idUser;
    String idSekolah;

    factory DetailUser.fromJson(Map<String, dynamic> json) => DetailUser(
        idGuru: json["id_guru"],
        namaGuru: json["nama_guru"],
        alamatGuru: json["alamat_guru"],
        emailGuru: json["email_guru"],
        nik: json["nik"],
        idJabatan: json["id_jabatan"],
        idUser: json["id_user"],
        idSekolah: json["id_sekolah"],
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
    };
}
