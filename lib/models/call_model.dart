import 'dart:convert';

CallModel callModelFromJson(String str) => CallModel.fromJson(json.decode(str));

String callModelToJson(CallModel data) => json.encode(data.toJson());

class CallModel {
  CallModel({
    required this.data,
  });

  Data data;

  factory CallModel.fromJson(Map<String, dynamic> json) => CallModel(
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
      };
}

class Data {
  Data({
    required this.currentPage,
    required this.data,
    required this.firstPageUrl,
    required this.from,
    required this.lastPage,
    required this.lastPageUrl,
    required this.nextPageUrl,
    required this.path,
    required this.perPage,
    required this.prevPageUrl,
    required this.to,
    required this.total,
  });

  int currentPage;
  List<Datum> data;
  String firstPageUrl;
  int from;
  int lastPage;
  String lastPageUrl;
  String nextPageUrl;
  String path;
  int perPage;
  dynamic prevPageUrl;
  int to;
  int total;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        currentPage: json["current_page"] ?? '-',
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        firstPageUrl: json["first_page_url"] ?? '-',
        from: json["from"] ?? 1, //BURADA HATA VAR
        lastPage: json["last_page"] ?? 2, //burada hata var,
        lastPageUrl: json["last_page_url"] ?? '-',
        nextPageUrl: json["next_page_url"] ?? '-',
        path: json["path"] ?? '-',
        perPage: json["per_page"] ?? 3, //BURADA HATA VAR,
        prevPageUrl: json["prev_page_url"] ?? '-',
        to: json["to"] ?? 4, //BURADA HATA VAR,
        total: json["total"] ?? '-',
      );

  Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "first_page_url": firstPageUrl,
        "from": from,
        "last_page": lastPage,
        "last_page_url": lastPageUrl,
        "next_page_url": nextPageUrl,
        "path": path,
        "per_page": perPage,
        "prev_page_url": prevPageUrl,
        "to": to,
        "total": total,
      };
}

class Datum {
  Datum({
    required this.licenseId,
    required this.firmaAdi,
    required this.arayan,
    required this.aramaTarihi,
    required this.aramaBaslangic,
    required this.aramaBitis,
    required this.aramaSuresiDk,
    required this.yetkili,
    required this.konu,
  });

  int licenseId;
  String firmaAdi;
  String arayan;
  DateTime aramaTarihi;
  String aramaBaslangic;
  String aramaBitis;
  int aramaSuresiDk;
  String yetkili;
  String konu;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        licenseId: json["license_id"] ?? '-',
        firmaAdi: json["firma_adi"] ?? '-',
        arayan: json["arayan"] ?? '-',
        aramaTarihi: DateTime.parse(json["arama_tarihi"] ?? DateTime.now()),
        aramaBaslangic: json["arama_baslangic"] ?? '-',
        aramaBitis: json["arama_bitis"] ?? '-',
        aramaSuresiDk: json["arama_suresi(dk)"] ?? '-',
        yetkili: json["yetkili"] ?? '-',
        konu: json["konu"] ?? '-',
      );

  Map<String, dynamic> toJson() => {
        "license_id": licenseId,
        "firma_adi": firmaAdi,
        "arayan": arayan,
        "arama_tarihi":
            "${aramaTarihi.year.toString().padLeft(4, '0')}-${aramaTarihi.month.toString().padLeft(2, '0')}-${aramaTarihi.day.toString().padLeft(2, '0')}",
        "arama_baslangic": aramaBaslangic,
        "arama_bitis": aramaBitis,
        "arama_suresi(dk)": aramaSuresiDk,
        "yetkili": yetkili,
        "konu": konu,
      };
}
