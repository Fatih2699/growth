// import 'package:flutter/cupertino.dart';
// import 'package:growth/models/register_model.dart';
// import 'package:growth/services/api.dart';
// import 'package:growth/services/call_api.dart';
//
// class CallApiViewModel with ChangeNotifier implements Api {
//   @override
//   Future<bool> callRegister(String page, String title, String authorized,
//       String step, String listType, String startDate, String endDate) async {
//     var data = {
//       'page': page,
//       'title': title,
//       'authorized': authorized,
//       'step': step,
//       'listType': listType,
//       'start_date': startDate,
//       'end_date': endDate
//     };
//     debugPrint("RECORD DATASI: " + data.toString());
//     var response = await CallApi().getRegister(data, 'record');
//     var result = registerFromJson(response.body);
//     if (result.record == '200') {
//       try {
//         return true;
//       } catch (e) {
//         debugPrint('HATA RECORD' + e.toString());
//       }
//       return true;
//     } else {
//       return false;
//     }
//   }
// }
