// To parse this JSON data, do
//
//     final connectedBanks = connectedBanksFromJson(jsonString);

import 'package:growth/screens/lists/referer_logs/utm_kampanya_detail.dart';
import 'package:meta/meta.dart';
import 'dart:convert';

UtmKampanya utmKampanyaFromJson(String str) => UtmKampanya.fromJson(json.decode(str));

String utmKampanyaToJson(UtmKampanya data) => json.encode(data.toJson());

class UtmKampanya {
    UtmKampanya({
        required this.success,
        required this.logs,
    });

    bool success;
    List<Log> logs;

    factory UtmKampanya.fromJson(Map<String, dynamic> json) => UtmKampanya(
        success: json["success"] == null ? null : json["success"],
        logs: List<Log>.from(json["logs"].map((x) => Log.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "success": success == null ? null : success,
        "logs": logs == null ? null : List<dynamic>.from(logs.map((x) => x.toJson())),
    };
}

class Log {
    Log({
        required this.id,
        required this.licenseId,
        required this.companyName,
        required this.name,
        required this.adSoyad,
        required this.gibOnay,
        required this.bankSecim,
        required this.demoVeri,
        required this.refCode,
        required this.status,
        required this.type,
        required this.licenseType,
        required this.packageType,
        required this.product,
        required this.logDate,
        required this.source,
        required this.searchText,
        required this.refererData,
    });

    int id;
    int licenseId;
    dynamic companyName;
    String name;
    String adSoyad;
    String gibOnay;
    String bankSecim;
    String demoVeri;
    dynamic refCode;
    int status;
    String type;
    String licenseType;
    String packageType;
    String product;
    DateTime logDate;
    String source;
    String searchText;
    String refererData;

    factory Log.fromJson(Map<String, dynamic> json) => Log(
        id: json["id"],
        licenseId: json["license_id"],
        companyName: json["company_name"] ?? '-',
        name: json["name"] ?? '-',
        adSoyad: json["ad_soyad"] ?? '-',
        gibOnay: json["gib_onay"] ?? '-',
        bankSecim: json["bank_secim"] ?? '-',
        demoVeri: json["demo_veri"],
        refCode: json["ref_code"],
        status: json["status"],
        type: json["type"],
        licenseType: json["license_type"],
        packageType: json["package_type"],
        product: json["product"],
        logDate: DateTime.parse(json["log_date"]),
        source: json["source"],
        searchText: json["search_text"],
        refererData: json["referer_data"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "license_id": licenseId,
        "company_name": companyName,
        "name": name,
        "ad_soyad": adSoyad,
        "gib_onay": gibOnay,
        "bank_secim": bankSecim,
        "demo_veri": demoVeri,
        "ref_code": refCode,
        "status": status,
        "type": type,
        "license_type": licenseType,
        "package_type": packageType,
        "product": product,
        "log_date": logDate == null ? 'Null' : logDate.toIso8601String(),
        "source": source,
        "search_text": searchText,
        "referer_data": refererData,
    };
}
