// To parse this JSON data, do
//
//     final notes = notesFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

Notes notesFromJson(String str) => Notes.fromJson(json.decode(str));

String notesToJson(Notes data) => json.encode(data.toJson());

class Notes {
  var noteId;

    Notes({
        required this.success,
        required this.notes,
    });

    bool success;
    List<Note> notes;

    factory Notes.fromJson(Map<String, dynamic> json) => Notes(
        success: json["success"],
        notes: List<Note>.from(json["notes"].map((x) => Note.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "notes": List<dynamic>.from(notes.map((x) => x.toJson())),
    };
}

class Note {
    Note({
        required this.noteId,
        required this.licenseId,
        required this.note,
        required this.updaterUser,
        required this.updatedAt,
        required this.createdAt,
    });

    int? noteId;
    int? licenseId;
    String? note;
    String? updaterUser;
    DateTime updatedAt;
    DateTime createdAt;

    factory Note.fromJson(Map<String, dynamic> json) => Note(
        noteId: json["note_id"],
        licenseId: json["license_id"],
        note: json["note"],
        updaterUser: json["updater_user"],
        updatedAt: DateTime.parse(json["updated_at"]),
        createdAt: DateTime.parse(json["created_at"]),
    );

    Map<String, dynamic> toJson() => {
        "note_id": noteId,
        "license_id": licenseId,
        "note": note,
        "updater_user": updaterUser,
        "updated_at": updatedAt.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
    };
}
