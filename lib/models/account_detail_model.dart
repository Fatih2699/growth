// ignore_for_file: unnecessary_new, prefer_conditional_assignment

import 'dart:convert';

AccountDetail hesapDetayFromJson(String str) => AccountDetail.fromJson(json.decode(str));

String hesapDetayToJson(AccountDetail data) => json.encode(data.toJson());

class AccountDetail {
    AccountDetail({
        required this.success,
        required this.message,
        required this.bankLogs,
    });

    bool success;
    String? message;
    List<BankLog> bankLogs;

    factory AccountDetail.fromJson(Map<String, dynamic> json) => AccountDetail(
        success: json["success"],
        message: json["message"],
        bankLogs: List<BankLog>.from(json["bankLogs"].map((x) => BankLog.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "bankLogs": List<dynamic>.from(bankLogs.map((x) => x.toJson())),
    };
}

class BankLog {
    BankLog({
        required this.customerBankTitle,
        required this.bankName,
        required this.bankCreatedAt,
        required this.serviceLastUpdated,
        required this.isDeleted,
        required this.lastTransactionDate,
        required this.bankTotalTransaction,
        required this.bankTotalTransactionLicenseTime,
        required this.bankTotalTransactionToday,
        required this.bankAccountCount,
        required this.bankAverageTransactionMonthly,
        required this.bankAverageTransactionYearly,
        required this.connectionType,
    });

    String? customerBankTitle;
    String? bankName;
    DateTime? bankCreatedAt;
    DateTime? serviceLastUpdated;
    int? isDeleted;
    DateTime? lastTransactionDate;
    int? bankTotalTransaction;
    int? bankTotalTransactionLicenseTime;
    int? bankTotalTransactionToday;
    int? bankAccountCount;
    String? bankAverageTransactionMonthly;
    String? bankAverageTransactionYearly;
    ConnectionType? connectionType;

    factory BankLog.fromJson(Map<String, dynamic> json) => BankLog(
        customerBankTitle: json["customer_bank_title"],
        bankName: json["bank_name"],
        bankCreatedAt: json["bank_created_at"] == null ? null : DateTime.parse(json["bank_created_at"]),
        serviceLastUpdated:json["service_last_updated"] == null ? null :  DateTime.parse(json["service_last_updated"]),
        isDeleted: json["is_deleted"],
        lastTransactionDate: json["last_transaction_date"] == null ? null : DateTime.parse(json["last_transaction_date"]),
        bankTotalTransaction: json["bank_total_transaction"],
        bankTotalTransactionLicenseTime: json["bank_total_transaction_license_time"],
        bankTotalTransactionToday: json["bank_total_transaction_today"],
        bankAccountCount: json["bank_account_count"],
        bankAverageTransactionMonthly: json["bank_average_transaction_monthly"],
        bankAverageTransactionYearly: json["bank_average_transaction_yearly"],
        connectionType: connectionTypeValues.map[json["connection_type"]],
    );

    Map<String, dynamic> toJson() => {
        "customer_bank_title": customerBankTitle,
        "bank_name": bankName,
        "bank_created_at":bankCreatedAt == null ? null : bankCreatedAt!.toIso8601String(),
        "service_last_updated": serviceLastUpdated == null ? null : serviceLastUpdated!.toIso8601String(),
        "is_deleted": isDeleted,
        "last_transaction_date": lastTransactionDate == null ? null : lastTransactionDate!.toIso8601String(),
        "bank_total_transaction": bankTotalTransaction,
        "bank_total_transaction_license_time": bankTotalTransactionLicenseTime,
        "bank_total_transaction_today": bankTotalTransactionToday,
        "bank_account_count": bankAccountCount,
        "bank_average_transaction_monthly": bankAverageTransactionMonthly,
        "bank_average_transaction_yearly": bankAverageTransactionYearly,
        "connection_type": connectionTypeValues.reverse![connectionType]
    };
}

// ignore: constant_identifier_names
enum ConnectionType { WEB_SERVIS, API }

final connectionTypeValues = EnumValues({
    "API": ConnectionType.API,
    "Web Servis": ConnectionType.WEB_SERVIS
});

class EnumValues<T> {
    Map<String, T> map;
    Map<T, String> ?reverseMap;

    EnumValues(this.map);

    Map<T, String>? get reverse {
        if (reverseMap == null) {
            reverseMap = map.map((k, v) => new MapEntry(v, k));
        }
        return reverseMap;
    }
}
