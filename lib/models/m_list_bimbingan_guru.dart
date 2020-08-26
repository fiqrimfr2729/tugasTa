// To parse this JSON data, do
//
//     final modelBimbinganGuru = modelBimbinganGuruFromJson(jsonString);

import 'dart:convert';

ModelBimbinganGuru modelBimbinganGuruFromJson(String str) => ModelBimbinganGuru.fromJson(json.decode(str));

String modelBimbinganGuruToJson(ModelBimbinganGuru data) => json.encode(data.toJson());

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
    List<DataBimbinganGuru> data;

    factory ModelBimbinganGuru.fromJson(Map<String, dynamic> json) => ModelBimbinganGuru(
        status: json["status"],
        code: json["code"],
        message: json["message"],
        totalData: json["total_data"],
        data: List<DataBimbinganGuru>.from(json["data"].map((x) => DataBimbinganGuru.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "message": message,
        "total_data": totalData,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class DataBimbinganGuru {
    DataBimbinganGuru({
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
        this.idTingkatan,
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
    String idTingkatan;
    DetailSiswa detailSiswa;

    factory DataBimbinganGuru.fromJson(Map<String, dynamic> json) => DataBimbinganGuru(
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
        idTingkatan: json["id_tingkatan"],
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
        "id_tingkatan": idTingkatan,
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
        this.detailKelas,
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
    DetailKelas detailKelas;

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
        detailKelas: DetailKelas.fromJson(json["detail_kelas"]),
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
        "detail_kelas": detailKelas.toJson(),
    };
}

class DetailKelas {
    DetailKelas({
        this.idKelas,
        this.namaKelas,
        this.idJurusan,
        this.idSekolah,
        this.idTingkatan,
        this.urutanKelas,
    });

    String idKelas;
    String namaKelas;
    String idJurusan;
    String idSekolah;
    String idTingkatan;
    String urutanKelas;

    factory DetailKelas.fromJson(Map<String, dynamic> json) => DetailKelas(
        idKelas: json["id_kelas"],
        namaKelas: json["nama_kelas"],
        idJurusan: json["id_jurusan"],
        idSekolah: json["id_sekolah"],
        idTingkatan: json["id_tingkatan"],
        urutanKelas: json["urutan_kelas"],
    );

    Map<String, dynamic> toJson() => {
        "id_kelas": idKelas,
        "nama_kelas": namaKelas,
        "id_jurusan": idJurusan,
        "id_sekolah": idSekolah,
        "id_tingkatan": idTingkatan,
        "urutan_kelas": urutanKelas,
    };
}
