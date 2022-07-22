import 'dart:convert';

Leads leadsFromJson(String str) => Leads.fromJson(json.decode(str));

String leadsToJson(Leads data) => json.encode(data.toJson());

class Leads {
  Leads({
    required this.success,
    required this.leads,
    required this.leadsCount,
    required this.leadsCountToday,
  });

  bool success;
  List<Lead> leads;
  int leadsCount;
  List<dynamic> leadsCountToday;

  factory Leads.fromJson(Map<String, dynamic> json) => Leads(
        success: json["success"],
        leads: List<Lead>.from(json["leads"].map((x) => Lead.fromJson(x))),
        leadsCount: json["leadsCount"],
        leadsCountToday:
            List<dynamic>.from(json["leadsCountToday"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "leads": List<dynamic>.from(leads.map((x) => x.toJson())),
        "leadsCount": leadsCount,
        "leadsCountToday": List<dynamic>.from(leadsCountToday.map((x) => x)),
      };
}

class Lead {
  Lead({
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

  factory Lead.fromJson(Map<String, dynamic> json) => Lead(
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
