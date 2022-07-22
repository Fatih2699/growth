import 'package:flutter/material.dart';
import 'package:growth/common_widgets/common_packets.dart';
import 'package:growth/models/package_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timeago/timeago.dart' as timeago;

class PackageDetailScreen extends StatefulWidget {
  final int? id;
  const PackageDetailScreen({Key? key, required this.id}) : super(key: key);

  @override
  State<PackageDetailScreen> createState() => _PackageDetailScreenState();
}

class _PackageDetailScreenState extends State<PackageDetailScreen> {
  @override
  void initState() {
    super.initState();
    timeago.setLocaleMessages('tr', timeago.TrMessages());
    callPaketDeneme();
  }

  String timeAgo(DateTime d) {
    Duration diff = DateTime.now().difference(d);
    print(DateTime.now().toString() +
        '-->' +
        d.toString() +
        '-->' +
        diff.inHours.toString());
    return diff.inHours.toString();
  }

  int? counter;
  var denemeResult;
  var denemePaketResult;
  bool _isLoading = true;
  void _changeLoading() async {
    setState(() {
      _isLoading = !_isLoading;
    });
  }

  Future callPaketDeneme() async {
    String url = '...license_id=' + widget.id.toString();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    try {
      final response = await http.get(Uri.parse(url), headers: {
        'Authorization': 'Bearer $token',
      });
      var result = paketDetayFromJson(response.body);
      setState(() {
        denemePaketResult = result;
      });
      _changeLoading();
      return result;
    } catch (e) {
      print("HATA: " + e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    Map<String, String> tests = {
      "account_transaction_info": "HESAP HAREKETLERİ",
      "virtual_pos_info": "OTS",
      "physical_pos_info": "POS RAPOR",
      "vomsis_pos_info": "VOMSİS POS",
      "erp_entegrasyon_info": "ERP ENTEGRASYON",
      "toplu_odeme_info": "TOPLU ÖDEME",
    };
    return _isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : SingleChildScrollView(
            child: Column(
              children: tests.entries.map(
                (entry) {
                  SInfo? packageInfo;
                  switch (entry.key) {
                    case 'account_transaction_info':
                      packageInfo = denemePaketResult.accountTransactionsInfo;
                      break;
                    case 'virtual_pos_info':
                      packageInfo = denemePaketResult.virtualPosInfo;
                      break;
                    case 'physical_pos_info':
                      packageInfo = denemePaketResult.physicalPosInfo;
                      break;
                    case 'vomsis_pos_info':
                      packageInfo = denemePaketResult.vomsisPosInfo;
                      break;
                    case 'erp_entegrasyon_info':
                      packageInfo = denemePaketResult.erpEntegrasyonInfo;
                      break;
                    case 'toplu_odeme_info':
                      packageInfo = denemePaketResult.topluOdemeInfo;
                      break;
                  }
                  return CommonPackets(
                    title: entry.value,
                    package: packageInfo,
                  );
                },
              ).toList(),
            ),
          );
  }
}
