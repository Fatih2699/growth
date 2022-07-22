import 'dart:convert';

NonData nonDataFromJson(String str) => NonData.fromJson(json.decode(str));

String nonDataToJson(NonData data) => json.encode(data.toJson());

class NonData {
  NonData({
    required this.licenseDetails,
  });

  List<LicenseDetail> licenseDetails;

  factory NonData.fromJson(Map<String, dynamic> json) => NonData(
        licenseDetails: json["license_details"] == null
            ? List.empty()
            : List<LicenseDetail>.from(
                json["license_details"].map((x) => LicenseDetail.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "license_details": licenseDetails == null
            ? 'boş'
            : List<dynamic>.from(licenseDetails.map((x) => x.toJson())),
      };
}

class LicenseDetail {
  LicenseDetail({
    required this.id,
    required this.licenseId,
    required this.name,
    required this.email,
    required this.phone,
    required this.verificationCode,
    required this.createdAt,
  });

  int? id;
  dynamic licenseId;
  String? name;
  String? email;
  String? phone;
  String? verificationCode;
  DateTime? createdAt;

  factory LicenseDetail.fromJson(Map<String, dynamic> json) => LicenseDetail(
        id: json["id"] == null ? null : json["id"],
        licenseId: json["license_id"],
        name: json["name"] == null ? null : json["name"],
        email: json["email"] == null ? null : json["email"],
        phone: json["phone"] == null ? null : json["phone"],
        verificationCode: json["verification_code"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? 'null' : id,
        "license_id": licenseId,
        "name": name == null ? 'null' : name,
        "email": email == null ? 'null' : email,
        "phone": phone == null ? 'null' : phone,
        "verification_code":
            verificationCode == null ? 'null' : verificationCode,
        "created_at": createdAt == null ? 'null' : createdAt!.toIso8601String(),
      };
}
