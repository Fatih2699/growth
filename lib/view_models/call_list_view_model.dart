import 'dart:convert';

import 'package:call_log/call_log.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class CallModel with ChangeNotifier {
  Future<void> getCallsFromPhone(DateTime? lastDate) async {
    if (lastDate == null) {
      await CallLog.get().then((Iterable<CallLogEntry> value) async {
        List entries = [];
        value.forEach((entry) {
          List<CallType> types = [CallType.incoming, CallType.outgoing];
          Map<String, String> data = {
            "number": entry.number.toString(),
            "name": entry.name.toString() == "null"
                ? "Bilinmeyen Numara"
                : entry.name.toString(),
            "calltype":
                entry.callType == CallType.incoming ? 'incoming' : 'outgoing',
            "begin_date":
                DateTime.fromMillisecondsSinceEpoch(entry.timestamp!.toInt())
                    .toString(),
            "duration": entry.duration.toString(),
          };
          entries.add(data);
        });
        await submitDataNew(entries);
      });
    } else {
      await CallLog.get().then((Iterable<CallLogEntry> value) async {
        List entries = ['list'];
        value.forEach((entry) {
          DateTime startDate =
              DateTime.fromMillisecondsSinceEpoch(entry.timestamp!);
          List<CallType> types = [CallType.incoming, CallType.outgoing];
          if (lastDate.difference(startDate).inMinutes < 0 &&
              types.contains(entry.callType)) {
            Map<String, String> data = {
              "number": entry.number.toString(),
              "name": entry.name.toString() == "null"
                  ? "Bilinmeyen Numara"
                  : entry.name.toString(),
              "calltype":
                  entry.callType == CallType.incoming ? 'incoming' : 'outgoing',
              "begin_date":
                  DateTime.fromMillisecondsSinceEpoch(entry.timestamp!.toInt())
                      .toString(),
              "duration": entry.duration.toString(),
            };
            entries.add(data);
          }
        });
        print(entries.length);
        await submitDataNew(entries);
      });
    }
  }

  Future<void> submitDataNew(entry) async {
    String url = 'http://192.168.1.15:8000/api/phonetest';
    var response =
        await http.post(Uri.parse(url), body: {"calls": jsonEncode(entry)});
  }
}
