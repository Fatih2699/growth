import 'dart:convert';

CampaignDetail campaignDetailFromJson(String str) =>
    CampaignDetail.fromJson(json.decode(str));

String campaignDetailToJson(CampaignDetail data) => json.encode(data.toJson());

class CampaignDetail {
  CampaignDetail({
    required this.message,
    required this.data,
  });

  String message;
  List<Datum> data;

  factory CampaignDetail.fromJson(Map<String, dynamic> json) => CampaignDetail(
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Datum(
      {required this.licenseId,
      required this.companyName,
      required this.vote,
      required this.voteUsers});

  int licenseId;
  String companyName;
  int vote;
  List<VoteUser> voteUsers;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
      licenseId: json["license_id"],
      companyName: json["company_name"],
      vote: json["vote"],
      voteUsers: List<VoteUser>.from(
          jsonDecode(json["vote_users"]).map((x) => VoteUser.fromJson(x))));

  Map<String, dynamic> toJson() => {
        "license_id": licenseId,
        "company_name": companyName,
        "vote": vote,
        "vote_users": voteUsers
      };
}

class VoteUser {
  VoteUser({
    required this.name,
    required this.phone,
    required this.email,
    required this.date,
  });

  String? name;
  String? phone;
  String? email;
  DateTime date;

  factory VoteUser.fromJson(Map<String, dynamic> json) => VoteUser(
        name: json["name"] ?? '-',
        phone: json["phone"] ?? '-',
        email: json["email"] ?? '-',
        date: DateTime.parse(json["date"]),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "phone": phone,
        "email": email,
        "date": date.toIso8601String(),
      };
}
