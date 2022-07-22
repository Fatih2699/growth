// import 'dart:async';
// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:growth/common_widgets/drawer_widget.dart';
// import 'package:growth/common_widgets/isLoading_widget.dart';
// import 'package:growth/view_models/call_list_view_model.dart';
// import 'package:http/http.dart' as http;
// import 'package:provider/provider.dart';
//
// class CallList extends StatefulWidget {
//   const CallList({Key? key}) : super(key: key);
//
//   @override
//   _CallListState createState() => _CallListState();
// }
//
// class _CallListState extends State<CallList> {
//   bool _isLoading = true;
//   final int _status = 0;
//   var callList = [];
//   var lastDataTime;
//   DateTime? endDate;
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     initdata();
//   }
//
//   Future<void> _callLog(lastDataTime) async {
//     final _dataModel = Provider.of<CallModel>(context, listen: false);
//     DateTime? lastDate;
//     try {
//       await _dataModel.getCallsFromPhone(lastDate);
//     } on PlatformException catch (hata) {
//       print(hata);
//     }
//   }
//
//   initdata() async {
//     String url = 'http://192.168.1.47:8000/api/phone';
//     var response = await http.get(Uri.parse(url));
//     var data = jsonDecode(response.body);
//     setState(() {
//       callList = data['list'];
//       lastDataTime = data['last_data_time'];
//     });
//     _changeLoading();
//   }
//
//   void _changeLoading() async {
//     setState(() {
//       _isLoading = !_isLoading;
//     });
//   }
//
//   Future<void> submitDataNew(entry) async {
//     String url = 'http://192.168.1.15:8000/api/phonetest';
//     var response =
//         await http.post(Uri.parse(url), body: {"calls": jsonEncode(entry)});
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     const EMPTY_TEXT = Center(
//         child: Text(
//             'Waiting for fetch events.  Simulate one.\n [Android] \$ ./scripts/simulate-fetch\n [iOS] XCode->Debug->Simulate Background Fetch'));
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: Scaffold(
//         drawer: const DrawerWidget(),
//         backgroundColor: Colors.white,
//         appBar: AppBar(
//           // actions: <Widget>[
//           //   Padding(
//           //     padding: const EdgeInsets.only(right: 20.0),
//           //     child: GestureDetector(
//           //       onTap: () async {
//           //         SharedPreferences prefs =
//           //             await SharedPreferences.getInstance();
//           //         prefs.remove('token');
//           //         Navigator.push(
//           //           context,
//           //           MaterialPageRoute(
//           //             builder: (context) => const LoginScreen(),
//           //           ),
//           //         );
//           //       },
//           //       child: const Icon(
//           //         Icons.login_outlined,
//           //         size: 26.0,
//           //       ),
//           //     ),
//           //   ),
//           // ],
//           elevation: 5,
//           backgroundColor: Colors.black,
//           title: const Text('Device Monitor'),
//         ),
//         body: Padding(
//           padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
//           child: _isLoading
//               ? const IsLoadingWidget()
//               : Center(
//                   child: Column(
//                     children: [
//                       ElevatedButton(
//                         child: const Text(
//                           'Senkronize Et',
//                           style: TextStyle(
//                               fontWeight: FontWeight.bold, fontSize: 18),
//                         ),
//                         style: ElevatedButton.styleFrom(
//                             fixedSize: const Size(180, 60),
//                             primary: const Color(0xFF92A9BD)),
//                         onPressed: () async {
//                           _changeLoading();
//                           await _callLog(lastDataTime);
//                           initdata();
//                         },
//                       ),
//                       const SizedBox(height: 20),
//                       lastDataTime != null
//                           ? Column(
//                               children: [
//                                 const Text(
//                                   'Son Senkronize Tarihi: ',
//                                   style: TextStyle(
//                                       fontWeight: FontWeight.bold,
//                                       fontSize: 18),
//                                 ),
//                                 const SizedBox(
//                                   height: 5,
//                                 ),
//                                 Text(
//                                   lastDataTime.toString(),
//                                   style: const TextStyle(
//                                       fontWeight: FontWeight.bold,
//                                       fontSize: 18),
//                                 )
//                               ],
//                             )
//                           : const SizedBox(),
//                       const SizedBox(
//                         height: 5,
//                       ),
//                       const Divider(
//                         color: Colors.black,
//                         thickness: 1,
//                       ),
//                       Expanded(
//                         child: (callList.length == 0)
//                             ? const Text("VERİ YOK")
//                             : RefreshIndicator(
//                                 onRefresh: () async {
//                                   _changeLoading();
//                                   //await getCallsFromPhone(endDate);
//                                   initdata();
//                                 },
//                                 child: ListView.builder(
//                                   itemCount: callList.length,
//                                   itemBuilder: (context, index) {
//                                     var entry = callList[index];
//                                     //String timestamp = _events[index];
//                                     var mono = const TextStyle(
//                                         fontFamily: 'monospace');
//                                     return Padding(
//                                       padding: const EdgeInsets.all(8.0),
//                                       child: Card(
//                                         color: const Color(0xFFF7F6F2),
//                                         elevation: 4,
//                                         child: Padding(
//                                           padding: const EdgeInsets.all(8.0),
//                                           child: Column(
//                                             children: <Widget>[
//                                               const Divider(),
//                                               Text('Numara: ${entry["number"]}',
//                                                   style: mono),
//                                               //DataTextWidget(text: ${entry["number"]},
//
//                                               Text(
//                                                   'İsim: ${entry["name"] == "null" ? "Bilinmeyen Numara" : entry['name']}',
//                                                   style: mono),
//                                               Text(
//                                                   'Arama Tipi: ${entry["calltype"]}',
//                                                   style: mono),
//                                               Text(
//                                                   'Tarih: ${entry["begin_date"]}',
//                                                   style: mono),
//                                               Text(
//                                                   'Geçen Süre: ${entry["duration"]}',
//                                                   style: mono),
//                                               const Divider(),
//                                               const SizedBox(height: 5),
//                                             ],
//                                             crossAxisAlignment:
//                                                 CrossAxisAlignment.start,
//                                             mainAxisAlignment:
//                                                 MainAxisAlignment.start,
//                                           ),
//                                         ),
//                                       ),
//                                     );
//                                   },
//                                 ),
//                               ),
//                       ),
//                     ],
//                   ),
//                 ),
//         ),
//       ),
//     );
//   }
// }
