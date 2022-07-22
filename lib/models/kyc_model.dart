import 'dart:convert';

Kyc kycFromJson(String str) => Kyc.fromJson(json.decode(str));

String kycToJson(Kyc data) => json.encode(data.toJson());

class Kyc {
  Kyc({
    required this.totalCount,
    required this.data,
    required this.count,
  });

  int totalCount;
  List<Datum> data;
  int count;

  factory Kyc.fromJson(Map<String, dynamic> json) => Kyc(
        totalCount: json["total_count"] ?? 0,
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        count: json["count"],
      );

  Map<String, dynamic> toJson() => {
        "total_count": totalCount,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "count": count,
      };
}

class Datum {
  Datum({
    required this.point,
    required this.licenseId,
    required this.code,
    required this.companyTitle,
    required this.customerStatus,
    required this.note,
    required this.createdAt,
    required this.source,
    required this.searchText,
  });

  String point;
  int licenseId;
  String code;
  String companyTitle;
  String customerStatus;
  String note;
  DateTime createdAt;
  String source;
  String searchText;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        point: json["point"] ?? '-',
        licenseId: json["license_id"] ?? '-',
        code: json["code"] ?? '-',
        companyTitle: json["company_title"] ?? '-',
        customerStatus: json["customer_status"] ?? '-',
        note: json["note"] ?? '-',
        createdAt: DateTime.parse(json["created_at"] ?? '-'),
        source: json["source"] ?? '-',
        searchText: json["search_text"] ?? '-',
      );

  Map<String, dynamic> toJson() => {
        "point": point,
        "license_id": licenseId,
        "code": code,
        "company_title": companyTitle,
        "customer_status": customerStatus,
        "note": note,
        "created_at": createdAt.toIso8601String(),
        "source": source == null ? null : source,
        "search_text": searchText == null ? null : searchText,
      };
}
