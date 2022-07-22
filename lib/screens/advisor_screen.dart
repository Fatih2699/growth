import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:growth/common_widgets/drawer_widget.dart';
import 'package:growth/common_widgets/search_row_widget.dart';
import 'package:growth/constants/app_constant.dart';
import 'package:growth/models/advisor_model.dart';
import 'package:growth/screens/details/detail_screen.dart';
import 'package:http/http.dart' as http;
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timeago/timeago.dart' as timeago;

class AdvisorScreen extends StatefulWidget {
  const AdvisorScreen({Key? key}) : super(key: key);

  @override
  State<AdvisorScreen> createState() => _AdvisorScreenState();
}

class _AdvisorScreenState extends State<AdvisorScreen> {
  TextEditingController con = TextEditingController();
  @override
  void initState() {
    super.initState();
    timeago.setLocaleMessages('tr', timeago.TrMessages());
    _pagingController.addPageRequestListener((pageKey) {
      callAdvisor(pageKey, _pagingController, filters: _filters);
    });
  }

  final PagingController<int, Map<String, dynamic>> _pagingController =
      PagingController(firstPageKey: 1, invisibleItemsThreshold: 1);
  final Map<String, String> _filters = {};

  String timeAgo(DateTime d) {
    Duration diff = DateTime.now().difference(d);
    return diff.inHours.toString();
  }

