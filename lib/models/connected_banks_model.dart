import 'dart:convert';

ConnectedBanks connectedBanksFromJson(String str) => ConnectedBanks.fromJson(json.decode(str));

String connectedBanksToJson(ConnectedBanks data) => json.encode(data.toJson());

class ConnectedBanks {
    ConnectedBanks({
        required this.data,
    });

    List<Bank> data;

    factory ConnectedBanks.fromJson(Map<String, dynamic> json) => ConnectedBanks(
        data: List<Bank>.from(json["data"].map((x) => Bank.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Bank {
    Bank({
        required this.bankId,
        required this.bankName,
        required this.status,
        required this.productName,
        required this.productTitle,
        required this.productId,
    });

    int? bankId;
    String? bankName;
    int? status;
    String? productName;
    String? productTitle;
    int? productId;

    factory Bank.fromJson(Map<String, dynamic> json) => Bank(
        bankId: json["bank_id"],
        bankName: json["bank_name"],
        status: json["status"],
        productName: json["product_name"],
        productTitle: json["product_title"],
        productId: json["product_id"],
    );

    Map<String, dynamic> toJson() => {
        "bank_id": bankId,
        "bank_name": bankName,
        "status": status,
        "product_name": productName,
        "product_title": productTitle,
        "product_id": productId,
    };
}
