import 'dart:convert';

Event eventFromJson(String str) => Event.fromJson(json.decode(str));

String eventToJson(Event data) => json.encode(data.toJson());

class Event {
  Event({
    required this.success,
    required this.reminders,
  });

  bool success;
  List<Reminder>? reminders;

  factory Event.fromJson(Map<String, dynamic> json) => Event(
        success: json["success"] == null ? null : json["success"],
        reminders: json["reminders"] == null
            ? null
            : List<Reminder>.from(
                json["reminders"].map((x) => Reminder.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success ? null : success,
        //"success": success == null ? null : success,
        "reminders": reminders == null
            ? null
            : List<dynamic>.from(reminders!.map((x) => x.toJson())),
      };
}

class Reminder {
  Reminder({
    required this.reminderId,
    required this.licenseId,
    required this.name,
    required this.title,
    required this.description,
    required this.remindDate,
    required this.status,
    required this.updatedAt,
  });

  int? reminderId;
  int? licenseId;
  String? name;
  String? title;
  String? description;
  DateTime? remindDate;
  String? status;
  DateTime? updatedAt;

  factory Reminder.fromJson(Map<String, dynamic> json) => Reminder(
        reminderId: json["reminder_id"] == null ? null : json["reminder_id"],
        licenseId: json["license_id"] == null ? null : json["license_id"],
        name: json["name"] == null ? null : json["name"],
        title: json["title"] == null ? null : json["title"],
        description: json["description"] == null ? null : json["description"],
        remindDate: json["remind_date"] == null
            ? null
            : DateTime.parse(json["remind_date"]),
        status: json["status"] == null ? null : json["status"],
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "reminder_id": reminderId == null ? null : reminderId,
        "license_id": licenseId == null ? null : licenseId,
        "name": name == null ? null : name,
        "title": title == null ? null : title,
        "description": description == null ? null : description,
        "remind_date":
            remindDate == null ? null : remindDate!.toIso8601String(),
        "status": status == null ? null : status,
        "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
      };
}
