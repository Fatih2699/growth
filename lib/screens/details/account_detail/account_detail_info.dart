import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../models/connected_banks_model.dart';
import 'account_transactions_part.dart';

class DetailInfo extends StatefulWidget {
  final int id;
  final String type;
  const DetailInfo({Key? key, required this.type, required this.id})
      : super(key: key);

  @override
  State<DetailInfo> createState() => _DetailInfoState();
}

class _DetailInfoState extends State<DetailInfo> {
  List connectedBank = [];
  int counter = 0;
  callConnectedBanks() async {
    String url = '.../${widget.type}/' + widget.id.toString();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    try {
      final response = await http.get(Uri.parse(url), headers: {
        'Authorization': 'Bearer $token',
      });
      var result = connectedBanksFromJson(response.body);
      setState(() {
        connectedBank = result.data;
        connectedBank.sort((a, b) => b.status.compareTo(a.status));
        counter = result.data.length;
      });
      print(result);
      return result;
    } catch (e) {
      print("HATAs: " + e.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    callConnectedBanks();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
                flex: 1,
                child: SingleChildScrollView(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height / 20,
                    child: counter == 0
                        ? const Text('Bağlı banka bulunamadı...',
                            style: TextStyle(fontWeight: FontWeight.bold))
                        : ListView.builder(
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemCount: counter,
                            itemBuilder: (context, index) {
                              bool isComplated =
                                  connectedBank[index].status.toString() == '0';
                              return Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: SizedBox(
                                  child: ColorFiltered(
                                      colorFilter: isComplated
                                          ? const ColorFilter.matrix(<double>[
                                              0.2126,
                                              0.7152,
                                              0.0722,
                                              0,
                                              0,
                                              0.2126,
                                              0.7152,
                                              0.0722,
                                              0,
                                              0,
                                              0.2126,
                                              0.7152,
                                              0.0722,
                                              0,
                                              0,
                                              0,
                                              0,
                                              0,
                                              1,
                                              0,
                                            ])
                                          : const ColorFilter
                                              .srgbToLinearGamma(),
                                      child: Image(
                                        image: NetworkImage(
                                            '.../${connectedBank[index].bankName}.jpg'),
                                      )),
                                  width: 25,
                                  height: 25,
                                ),
                              );
                            },
                          ),
                  ),
                )),
            const SizedBox(
              width: 5,
            ),
            const Text('( - / - )'),
          ],
        ),
        Expanded(
          child: widget.type == 'account_transactions'
              ? AccountTransactions(id: widget.id)
              : widget.type == 'pos_report'
                  ? const Padding(
                      padding: EdgeInsets.only(top: 25.0),
                      child: Text(
                        'Pos rapor bilgileri bulunamadı...',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    )
                  : widget.type == 'ots'
                      ? const Padding(
                          padding: EdgeInsets.only(top: 25.0),
                          child: Text(
                              'Online tahsilat sistemi bilgileri bulunamadı...',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        )
                      : const Padding(
                          padding: EdgeInsets.only(top: 25.0),
                          child: Text('Entegrasyon bilgileri bulunamadı...',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
        )
      ],
    );
  }
}
