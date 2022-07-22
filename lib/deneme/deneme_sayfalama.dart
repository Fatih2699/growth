// import 'package:flutter/material.dart';
// import 'package:growth/common_widgets/common_list_widget.dart';
// import 'package:growth/common_widgets/isLoading_widget.dart';
// import 'package:growth/models/register_model.dart';
// import 'package:growth/screens/details/detail_screen.dart';
// import 'package:http/http.dart' as http;
// import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
// import 'package:intl/intl.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// class DenemeSayfalama extends StatefulWidget {
//   const DenemeSayfalama({Key? key}) : super(key: key);
//
//   @override
//   State<DenemeSayfalama> createState() => _DenemeSayfalamaState();
// }
//
// class _DenemeSayfalamaState extends State<DenemeSayfalama> {
//   bool _isLoading = false;
//   List<Map<String, dynamic>> _data = [];
//
//   changeLoading() {
//     setState(() {
//       _isLoading = !_isLoading;
//     });
//   }
//
//   Future sayfala(String title, String authorized, String? startDate,
//       String? endDate, int page,
//       {bool? isOutside}) async {
//     if (isOutside == true) {
//       changeLoading();
//     }
//     String url =
//         '...page=$page&title=$title&authorized=$authorized&step=&listType=all&start_date=$startDate&end_date=$endDate';
//     SharedPreferences _prefs = await SharedPreferences.getInstance();
//     var token = _prefs.getString('token');
//     try {
//       final response = await http.get(
//         Uri.parse(url),
//         headers: {
//           'Authorization': 'Bearer $token',
//         },
//       );
//       var result = registerFromJson(response.body);
//       for (var index = 0; index < result.record.length; index++) {
//         String formattedDate = "-";
//         if (result.record[index].lastLoginDate != null) {
//           formattedDate = DateFormat('dd/MM/yyyy')
//               .format(result.record[index].lastLoginDate!);
//         }
//         var names = result.record[index].adminUser.toString().split('#');
//         Map<String, dynamic> test = {
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
//           //'timeago':  timeago.format(DateTime.parse(widget.customer.users[index].lastActivity), locale: 'tr')
//         };
//         _data.add(test);
//       }
//
//       if (result.record.isEmpty) {
//         _pagingController.appendLastPage(result.record);
//       } else {
//         _pagingController.appendPage(result.record, page + 1);
//       }
//     } catch (e) {
//       _pagingController.error = e.toString();
//       debugPrint('FİLTRELEME HATA VAR: ' + e.toString());
//     }
//   }
//
//   DateTimeRange dateRange = DateTimeRange(
//     start: DateTime.now().subtract(
//       const Duration(days: 90),
//     ),
//     end: DateTime.now(),
//   );
//
//   TextEditingController con = TextEditingController();
//   TextEditingController title = TextEditingController(text: '');
//   TextEditingController authorized = TextEditingController(text: '');
//   final PagingController<int, Record> _pagingController =
//       PagingController(firstPageKey: 1);
//   @override
//   void initState() {
//     var start = DateFormat('yyyy-MM-dd').format(dateRange.start);
//     var end = DateFormat('yyyy-MM-dd').format(dateRange.end);
//     // TODO: implement initState
//     super.initState();
//     _pagingController.addPageRequestListener((pageKey) {
//       print(pageKey);
//       sayfala(title.text, authorized.text, start.toString(), end.toString(),
//           pageKey);
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return
//         //   Scaffold(
//         //   body: PagedListView<int, Record>.separated(
//         //     pagingController: _pagingController,
//         //     builderDelegate: PagedChildBuilderDelegate<Record>(
//         //       itemBuilder: (context, result, index) => GestureDetector(
//         //         onTap: () => Navigator.push(
//         //           context,
//         //           MaterialPageRoute(
//         //             builder: (context) => DetailScreen(
//         //               id: result.id,
//         //             ),
//         //           ),
//         //         ),
//         //         child: Card(
//         //           child: Column(
//         //             mainAxisAlignment: MainAxisAlignment.start,
//         //             crossAxisAlignment: CrossAxisAlignment.start,
//         //             children: <Widget>[
//         //               Text(result.companyTitle!),
//         //               Row(
//         //                 children: <Widget>[
//         //                   Text(result.licenseType!),
//         //                   const SizedBox(
//         //                     width: 5,
//         //                   ),
//         //                   Container(
//         //                     decoration: BoxDecoration(
//         //                         borderRadius: BorderRadius.circular(5),
//         //                         color: ApplicationConstants.lacivert),
//         //                     child: Text(
//         //                       result.code!,
//         //                       style: const TextStyle(color: Colors.white),
//         //                     ),
//         //                   )
//         //                 ],
//         //               ),
//         //             ],
//         //           ),
//         //         ),
//         //       ),
//         //     ),
//         //     separatorBuilder: (context, index) => const Divider(),
//         //   ),
//         // );
//         Scaffold(
//       body: _isLoading
//           ? const IsLoadingWidget()
//           : CommonListWidget(
//               child: PagedListView<int, Record>.separated(
//                 pagingController: _pagingController,
//                 builderDelegate: PagedChildBuilderDelegate<Record>(
//                   itemBuilder: (context, item, index) => GestureDetector(
//                     onTap: () => Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => DetailScreen(
//                           id: item.id,
//                         ),
//                       ),
//                     ),
//                     child: Text(item.companyTitle.toString()),
//                   ),
//                 ),
//                 separatorBuilder: (context, index) => const Divider(),
//               ),
//               test: sayfala),
//     );
//   }
// }
