import 'dart:convert';

ModelKomentar modelKomentarFromJson(String str) => ModelKomentar.fromJson(json.decode(str));

String modelKomentarToJson(ModelKomentar data) => json.encode(data.toJson());

class ModelKomentar {
    ModelKomentar({
        this.status,
        this.code,
        this.message,
        this.data,
    });

    bool status;
    int code;
    String message;
    List<Datum> data;

    factory ModelKomentar.fromJson(Map<String, dynamic> json) => ModelKomentar(
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
        this.idKomentar,
        this.idPengumuman,
        this.isiKomentar,
        this.createdAt,
        this.komentator,
    });

    String idKomentar;
    String idPengumuman;
    String isiKomentar;
    DateTime createdAt;
    String komentator;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        idKomentar: json["id_komentar"],
        idPengumuman: json["id_pengumuman"],
        isiKomentar: json["isi_komentar"],
        createdAt: DateTime.parse(json["created_at"]),
        komentator: json["komentator"],
    );

    Map<String, dynamic> toJson() => {
        "id_komentar": idKomentar,
        "id_pengumuman": idPengumuman,
        "isi_komentar": isiKomentar,
        "created_at": createdAt.toIso8601String(),
        "komentator": komentator,
    };
}