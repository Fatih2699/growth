import 'dart:convert';

SearchModel searchModelFromJson(String str) =>
    SearchModel.fromJson(json.decode(str));

String searchModelToJson(SearchModel data) => json.encode(data.toJson());

class SearchModel {
  SearchModel({
    required this.success,
    required this.customers,
  });

  bool success;
  List<Customer> customers;

  factory SearchModel.fromJson(Map<String, dynamic> json) => SearchModel(
        success: json["success"],
        customers: List<Customer>.from(
            json["customers"].map((x) => Customer.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "customers": List<dynamic>.from(customers.map((x) => x.toJson())),
      };
}

class Customer {
  Customer({
    required this.id,
    required this.companyTitle,
    required this.taxNo,
    required this.code,
    required this.licenseType,
    required this.name,
    required this.phone,
    required this.email,
    required this.startLicense,
    required this.endLicense,
    required this.packageName,
    required this.step,
    required this.not,
    required this.lastLoginName,
    required this.lastLoginDate,
    required this.usersNames,
  });

  int? id;
  String? companyTitle;
  String? taxNo;
  String? code;
  String? licenseType;
  String? name;
  String? phone;
  String? email;
  DateTime? startLicense;
  DateTime? endLicense;
  String? packageName;
  String? step;
  String? not;
  String? lastLoginName;
  String? lastLoginDate;
  String? usersNames;

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
        id: json["id"],
        companyTitle: json["company_title"] ?? '',
        taxNo: json["tax_no"] ?? '-',
        code: json["code"] ?? '_',
        licenseType: json["license_type"] ?? '-',
        name: json["name"] ?? '-',
        phone: json["phone"] ?? '-',
        email: json["email"] ?? '-',
        startLicense: json["start_license"] != null
            ? DateTime.parse(json["start_license"])
            : null,
        endLicense: json["end_license"] != null
            ? DateTime.parse(json["end_license"])
            : null,
        packageName: json["package_name"] ?? '-',
        step: json["step"] ?? '-',
        not: json["not"] ?? '-',
        lastLoginName: json["last_login_name"] ?? '-',
        lastLoginDate: json["last_login_date"] ?? '-',
        usersNames: json["users_names"] ?? '-',
      );

  Map<String, dynamic> toJson() => {
        "id": id ?? '-',
        "company_title": companyTitle ?? 'title yok',
        "tax_no": taxNo ?? '-',
        "code": code ?? '-',
        "license_type": licenseType ?? '-',
        "name": name ?? '-',
        "phone": phone ?? '-',
        "email": email ?? '-',
        "start_license":
            startLicense != null ? startLicense!.toIso8601String() : '-',
        "end_license": endLicense != null ? endLicense!.toIso8601String() : '-',
        "package_name": packageName ?? '-',
        "step": step ?? '-',
        "not": not ?? '-',
        "last_login_name": lastLoginName ?? '-',
        "last_login_date": lastLoginDate ?? '-',
        "users_names": usersNames ?? '-',
      };
}
