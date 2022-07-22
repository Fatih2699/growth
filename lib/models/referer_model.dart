import 'dart:convert';

Referer refererFromJson(String str) => Referer.fromJson(json.decode(str));

String refererToJson(Referer data) => json.encode(data.toJson());

class Referer {
  Referer({
    required this.success,
    required this.logs,
  });

  bool success;
  List<Log> logs;

  factory Referer.fromJson(Map<String, dynamic> json) => Referer(
        success: json["success"],
        logs: List<Log>.from(json["logs"].map((x) => Log.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "logs": List<dynamic>.from(logs.map((x) => x.toJson())),
      };
}

class Log {
  Log({
    required this.source,
    required this.register,
    required this.lead,
    required this.win,
  });

  String? source;
  int? register;
  int? lead;
  int? win;

  factory Log.fromJson(Map<String, dynamic> json) => Log(
        source: json["source"] ?? '-',
        register: json["register"],
        lead: json["lead"],
        win: json["win"],
      );

  Map<String, dynamic> toJson() => {
        "source": source,
        "register": register,
        "lead": lead,
        "win": win,
      };
}
