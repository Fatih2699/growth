// import 'package:flutter/material.dart';
// import 'package:growth/common_widgets/drawer_widget.dart';
// import 'package:growth/common_widgets/isLoading_widget.dart';
// import 'package:growth/constants/app_constant.dart';
// import 'package:growth/models/referer_model.dart';
// import 'package:growth/screens/details_screen.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
//
// class DenemeReferer extends StatefulWidget {
//   const DenemeReferer({Key? key}) : super(key: key);
//
//   @override
//   State<DenemeReferer> createState() => _DenemeRefererState();
// }
//
// class _DenemeRefererState extends State<DenemeReferer> {
//   bool _isLoading = true;
//   var data;
//   DateTimeRange dateRange =
//       DateTimeRange(start: DateTime(2022, 4, 20), end: DateTime(2022, 5, 27));
//   final String url =
//       '...?start_date=2022-01-22&end_date=2022-04-22';
//   int? counter;
//   _changeLoading() {
//     setState(() {
//       _isLoading = !_isLoading;
//     });
//   }
//
//   var emptyresult;
//   int? sortColumnIndex;
//   bool isAscending = false;
//
//   late List<Log> logs;
//
//   Future callReferer() async {
//     SharedPreferences _prefs = await SharedPreferences.getInstance();
//     var token = _prefs.get('token');
//     try {
//       final response = await http
//           .get(Uri.parse(url), headers: {'Authorization': 'Bearer $token'});
//       var result = refererFromJson(response.body);
//       setState(() {
//         counter = result.logs.length;
//         data = result;
//         logs = result.logs;
//       });
//       _changeLoading();
//       return result;
//     } catch (e) {
//       debugPrint('HATA VAR ' + e.toString());
//     }
//   }
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     callReferer();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return _isLoading
//         ? const IsLoadingWidget()
//         : Scaffold(
//             drawer: const DrawerWidget(),
//             appBar: AppBar(
//               centerTitle: true,
//               title: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children: <Widget>[
//                   const Text(
//                     "REFERER  ",
//                     style: TextStyle(fontSize: 18),
//                   ),
//                   Text(
//                     '(${counter.toString()})',
//                   ),
//                 ],
//               ),
//               //centerTitle: true,
//               backgroundColor: ApplicationConstants.lacivert,
//             ),
//             body: Container(child: buildDataTable()),
//           );
//   }
//
//   Widget buildDataTable() {
//     final columns = [
//       'UTM-KAMPANYA',
//       'KAYIT',
//       'LEAD',
//       'SATIŞ',
//     ];
//     return SingleChildScrollView(
//       scrollDirection: Axis.vertical,
//       child: DataTable(
//         showCheckboxColumn: true,
//         headingRowColor: MaterialStateProperty.all(ApplicationConstants.yesil),
//         decoration: const BoxDecoration(shape: BoxShape.circle),
//         sortAscending: isAscending,
//         sortColumnIndex: sortColumnIndex,
//         columns: getColumns(columns),
//         rows: getRows(logs),
//       ),
//     );
//   }
//
//   List<DataColumn> getColumns(List<String> columns) => columns
//       .map(
//         (String column) => DataColumn(
//           label: Text(
//             column,
//             style: const TextStyle(
//               color: Colors.white,
//               fontWeight: FontWeight.bold,
//               fontSize: 12,
//             ),
//           ),
//         ),
//       )
//       .toList();
//
//   int compareString(bool ascending, String value1, String value2) =>
//       ascending ? value1.compareTo(value2) : value2.compareTo(value1);
//
//   List<DataRow> getRows(List<Log> data) => data.map((Log log) {
//         final cells = [
//           log.source,
//           log.register,
//           log.lead,
//           log.win,
//         ];
//         return DataRow(
//           selected: true,
//           cells: getCells(cells),
//         );
//       }).toList();
//   List<DataCell> getCells(List<dynamic> cells) => cells
//       .map(
//         (data) => DataCell(
//           GestureDetector(
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => DetailPage(),
//                 ),
//               );
//             },
//             child: Text(
//               '$data',
//               style: const TextStyle(
//                   color: ApplicationConstants.lacivert,
//                   fontSize: 10,
//                   fontWeight: FontWeight.bold),
//             ),
//           ),
//         ),
//       )
//       .toList();
// }
