// To parse this JSON data, do
//
//     final modelBimbingan = modelBimbinganFromJson(jsonString);

import 'dart:convert';

ModelBimbingan modelBimbinganFromJson(String str) => ModelBimbingan.fromJson(json.decode(str));

String modelBimbinganToJson(ModelBimbingan data) => json.encode(data.toJson());

class ModelBimbingan {
  ModelBimbingan({
    this.status,
    this.code,
    this.message,
    this.totalData,
    this.data,
  });

  bool status;
  int code;
  String message;
  int totalData;
  List<Datum> data;

  factory ModelBimbingan.fromJson(Map<String, dynamic> json) => ModelBimbingan(
    status: json["status"],
    code: json["code"],
    message: json["message"],
    totalData: json["total_data"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "code": code,
    "message": message,
    "total_data": totalData,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    this.idBimbingan,
    this.nis,
    this.subject,
    this.isiBim,
    this.tglBim,
    this.keteranganBim,
    this.status,
    this.timestamps,
    this.createdAt,
    this.updatedAt,
    this.idSekolah,
    this.detailSiswa,
  });

  String idBimbingan;
  String nis;
  String subject;
  String isiBim;
  DateTime tglBim;
  String keteranganBim;
  String status;
  String timestamps;
  DateTime createdAt;
  DateTime updatedAt;
  String idSekolah;
  DetailSiswa detailSiswa;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    idBimbingan: json["id_bimbingan"].toString(),
    nis: json["nis"],
    subject: json["subject"],
    isiBim: json["isi_bim"],
    tglBim: DateTime.parse(json["tgl_bim"]),
    keteranganBim: json["keterangan_bim"],
    status: json["status"],
    timestamps: json["timestamps"].toString(),
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    idSekolah: json["id_sekolah"],
    detailSiswa: DetailSiswa.fromJson(json["detail_siswa"]),
  );

  Map<String, dynamic> toJson() => {
    "id_bimbingan": idBimbingan,
    "nis": nis,
    "subject": subject,
    "isi_bim": isiBim,
    "tgl_bim": tglBim.toIso8601String(),
    "keterangan_bim": keteranganBim,
    "status": status,
    "timestamps": timestamps,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "id_sekolah": idSekolah,
    "detail_siswa": detailSiswa.toJson(),
  };
}

class DetailSiswa {
  DetailSiswa({
    this.idSiswa,
    this.nis,
    this.nisn,
    this.namaSiswa,
    this.jkSiswa,
    this.ttlSiswa,
    this.emailSiswa,
    this.alamatSiswa,
    this.noHp,
    this.foto,
    this.idJurusan,
    this.idKelas,
    this.idSekolah,
    this.idTingkatan,
    this.idUser,
  });

  String idSiswa;
  String nis;
  String nisn;
  String namaSiswa;
  String jkSiswa;
  String ttlSiswa;
  String emailSiswa;
  String alamatSiswa;
  String noHp;
  String foto;
  String idJurusan;
  String idKelas;
  String idSekolah;
  String idTingkatan;
  String idUser;

  factory DetailSiswa.fromJson(Map<String, dynamic> json) => DetailSiswa(
    idSiswa: json["id_siswa"].toString(),
    nis: json["nis"].toString(),
    nisn: json["nisn"],
    namaSiswa: json["nama_siswa"],
    jkSiswa: json["jk_siswa"],
    ttlSiswa: json["ttl_siswa"].toString(),
    emailSiswa: json["email_siswa"],
    alamatSiswa: json["alamat_siswa"],
    noHp: json["no_hp"],
    foto: json["foto"],
    idJurusan: json["id_jurusan"].toString(),
    idKelas: json["id_kelas"].toString(),
    idSekolah: json["id_sekolah"].toString(),
    idTingkatan: json["id_tingkatan"].toString(),
    idUser: json["id_user"].toString(),
  );

  Map<String, dynamic> toJson() => {
    "id_siswa": idSiswa,
    "nis": nis,
    "nisn": nisn,
    "nama_siswa": namaSiswa,
    "jk_siswa": jkSiswa,
    "ttl_siswa": ttlSiswa,
    "email_siswa": emailSiswa,
    "alamat_siswa": alamatSiswa,
    "no_hp": noHp,
    "foto": foto,
    "id_jurusan": idJurusan,
    "id_kelas": idKelas,
    "id_sekolah": idSekolah,
    "id_tingkatan": idTingkatan,
    "id_user": idUser,
  };
}
