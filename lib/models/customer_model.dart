import 'dart:convert';

Customers customersFromJson(String str) => Customers.fromJson(json.decode(str));

String customersToJson(Customers data) => json.encode(data.toJson());

class Customers {
  Customers({
    required this.success,
    required this.customers,
    required this.customersCount,
    required this.customersCountToday,
    required this.packages,
  });

  bool success;
  List<Customer> customers;
  int customersCount;
  int customersCountToday;
  List<dynamic> packages;

  factory Customers.fromJson(Map<String, dynamic> json) => Customers(
        success: json["success"],
        customers: List<Customer>.from(
            json["customers"].map((x) => Customer.fromJson(x))),
        customersCount: json["customersCount"],
        customersCountToday: json["customersCountToday"],
        packages: List<dynamic>.from(json["packages"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "customers": List<dynamic>.from(customers.map((x) => x.toJson())),
        "customersCount": customersCount,
        "customersCountToday": customersCountToday,
        "packages": List<dynamic>.from(packages.map((x) => x)),
      };
}

class Customer {
  Customer({
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

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
        id: json["id"],
        companyTitle: json["company_title"]??'-',
        code: json["code"],
        licenseType: json["license_type"],
        adminUser: json["admin_user"],
        notification: json["notification"],
        packageName: json["package_name"],
        not: json["not"],
        isThereAnyReminder: json["is_there_any_reminder"],
        lastLoginName: json["last_login_name"],
        lastLoginDate: json["last_login_date"] == null
            ? null
            : DateTime.tryParse(json["last_login_date"]),
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
        "last_login_date":
            lastLoginDate == null ? null : lastLoginDate!.toIso8601String(),
      };
}
