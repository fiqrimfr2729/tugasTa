// To parse this JSON data, do
//
//     final ModelBimbinganGuru = ModelBimbinganGuruFromJson(jsonString);

import 'dart:convert';

ModelBimbinganGuru ModelBimbinganGuruFromJson(String str) => ModelBimbinganGuru.fromJson(json.decode(str));

String ModelBimbinganGuruToJson(ModelBimbinganGuru data) => json.encode(data.toJson());

class ModelBimbinganGuru {
  ModelBimbinganGuru({
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

  factory ModelBimbinganGuru.fromJson(Map<String, dynamic> json) => ModelBimbinganGuru(
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
    this.statusByGuru,
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
  String statusByGuru;
  DetailSiswa detailSiswa;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    idBimbingan: json["id_bimbingan"],
    nis: json["nis"],
    subject: json["subject"],
    isiBim: json["isi_bim"],
    tglBim: DateTime.parse(json["tgl_bim"]),
    keteranganBim: json["keterangan_bim"],
    status: json["status"],
    timestamps: json["timestamps"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    idSekolah: json["id_sekolah"],
    statusByGuru: json["status_by_guru"],
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
    "status_by_guru": statusByGuru,
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
    idSiswa: json["id_siswa"],
    nis: json["nis"],
    nisn: json["nisn"],
    namaSiswa: json["nama_siswa"],
    jkSiswa: json["jk_siswa"],
    ttlSiswa: json["ttl_siswa"],
    emailSiswa: json["email_siswa"],
    alamatSiswa: json["alamat_siswa"],
    noHp: json["no_hp"],
    foto: json["foto"],
    idJurusan: json["id_jurusan"],
    idKelas: json["id_kelas"],
    idSekolah: json["id_sekolah"],
    idTingkatan: json["id_tingkatan"],
    idUser: json["id_user"],
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
