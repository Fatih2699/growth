import 'dart:convert';

Companies companiesFromJson(String str) => Companies.fromJson(json.decode(str));

String companiesToJson(Companies data) => json.encode(data.toJson());

class Companies {
  Companies({
    required this.success,
    required this.companies,
    required this.companiesCount,
    required this.companiesCountToday,
    required this.packages,
  });

  bool success;
  List<Company> companies;
  int companiesCount;
  int companiesCountToday;
  List<dynamic> packages;

  factory Companies.fromJson(Map<String, dynamic> json) => Companies(
        success: json["success"],
        companies: List<Company>.from(
            json["companies"].map((x) => Company.fromJson(x))),
        companiesCount: json["companiesCount"],
        companiesCountToday: json["companiesCountToday"],
        packages: List<dynamic>.from(json["packages"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "companies": List<dynamic>.from(companies.map((x) => x.toJson())),
        "companiesCount": companiesCount,
        "companiesCountToday": companiesCountToday,
        "packages": List<dynamic>.from(packages.map((x) => x)),
      };
}

class Company {
  Company({
    required this.id,
    required this.companyTitle,
    required this.code,
    required this.licenseType,
    required this.adminUser,
    required this.packageName,
    required this.notification,
    required this.licenseStatus,
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
  String? packageName;
  int? notification;
  String? licenseStatus;
  String? not;
  int? isThereAnyReminder;
  String? lastLoginName;
  DateTime? lastLoginDate;

  factory Company.fromJson(Map<String, dynamic> json) => Company(
        id: json["id"],
        companyTitle: json["company_title"],
        code: json["code"],
        licenseType: json["license_type"],
        adminUser: json["admin_user"],
        packageName: json["package_name"],
        notification: json["notification"],
        licenseStatus: json["license_status"],
        not: json["not"],
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
        "package_name": packageName,
        "notification": notification,
        "license_status": licenseStatus,
        "not": not,
        "is_there_any_reminder": isThereAnyReminder,
        "last_login_name": lastLoginName,
        "last_login_date":
            lastLoginDate == null ? null : lastLoginDate!.toIso8601String(),
      };
}
