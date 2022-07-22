import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:growth/common_widgets/drawer_widget.dart';
import 'package:growth/models/utm_kampanya_model.dart';
import 'package:http/http.dart' as http;
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constants/app_constant.dart';
import 'detay.dart';

class UtmKampanya extends StatefulWidget {
  final String source;
  final String? type;
  const UtmKampanya({Key? key, required this.source, this.type})
      : super(key: key);

  @override
  State<UtmKampanya> createState() => _UtmKampanyaState();
}

class _UtmKampanyaState extends State<UtmKampanya> {
  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener((pageKey) {
      callUtmKampanya(pageKey, _pagingController, filters: _filters);
    });
  }

  final PagingController<int, Map<String, dynamic>> _pagingController =
      PagingController(firstPageKey: 1, invisibleItemsThreshold: 1);
  final Map<String, String> _filters = {};

  Future callUtmKampanya(int page, PagingController _controller,
      {Map<String, String>? filters}) async {
    debugPrint(page.toString());
    debugPrint('FILTERS: ' + filters.toString());
    String startDate = filters != null && filters['start_date'] != null
        ? filters['start_date']!
        : DateFormat('yyyy-MM-dd')
            .format(DateTime.now().subtract(const Duration(days: 90)));
    String endDate = filters != null && filters['end_date'] != null
        ? filters['end_date']!
        : DateFormat('yyyy-MM-dd').format(DateTime.now());
    String type = '';
    if (widget.type != null && widget.type != 'all') {
      type = '&type=${widget.type}';
    }
    String source = widget.source;
    String search =
        filters != null && filters['search'] != null ? filters['search']! : '';
    String url = Uri.encodeFull(
        '...start_date=$startDate&end_date=$endDate$type&source=$source&search_text=$search&page=$page');
    debugPrint(url);
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    var token = _prefs.get('token');
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      var result = utmKampanyaFromJson(response.body);
      List<Map<String, dynamic>> data = [];
      for (var index = 0; index < result.logs.length; index++) {
        Map<String, dynamic> item = {
          'id': result.logs[index].id,
          'license_id': result.logs[index].licenseId,
          'company_name': result.logs[index].companyName,
          'name': result.logs[index].name,
          'ad_soyad': result.logs[index].adSoyad,
          'gib_onay': result.logs[index].gibOnay,
          'bank_secim': result.logs[index].bankSecim,
          'demo_veri': result.logs[index].demoVeri,
          'ref_code': result.logs[index].refCode,
          'status': result.logs[index].status,
          'type': result.logs[index].type,
          'license_type': result.logs[index].licenseType,
          'package_type': result.logs[index].packageType,
          'product': result.logs[index].product,
          'log_date': result.logs[index].logDate,
          'source': result.logs[index].source,
          'referer_data': result.logs[index].refererData,
          'search_text': result.logs[index].searchText,
        };
        data.add(item);
      }
      if (data.isEmpty) {
        _controller.appendLastPage(data);
      } else {
        _controller.appendPage(data, page + 1);
      }
    } catch (e) {
      debugPrint('HATA VAR REFERER' + e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerWidget(),
      appBar: AppBar(
        elevation: 5,
        backgroundColor: ApplicationConstants.lacivert,
        title: Text(
          widget.source,
          style: TextStyle(fontSize: 18),
        ),
        centerTitle: true,
      ),
      body: PagedListView<int, Map<String, dynamic>>.separated(
          pagingController: _pagingController,
          builderDelegate:
              PagedChildBuilderDelegate(itemBuilder: (context, item, index) {
            return SizedBox(
              height: MediaQuery.of(context).size.height / 6,
              child: Card(
                color: Colors.white,
                elevation: 10,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 4,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: AutoSizeText(item['company_name'],
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                  maxLines: 2,
                                  minFontSize: 7,
                                  overflow: TextOverflow.ellipsis,
                                  maxFontSize: 13),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: ApplicationConstants.lacivert,
                                border: Border.all(width: 1.0),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(5.0),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Column(
                                  children: [
                                    Text(
                                      'M.ID: ${item['license_id']}',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                    Text(
                                      'ID: ${item['id']}',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            AutoSizeText(item['ad_soyad'],
                                maxLines: 1,
                                minFontSize: 7,
                                overflow: TextOverflow.ellipsis,
                                maxFontSize: 13)
                          ],
                        ),
                      ),
                      const SizedBox(width: 5),
                      Expanded(
                        flex: 4,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(DateFormat('dd.MM.yyyy   HH:mm')
                                .format(item['log_date'])),
                            item['search_text'] != ""
                                ? AutoSizeText(
                                    Uri.decodeFull(item['search_text']),
                                    maxLines: 3,
                                    minFontSize: 7,
                                    overflow: TextOverflow.ellipsis,
                                    maxFontSize: 13)
                                : const Text('-')
                          ],
                        ),
                      ),
                      const SizedBox(width: 5),
                      Expanded(
                        flex: 2,
                        child: TextButton(
                            child: const Text('DETAY',
                                style: TextStyle(
                                    color: ApplicationConstants.yesil)),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => UtmDetail(
                                      refererData: item['referer_data']),
                                ),
                              );
                            }),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
          separatorBuilder: (context, index) => const SizedBox()),
    );
  }
}