  Future callAdvisor(int page, PagingController _controller,
      {Map<String, String>? filters}) async {
    debugPrint(page.toString());
    debugPrint('FILTERS: ' + filters.toString());
    String title =
        filters != null && filters['title'] != null ? filters['title']! : '';
    String authorized = filters != null && filters['authorized'] != null
        ? filters['authorized']!
        : '';
    String url = Uri.encodeFull(
        '...?page=$page&title=$title&authorized$authorized=&dashboard_filter_type=hepsi');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    print(url);
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      var result = advisorFromJson(response.body);
      List<Map<String, dynamic>> data = [];
      for (var index = 0; index < result.customersAdviser.length; index++) {
        Map<String, dynamic> item = {
          'id': result.customersAdviser[index].id,
          'code': result.customersAdviser[index].code,
          'company_title': result.customersAdviser[index].companyTitle,
          'license_type': result.customersAdviser[index].licenseType,
          'name': result.customersAdviser[index].name,
          'phone': result.customersAdviser[index].phone,
          'email': result.customersAdviser[index].email,
          'taxpayer_count': result.customersAdviser[index].taxpayerCount,
          'active_taxpayer_count':
              result.customersAdviser[index].activeTaxpayerCount,
          'passive_taxpayer_count':
              result.customersAdviser[index].passiveTaxpayerCount,
          'customer_taxpayer_count':
              result.customersAdviser[index].customerTaxpayerCount,
          'created_at': result.customersAdviser[index].createdAt,
          'note': result.customersAdviser[index].note,
          'last_login_name': result.customersAdviser[index].lastLoginName,
          'last_login_date': result.customersAdviser[index].lastLoginDate,
        };
        data.add(item);
      }
      if (data.isEmpty) {
        _controller.appendLastPage(data);
      } else {
        _controller.appendPage(data, page + 1);
      }
    } catch (e) {
      debugPrint("HATA VAR ADVISER: " + e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController title = TextEditingController();
    TextEditingController authorized = TextEditingController();
    return Scaffold(
      drawer: const DrawerWidget(),
      appBar: AppBar(
        elevation: 5,
        backgroundColor: ApplicationConstants.lacivert,
        title: const Text(
          "MÜŞAVİRLER",
          style: TextStyle(fontSize: 18),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          //burda overflow hatası veriyor ADvisor sayfası
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: SearchRowWidget(),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: title,
                      decoration: InputDecoration(
                        contentPadding:
                            const EdgeInsets.symmetric(vertical: 15),
                        hintText: ' Firma Adı...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6.0),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Expanded(
                    child: TextField(
                      controller: authorized,
                      decoration: InputDecoration(
                        contentPadding:
                            const EdgeInsets.symmetric(vertical: 15),
                        hintText: ' Yetkili Kişi...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6.0),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: ApplicationConstants.lacivert),
                      onPressed: () {
                        setState(() {
                          _filters['title'] = title.text;
                          _filters['authorized'] = authorized.text;
                        });
                        _pagingController.refresh();
                      },
                      child: const Text('Filtrele'),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: PagedListView<int, Map<String, dynamic>>.separated(
                  pagingController: _pagingController,
                  builderDelegate: PagedChildBuilderDelegate(
                      itemBuilder: (context, item, index) {
                    return SizedBox(
                      height: MediaQuery.of(context).size.height / 4.3,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  DetailScreen(id: item['id']),
                            ),
                          );
                        },
                        child: Card(
                          color: Colors.white,
                          elevation: 10,
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 3,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Expanded(
                                                child: AutoSizeText(
                                                  item['company_title'],
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                  maxLines: 3,
                                                  minFontSize: 7,
                                                  softWrap: false,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxFontSize: 16,
                                                ),
                                                flex: 2,
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 10),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              AutoSizeText(
                                                item['name'],
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.w800,
                                                ),
                                                maxLines: 1,
                                                minFontSize: 7,
                                                softWrap: false,
                                                overflow: TextOverflow.ellipsis,
                                                maxFontSize: 14,
                                              ),
                                            ],
                                          ),
                                          AutoSizeText(
                                            item['phone'],
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w800,
                                            ),
                                            maxLines: 1,
                                            minFontSize: 7,
                                            softWrap: false,
                                            overflow: TextOverflow.ellipsis,
                                            maxFontSize: 14,
                                          ),
                                          AutoSizeText(
                                            item['email'],
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w800,
                                            ),
                                            maxLines: 1,
                                            minFontSize: 7,
                                            softWrap: false,
                                            overflow: TextOverflow.ellipsis,
                                            maxFontSize: 14,
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            CircleAvatar(
                                              backgroundColor:
                                                  Colors.transparent,
                                              child: Image.asset(
                                                item['license_type'] ==
                                                        'Kurumsal'
                                                    ? 'assets/icons/verified.png'
                                                    : 'assets/icons/non_verified.png',
                                                fit: BoxFit.cover,
                                                height: 20,
                                                width: 20,
                                              ),
                                            ),
                                            item['last_login_date'] != null
                                                ? Text(DateFormat(
                                                        'dd.MM.yyyy   H:m')
                                                    .format(item[
                                                        'last_login_date']))
                                                : const Text('-'),
                                            const SizedBox(height: 5),
                                            item['last_login_date'] != null
                                                ? Text(
                                                    timeago.format(
                                                        DateTime.parse(item[
                                                                'last_login_date']
                                                            .toString()),
                                                        locale: 'tr'),
                                                    style: const TextStyle(
                                                        color: Colors.green),
                                                  )
                                                : const Text('-'),
                                            const SizedBox(height: 5),
                                            Container(
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                border: Border.all(
                                                    color: ApplicationConstants
                                                        .lacivert,
                                                    width: 3.0),
                                                borderRadius:
                                                    const BorderRadius.all(
                                                  Radius.circular(5.0),
                                                ),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(5.0),
                                                child: Text(item['code'],
                                                    style: const TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                              ),
                                            ),
                                          ],
                                        ),
                                        flex: 2)
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Container(
                                      decoration: const BoxDecoration(
                                        color: Colors.red,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(8.0),
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Text(
                                            item['taxpayer_count'].toString() +
                                                " Mükellef",
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold)),
                                      ),
                                    ),
                                    Container(
                                      decoration: const BoxDecoration(
                                        color: Colors.pink,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(8.0),
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Text(
                                            item['active_taxpayer_count']
                                                    .toString() +
                                                " Banka",
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold)),
                                      ),
                                    ),
                                    Container(
                                      decoration: const BoxDecoration(
                                        color: Colors.orangeAccent,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(8.0),
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Text(
                                            item['passive_taxpayer_count']
                                                    .toString() +
                                                " Etkisiz",
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold)),
                                      ),
                                    ),
                                    Container(
                                      decoration: const BoxDecoration(
                                        color: Colors.blue,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(8.0),
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Text(
                                            item['customer_taxpayer_count']
                                                    .toString() +
                                                " Etkin",
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold)),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                  separatorBuilder: (context, index) => const SizedBox()),
            ),
            const SizedBox(
              height: 8,
            ),
          ],
        ),
      ),
    );
  }
}
