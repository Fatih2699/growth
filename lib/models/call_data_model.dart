// import 'dart:convert';
//
// CallDataModel callDataFromJson(String str) =>
//     CallDataModel.fromJson(json.decode(str));
//
// String callDataToJson(CallDataModel data) => json.encode(data.toJson());
//
// class CallDataModel {
//   CallDataModel({
//     required this.list,
//     required this.lastDataTime,
//   });
//
//   List<ListElement> list;
//   DateTime lastDataTime;
//
//   factory CallDataModel.fromJson(Map<String, dynamic> json) => CallDataModel(
//         list: List<ListElement>.from(
//             json["list"].map((x) => ListElement.fromJson(x))),
//         lastDataTime: DateTime.parse(json["last   _data_time"]),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "list": List<dynamic>.from(list.map((x) => x.toJson())),
//         "last   _data_time": lastDataTime.toIso8601String(),
//       };
// }
//
// class ListElement {
//   ListElement({
//     required this.id,
//     required this.name,
//     required this.number,
//     required this.duration,
//     required this.calltype,
//     required this.beginDate,
//     required this.createdAt,
//     required this.updatedAt,
//   });
//
//   int id;
//   String name;
//   String number;
//   int duration;
//   String calltype;
//   DateTime beginDate;
//   DateTime createdAt;
//   DateTime updatedAt;
//
//   factory ListElement.fromJson(Map<String, dynamic> json) => ListElement(
//         id: json["id"],
//         name: json["name"],
//         number: json["number"],
//         duration: json["duration"],
//         calltype: json["calltype"],
//         beginDate: DateTime.parse(json["begin_date"]),
//         createdAt: DateTime.parse(json["created_at"]),
//         updatedAt: DateTime.parse(json["updated_at"]),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "name": name,
//         "number": number,
//         "duration": duration,
//         "calltype": calltype,
//         "begin_date": beginDate.toIso8601String(),
//         "created_at": createdAt.toIso8601String(),
//         "updated_at": updatedAt.toIso8601String(),
//       };
// }
