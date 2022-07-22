import 'dart:convert';

Advisor advisorFromJson(String str) => Advisor.fromJson(json.decode(str));

String advisorToJson(Advisor data) => json.encode(data.toJson());

class Advisor {
  Advisor({
    required this.success,
    required this.customersAdviser,
    required this.dashboardData,
  });

  bool success;
  List<CustomersAdviser> customersAdviser;
  DashboardData dashboardData;

  factory Advisor.fromJson(Map<String, dynamic> json) => Advisor(
        success: json["success"],
        customersAdviser: List<CustomersAdviser>.from(
            json["customersAdviser"].map((x) => CustomersAdviser.fromJson(x))),
        dashboardData: DashboardData.fromJson(json["dashboard_data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "customersAdviser":
            List<dynamic>.from(customersAdviser.map((x) => x.toJson())),
        "dashboard_data": dashboardData.toJson(),
      };
}

class CustomersAdviser {
  CustomersAdviser({
    required this.id,
    required this.companyTitle,
    required this.code,
    required this.licenseType,
    required this.name,
    required this.phone,
    required this.email,
    required this.taxpayerCount,
    required this.activeTaxpayerCount,
    required this.passiveTaxpayerCount,
    required this.customerTaxpayerCount,
    required this.createdAt,
    required this.note,
    required this.lastLoginName,
    required this.lastLoginDate,
  });

  int? id;
  String? companyTitle;
  String? code;
  String? licenseType;
  String? name;
  String? phone;
  String? email;
  int? taxpayerCount;
  int? activeTaxpayerCount;
  int? passiveTaxpayerCount;
  int? customerTaxpayerCount;
  DateTime? createdAt;
  String? note;
  String? lastLoginName;
  DateTime? lastLoginDate;

  factory CustomersAdviser.fromJson(Map<String, dynamic> json) =>
      CustomersAdviser(
        id: json["id"],
        companyTitle: json["company_title"] ?? "-",
        code: json["code"],
        licenseType: json["license_type"],
        name: json["name"],
        phone: json["phone"],
        email: json["email"],
        taxpayerCount: json["taxpayer_count"],
        activeTaxpayerCount: json["active_taxpayer_count"],
        passiveTaxpayerCount: json["passive_taxpayer_count"],
        customerTaxpayerCount: json["customer_taxpayer_count"],
        createdAt: DateTime.parse(json["created_at"]),
        note: json["note"],
        lastLoginName: json["last_login_name"],
        lastLoginDate: json["last_login_date"] == null
            ? null
            : DateTime.parse(json["last_login_date"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "company_title": companyTitle ?? '-',
        "code": code,
        "license_type": licenseType,
        "name": name,
        "phone": phone,
        "email": email,
        "taxpayer_count": taxpayerCount,
        "active_taxpayer_count": activeTaxpayerCount,
        "passive_taxpayer_count": passiveTaxpayerCount,
        "customer_taxpayer_count": customerTaxpayerCount,
        "created_at": createdAt!.toIso8601String(),
        "note": note,
        "last_login_name": lastLoginName,
        "last_login_date":
            lastLoginDate == null ? null : lastLoginDate!.toIso8601String(),
      };
}

class DashboardData {
  DashboardData({
    required this.advisorCount,
    required this.activeCount,
    required this.inactiveCount,
    required this.relatedCount,
  });

  int advisorCount;
  int activeCount;
  int inactiveCount;
  int relatedCount;

  factory DashboardData.fromJson(Map<String, dynamic> json) => DashboardData(
        advisorCount: json["advisor_count"],
        activeCount: json["active_count"],
        inactiveCount: json["inactive_count"],
        relatedCount: json["related_count"],
      );

  Map<String, dynamic> toJson() => {
        "advisor_count": advisorCount,
        "active_count": activeCount,
        "inactive_count": inactiveCount,
        "related_count": relatedCount,
      };
}
