// To parse this JSON data, do
//
//     final modelAlumni = modelAlumniFromJson(jsonString);

import 'dart:convert';

ModelAlumni modelAlumniFromJson(String str) => ModelAlumni.fromJson(json.decode(str));

String modelAlumniToJson(ModelAlumni data) => json.encode(data.toJson());

class ModelAlumni {
  ModelAlumni({
    this.status,
    this.code,
    this.message,
    this.data,
  });

  bool status;
  int code;
  String message;
  List<DataAlumni2> data;

  factory ModelAlumni.fromJson(Map<String, dynamic> json) => ModelAlumni(
    status: json["status"],
    code: json["code"],
    message: json["message"],
    data: List<DataAlumni2>.from(json["data"].map((x) => DataAlumni2.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "code": code,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class DataAlumni2 {
  DataAlumni2({
    this.id,
    this.nis,
    this.status,
    this.idUniv,
    this.keterangan,
    this.tahunLulus,
    this.createdAt,
    this.idSiswa,
    this.namaSiswa,
    this.emailSiswa,
    this.alamatSiswa,
    this.noHp,
    this.idJurusan,
    this.idKelas,
    this.idSekolah,
    this.idTingkatan,
    this.idUser,
    this.nisn,
    this.jk,
    this.tempatLahir,
    this.tanggalLahir,
    this.namaAyah,
    this.namaIbu,
    this.pekerjaanAyah,
    this.pekerjaanIbu,
    this.alamatOrtu,
    this.skor,
    this.detailUniv,
  });

  int id;
  String nis;
  String status;
  String idUniv;
  String keterangan;
  String tahunLulus;
  DateTime createdAt;
  String idSiswa;
  String namaSiswa;
  String emailSiswa;
  String alamatSiswa;
  String noHp;
  String idJurusan;
  String idKelas;
  String idSekolah;
  String idTingkatan;
  String idUser;
  String nisn;
  String jk;
  String tempatLahir;
  String tanggalLahir;
  String namaAyah;
  String namaIbu;
  String pekerjaanAyah;
  String pekerjaanIbu;
  String alamatOrtu;
  String skor;
  DetailUniv detailUniv;

  factory DataAlumni2.fromJson(Map<String, dynamic> json) => DataAlumni2(
    id: json["id"],
    nis: json["nis"],
    status: json["status"],
    idUniv: json["id_univ"],
    keterangan: json["keterangan"],
    tahunLulus: json["tahun_lulus"],
    createdAt: DateTime.parse(json["created_at"]),
    idSiswa: json["id_siswa"],
    namaSiswa: json["nama_siswa"],
    emailSiswa: json["email_siswa"],
    alamatSiswa: json["alamat_siswa"],
    noHp: json["no_hp"],
    idJurusan: json["id_jurusan"],
    idKelas: json["id_kelas"],
    idSekolah: json["id_sekolah"],
    idTingkatan: json["id_tingkatan"],
    idUser: json["id_user"],
    nisn: json["nisn"],
    jk: json["jk"],
    tempatLahir: json["tempat_lahir"],
    tanggalLahir: json["tanggal_lahir"],
    namaAyah: json["nama_ayah"],
    namaIbu: json["nama_ibu"],
    pekerjaanAyah: json["pekerjaan_ayah"],
    pekerjaanIbu: json["pekerjaan_ibu"],
    alamatOrtu: json["alamat_ortu"],
    skor: json["skor"],
    detailUniv: DetailUniv.fromJson(json["detail_univ"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "nis": nis,
    "status": status,
    "id_univ": idUniv,
    "keterangan": keterangan,
    "tahun_lulus": tahunLulus,
    "created_at": createdAt.toIso8601String(),
    "id_siswa": idSiswa,
    "nama_siswa": namaSiswa,
    "email_siswa": emailSiswa,
    "alamat_siswa": alamatSiswa,
    "no_hp": noHp,
    "id_jurusan": idJurusan,
    "id_kelas": idKelas,
    "id_sekolah": idSekolah,
    "id_tingkatan": idTingkatan,
    "id_user": idUser,
    "nisn": nisn,
    "jk": jk,
    "tempat_lahir": tempatLahir,
    "tanggal_lahir": tanggalLahir,
    "nama_ayah": namaAyah,
    "nama_ibu": namaIbu,
    "pekerjaan_ayah": pekerjaanAyah,
    "pekerjaan_ibu": pekerjaanIbu,
    "alamat_ortu": alamatOrtu,
    "skor": skor,
    "detail_univ": detailUniv.toJson(),
  };
}

class DetailUniv {
  DetailUniv({
    this.id,
    this.namaUniversitas,
  });

  int id;
  String namaUniversitas;

  factory DetailUniv.fromJson(Map<String, dynamic> json) => DetailUniv(
    id: json["id"],
    namaUniversitas: json["nama_universitas"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "nama_universitas": namaUniversitas,
  };
}
