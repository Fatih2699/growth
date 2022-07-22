import 'dart:convert';

Demo demoFromJson(String str) => Demo.fromJson(json.decode(str));

String demoToJson(Demo data) => json.encode(data.toJson());

class Demo {
  Demo({
    required this.success,
    required this.demos,
    required this.demosCount,
    required this.demosCountToday,
  });

  bool success;
  List<DemoElement> demos;
  int demosCount;
  int demosCountToday;

  factory Demo.fromJson(Map<String, dynamic> json) => Demo(
        success: json["success"],
        demos: List<DemoElement>.from(
            json["demos"].map((x) => DemoElement.fromJson(x))),
        demosCount: json["demosCount"],
        demosCountToday: json["demosCountToday"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "demos": List<dynamic>.from(demos.map((x) => x.toJson())),
        "demosCount": demosCount,
        "demosCountToday": demosCountToday,
      };
}

class DemoElement {
  DemoElement({
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

  int? id;
  String? companyTitle;
  String? code;
  String? licenseType;
  String? adminUser;
  int? notification;
  String? packageName;
  String? not;
  int? isThereAnyReminder;
  String? lastLoginName;
  DateTime? lastLoginDate;

  factory DemoElement.fromJson(Map<String, dynamic> json) => DemoElement(
        id: json["id"],
        companyTitle: json["company_title"],
        code: json["code"],
        licenseType: json["license_type"],
        adminUser: json["admin_user"],
        notification: json["notification"],
        packageName: json["package_name"],
        not: json["not"],
        isThereAnyReminder: json["is_there_any_reminder"],
        lastLoginName: json["last_login_name"],
        lastLoginDate: DateTime.parse(json["last_login_date"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "company_title": companyTitle,
        "code": code,
        "license_type": licenseType,
        "admin_user": adminUser,
        "notification": notification,
        "package_name": packageName,
        "not": not,
        "is_there_any_reminder": isThereAnyReminder,
        "last_login_name": lastLoginName,
        "last_login_date": lastLoginDate!.toIso8601String(),
      };
}
