// To parse this JSON data, do
//
//     final modelDataAbsen = modelDataAbsenFromJson(jsonString);

import 'dart:convert';

ModelDataAbsen modelDataAbsenFromJson(String str) => ModelDataAbsen.fromJson(json.decode(str));

String modelDataAbsenToJson(ModelDataAbsen data) => json.encode(data.toJson());

class ModelDataAbsen {
    ModelDataAbsen({
        this.status,
        this.code,
        this.message,
        this.data,
    });

    bool status;
    int code;
    String message;
    List<Datum> data;

    factory ModelDataAbsen.fromJson(Map<String, dynamic> json) => ModelDataAbsen(
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
        this.idKelas,
        this.detailSiswa,
    });

    String idAbsensi;
    String nis;
    DateTime tanggal;
    String keterangan;
    String idKelas;
    DetailSiswa detailSiswa;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        idAbsensi: json["id_absensi"],
        nis: json["nis"],
        tanggal: DateTime.parse(json["tanggal"]),
        keterangan: json["Keterangan"],
        idKelas: json["id_kelas"],
        detailSiswa: DetailSiswa.fromJson(json["detail_siswa"]),
    );

    Map<String, dynamic> toJson() => {
        "id_absensi": idAbsensi,
        "nis": nis,
        "tanggal": "${tanggal.year.toString().padLeft(4, '0')}-${tanggal.month.toString().padLeft(2, '0')}-${tanggal.day.toString().padLeft(2, '0')}",
        "Keterangan": keterangan,
        "id_kelas": idKelas,
        "detail_siswa": detailSiswa.toJson(),
    };
}

class DetailSiswa {
    DetailSiswa({
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

    factory DetailSiswa.fromJson(Map<String, dynamic> json) => DetailSiswa(
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
