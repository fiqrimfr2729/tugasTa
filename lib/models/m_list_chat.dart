// To parse this JSON data, do
//
//     final modelListChat = modelListChatFromJson(jsonString);

import 'dart:convert';

ModelListChat modelListChatFromJson(String str) => ModelListChat.fromJson(json.decode(str));

String modelListChatToJson(ModelListChat data) => json.encode(data.toJson());

class ModelListChat {
  ModelListChat({
    this.status,
    this.code,
    this.message,
    this.data,
  });

  bool status;
  int code;
  String message;
  List<Datum> data;

  factory ModelListChat.fromJson(Map<String, dynamic> json) => ModelListChat(
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
    this.idMessage,
    this.contentMessage,
    this.typeMessage,
    this.nik,
    this.nis,
    this.createdAt,
    this.updatedAt,
    this.idBimbingan,
    this.senderId,
    this.detailSiswa,
    this.detailGuru,
  });

  String idMessage;
  String contentMessage;
  String typeMessage;
  String nik;
  String nis;
  DateTime createdAt;
  DateTime updatedAt;
  String idBimbingan;
  String senderId;
  DetailSiswa detailSiswa;
  DetailGuru detailGuru;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    idMessage: json["id_message"],
    contentMessage: json["content_message"],
    typeMessage: json["type_message"],
    nik: json["nik"],
    nis: json["nis"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    idBimbingan: json["id_bimbingan"],
    senderId: json["sender_id"],
    detailSiswa: DetailSiswa.fromJson(json["detail_siswa"]),
    detailGuru: DetailGuru.fromJson(json["detail_guru"]),
  );

  Map<String, dynamic> toJson() => {
    "id_message": idMessage,
    "content_message": contentMessage,
    "type_message": typeMessage,
    "nik": nik,
    "nis": nis,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "id_bimbingan": idBimbingan,
    "sender_id": senderId,
    "detail_siswa": detailSiswa.toJson(),
    "detail_guru": detailGuru.toJson(),
  };
}

class DetailGuru {
  DetailGuru({
    this.idGuru,
    this.namaGuru,
    this.alamatGuru,
    this.emailGuru,
    this.nik,
    this.idJabatan,
    this.idUser,
    this.idSekolah,
  });

  int idGuru;
  String namaGuru;
  String alamatGuru;
  String emailGuru;
  int nik;
  int idJabatan;
  String idUser;
  int idSekolah;

  factory DetailGuru.fromJson(Map<String, dynamic> json) => DetailGuru(
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

  int idSiswa;
  int nis;
  String nisn;
  String namaSiswa;
  String jkSiswa;
  int ttlSiswa;
  String emailSiswa;
  String alamatSiswa;
  String noHp;
  String foto;
  int idJurusan;
  int idKelas;
  int idSekolah;
  int idTingkatan;
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
