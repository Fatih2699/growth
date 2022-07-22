import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../models/account_detail_model.dart';

class AccountTransactions extends StatefulWidget {
  final int? id;
  const AccountTransactions({Key? key, this.id}) : super(key: key);

  @override
  State<AccountTransactions> createState() => _AccountTransactionsState();
}

class _AccountTransactionsState extends State<AccountTransactions> {
  var denemeResult;
  bool _isLoading = true;

  void _changeLoading() async {
    setState(() {
      _isLoading = !_isLoading;
    });
  }

  @override
  void initState() {
    super.initState();
    bankLogs();
  }

  Future bankLogs() async {
    String url = '...' + widget.id.toString();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    try {
      final response = await http.get(Uri.parse(url), headers: {
        'Authorization': 'Bearer $token',
      });
      var result = hesapDetayFromJson(response.body);
      setState(() {
        denemeResult = result;
      });
      _changeLoading();
      return result;
    } catch (e) {
      print("HATAs: " + e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Container(
            //height: 200,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          )
        : Padding(
            padding: const EdgeInsets.only(
                left: 10.0, right: 10, bottom: 10, top: 20),
            child: Column(
              children: [
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const [
                    Text(
                      'HESAP BİLGİLERİ',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF5c59ef),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                  flex: 7,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        ListView.builder(
                            controller: ScrollController(),
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: denemeResult.bankLogs.length,
                            itemBuilder: (context, index) {
                              String serviceLastUpdated = "-";
                              String lastTransactionDate = "-";
                              if (denemeResult
                                      .bankLogs[index].serviceLastUpdated !=
                                  null) {
                                serviceLastUpdated =
                                    DateFormat('dd.MM.yyyy  H:m').format(
                                        denemeResult.bankLogs[index]
                                            .serviceLastUpdated);
                              }
                              if (denemeResult
                                      .bankLogs[index].lastTransactionDate !=
                                  null) {
                                lastTransactionDate =
                                    DateFormat('dd.MM.yyyy  H:m').format(
                                        denemeResult.bankLogs[index]
                                            .lastTransactionDate);
                              }
                              return Card(
                                elevation: 5,
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            children: [
                                              Text(
                                                  denemeResult.bankLogs[index]
                                                      .customerBankTitle
                                                      .toString(),
                                                  style: const TextStyle(
                                                      color: Color(0xFF06113C),
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 15)),
                                              Text(denemeResult.bankLogs[index]
                                                          .connectionType ==
                                                      ConnectionType.API
                                                  ? '(API)'
                                                  : '(WEB SERVİS)')
                                            ],
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                          ),
                                          Column(
                                            children: [
                                              const Text('Son Çalışma',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              Text(serviceLastUpdated
                                                  .toString()),
                                            ],
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 15),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            children: [
                                              const Text('Banka Hesap Sayısı',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              Text(denemeResult.bankLogs[index]
                                                  .bankAccountCount
                                                  .toString())
                                            ],
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                          ),
                                          Column(
                                            children: [
                                              const Text('Son Hareket',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              Text(lastTransactionDate
                                                  .toString())
                                            ],
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              );
                            }),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
  }
}
