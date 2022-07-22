import 'dart:convert';

RegisterModel registerFromJson(String str) =>
    RegisterModel.fromJson(json.decode(str));

String registerToJson(RegisterModel data) => json.encode(data.toJson());

class RegisterModel {
  RegisterModel({
    required this.record,
    required this.recordCount,
    required this.recordCountToday,
  });

  List<Record> record;
  int recordCount;
  int recordCountToday;

  factory RegisterModel.fromJson(Map<String, dynamic> json) => RegisterModel(
        record:
            List<Record>.from(json["record"].map((x) => Record.fromJson(x))),
        recordCount: json["recordCount"],
        recordCountToday: json["recordCountToday"],
      );

  Map<String, dynamic> toJson() => {
        "record": List<dynamic>.from(record.map((x) => x.toJson())),
        "recordCount": recordCount,
        "recordCountToday": recordCountToday,
      };
}

class Record {
  Record({
    required this.id,
    required this.companyTitle,
    required this.code,
    required this.licenseType,
    required this.adminUser,
    required this.notification,
    required this.packageName,
    required this.not,
    required this.isThereAnyReminder,
    required this.lastLoginName,
    required this.lastLoginDate,
  });

  int id;
  String? companyTitle;
  String? code;
  String? licenseType;
  String? adminUser;
  int notification;
  String? packageName;
  String? not;
  int isThereAnyReminder;
  String? lastLoginName;
  DateTime? lastLoginDate;

  factory Record.fromJson(Map<String, dynamic> json) => Record(
        id: json["id"],
        companyTitle: json["company_title"] ?? '-',
        code: json["code"],
        licenseType: json["license_type"],
        adminUser: json["admin_user"],
        notification: json["notification"],
        packageName: json["package_name"],
        not: json["not"] ?? 'Not bulunmuyor',
        isThereAnyReminder: json["is_there_any_reminder"],
        lastLoginName: json["last_login_name"],
        lastLoginDate: json["last_login_date"] == null
            ? null
            : DateTime.parse(json["last_login_date"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "company_title": companyTitle,
        "code": code,
        "license_type": licenseType,
        "admin_user": adminUser,
        "notification": notification,
        "package_name": packageName,
        "not": not ?? 'Not bulunmuyor',
        "is_there_any_reminder": isThereAnyReminder,
        "last_login_name": lastLoginName,
        "last_login_date":
            lastLoginDate == null ? 'Null' : lastLoginDate!.toIso8601String(),
      };
}
