// import 'package:flutter/material.dart';
// import 'package:growth/common_widgets/common_list_widget.dart';
// import 'package:growth/models/register_model.dart';
// import 'package:http/http.dart' as http;
// import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
// import 'package:intl/intl.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// class DenemeSayfalama2 extends StatefulWidget {
//   const DenemeSayfalama2({Key? key}) : super(key: key);
//
//   @override
//   State<DenemeSayfalama2> createState() => _DenemeSayfalama2State();
// }
//
// class _DenemeSayfalama2State extends State<DenemeSayfalama2> {
//   Future sayfalaVeFiltrele(int page, PagingController _controller,
//       {Map<String, String>? filters}) async {
//     debugPrint(page.toString());
//     print("FILTERSS:" + filters.toString());
//     String startDate = filters != null && filters['start_date'] != null
//         ? filters['start_date']!
//         : DateFormat('yyyy-MM-dd')
//             .format(DateTime.now().subtract(const Duration(days: 90)));
//     String endDate = filters != null && filters['end_date'] != null
//         ? filters['end_date']!
//         : DateFormat('yyyy-MM-dd').format(DateTime.now());
//     String title =
//         filters != null && filters['title'] != null ? filters['title']! : '';
//     String authorized = filters != null && filters['authorized'] != null
//         ? filters['authorized']!
//         : '';
//     String url = Uri.encodeFull( '...page=$page&title=$title&authorized=$authorized&step=&listType=all&start_date=$startDate&end_date=$endDate');
//     SharedPreferences _prefs = await SharedPreferences.getInstance();
//     var token = _prefs.getString('token');
//     print(url);
//     try {
//       final response = await http.get(
//         Uri.parse(url),
//         headers: {
//           'Authorization': 'Bearer $token',
//         },
//       );
//       var result = registerFromJson(response.body);
//       List<Map<String, dynamic>> data = [];
//       for (var index = 0; index < result.record.length; index++) {
//         String formattedDate = "-";
//         if (result.record[index].lastLoginDate != null) {
//           formattedDate = DateFormat('dd/MM/yyyy')
//               .format(result.record[index].lastLoginDate!);
//         }
//         var names = result.record[index].adminUser.toString().split('#');
//         Map<String, dynamic> item = {
//           "title": result.record[index].companyTitle,
//           "license_type": result.record[index].licenseType == 'Kurumsal'
//               ? 'assets/icons/verified.png'
//               : 'assets/icons/non_verified.png',
//           "name": names[0],
//           "number": names[1],
//           "email": names[2],
//           "code": result.record[index].code,
//           "date": formattedDate,
//           "last_login_name": result.record[index].lastLoginName,
//           "last_login_date": result.record[index].lastLoginDate,
//           'id': result.record[index].id,
//         };
//         data.add(item);
//       }
//       if (data.isEmpty) {
//         _controller.appendLastPage(data);
//       } else {
//         _controller.appendPage(data, page + 1);
//       }
//     } catch (e) {
//       debugPrint('FİLTRELEME HATA VAR: ' + e.toString());
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return CommonPaginatedList(
//       getData: sayfalaVeFiltrele,
//     );
//   }
// }
