import 'dart:convert';

CampaignModel campaignModelFromJson(String str) =>
    CampaignModel.fromJson(json.decode(str));

String campaignModelToJson(CampaignModel data) => json.encode(data.toJson());

class CampaignModel {
  CampaignModel({
    required this.message,
    required this.data,
  });

  String message;
  List<Datum> data;

  factory CampaignModel.fromJson(Map<String, dynamic> json) => CampaignModel(
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    required this.id,
    required this.productId,
    required this.using,
    required this.customerType,
    required this.userType,
    required this.photo,
    required this.feature,
    required this.status,
    required this.duration,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  int productId;
  String using;
  String customerType;
  String userType;
  String photo;
  String feature;
  int status;
  int duration;
  DateTime createdAt;
  DateTime updatedAt;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        productId: json["product_id"],
        using: json["using"],
        customerType: json["customer_type"],
        userType: json["user_type"],
        photo: json["photo"],
        feature: json["feature"],
        status: json["status"],
        duration: json["duration"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product_id": productId,
        "using": using,
        "customer_type": customerType,
        "user_type": userType,
        "photo": photo,
        "feature": feature,
        "status": status,
        "duration": duration,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
