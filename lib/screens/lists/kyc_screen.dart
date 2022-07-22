import 'package:flutter/material.dart';
import 'package:growth/common_widgets/drawer_widget.dart';
import 'package:growth/constants/app_constant.dart';
import 'package:growth/models/kyc_model.dart';
import 'package:growth/screens/details/detail_screen.dart';
import 'package:growth/screens/details/note_screen.dart';
import 'package:http/http.dart' as http;
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class KYCScreen extends StatefulWidget {
  const KYCScreen({Key? key}) : super(key: key);
  @override
  State<KYCScreen> createState() => _KYCScreenState();
}

class _KYCScreenState extends State<KYCScreen> {
  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener((pageKey) {
      callKyc(pageKey, _pagingController, filters: _filters);
    });
  }

  final PagingController<int, Map<String, dynamic>> _pagingController =
      PagingController(firstPageKey: 1, invisibleItemsThreshold: 1);
  final Map<String, String> _filters = {};
  final TextEditingController _mincontroller = TextEditingController();
  final TextEditingController _maxcontroller = TextEditingController();
  DateTimeRange dateRange =
      DateTimeRange(start: DateTime(2022, 4, 20), end: DateTime(2022, 5, 27));
  String endDate = DateFormat(
    'yyyy-MM-dd',
  ).format(DateTime.now());
  String startDate = DateFormat(
    'yyyy-MM-dd',
  ).format(DateTime.now().subtract(const Duration(days: 90)));

  Future callKyc(int page, PagingController _controller,
      {Map<String, String>? filters}) async {
    debugPrint(page.toString());
    print("FILTERSS:" + filters.toString());
    String startDate = filters != null && filters['start_date'] != null
        ? filters['start_date']!
        : DateFormat('yyyy-MM-dd')
            .format(DateTime.now().subtract(const Duration(days: 90)));
    String endDate = filters != null && filters['end_date'] != null
        ? filters['end_date']!
        : DateFormat('yyyy-MM-dd').format(DateTime.now());
    String max =
        filters != null && filters['max'] != null ? filters['max']! : '';
    String min =
        filters != null && filters['min'] != null ? filters['min']! : '';
    String url =
        '...page=$page&start=$startDate&end=$endDate&minPoint=$min&maxPoint=$max';
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    var token = _prefs.get('token');
    print(url);
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      var result = kycFromJson(response.body);
      List<Map<String, dynamic>> data = [];
      for (var index = 0; index < result.data.length; index++) {
        String created_at = '-';
        if (result.data[index].createdAt != null) {
          created_at =
              DateFormat('dd/MM/yyyy').format(result.data[index].createdAt);
        }
        Map<String, dynamic> item = {
          'license_id': result.data[index].licenseId,
          'code': result.data[index].code,
          'company_title': result.data[index].companyTitle,
          'point': result.data[index].point,
          'customer_status': result.data[index].customerStatus,
          'note': result.data[index].note,
          'created_at': result.data[index].createdAt,
        };
        data.add(item);
      }
      if (data.isEmpty) {
        _controller.appendLastPage(data);
      } else {
        _controller.appendPage(data, page + 1);
      }
    } catch (e) {
      debugPrint('HATA VAR KYC: ' + e.toString());
    }
  }

  Future pickDateRange() async {
    DateTimeRange? newDateRange = await showDateRangePicker(
      context: context,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
      initialDateRange: dateRange,
    );
    if (newDateRange == null) return;
    setState(() => dateRange = newDateRange);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerWidget(),
      appBar: AppBar(
        elevation: 5,
        backgroundColor: ApplicationConstants.lacivert,
        title: const Text(
          "KYC",
          style: TextStyle(fontSize: 18),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                TextButton(
                  child: Text(
                    DateFormat('dd.MM.yyyy').format(dateRange.end),
                    style: const TextStyle(fontSize: 15),
                  ),
                  style:
                      TextButton.styleFrom(primary: ApplicationConstants.mor),
                  onPressed: pickDateRange,
                ),
                const SizedBox(
                  width: 12,
                ),
                Container(
                  height: 40,
                  width: 65,
                  padding: EdgeInsets.zero,
                  child: Center(
                    child: TextField(
                      controller: _mincontroller,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                            borderSide: const BorderSide(color: Colors.red),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.red, width: 2.0),
                          ),
                          hintStyle: const TextStyle(color: Colors.red),
                          hintText: 'MIN: ',
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 10)),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Container(
                  height: 40,
                  width: 65,
                  padding: EdgeInsets.zero,
                  child: Center(
                    child: TextField(
                      controller: _maxcontroller,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.green, width: 2.0),
                          ),
                          hintStyle: const TextStyle(color: Colors.green),
                          hintText: 'MAX: ',
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 10)),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _filters['start_date'] =
                              DateFormat('yyyy-MM-dd').format(dateRange.start);
                          _filters['end_date'] =
                              DateFormat('yyyy-MM-dd').format(dateRange.end);
                          _filters['max'] = _maxcontroller.text;
                          _filters['min'] = _mincontroller.text;
                        });
                        _pagingController.refresh();
                      },
                      child: const Text('Filtrele'),
                      style: ElevatedButton.styleFrom(
                          primary: ApplicationConstants.lacivert),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: PagedListView<int, Map<String, dynamic>>.separated(
                pagingController: _pagingController,
                builderDelegate: PagedChildBuilderDelegate(
                    itemBuilder: (context, item, index) {
                  var color = Colors.white;
                  if (int.parse(item['point']) > 35) {
                    color = Colors.green;
                  } else if (int.parse(item['point']) < 25) {
                    color = Colors.red;
                  } else {
                    color = Colors.orange;
                  }
                  return GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailScreen(
                          id: item['license_id'],
                        ),
                      ),
                    ),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height / 6,
                      child: Card(
                        color: Colors.white,
                        elevation: 10,
                        child: Padding(
                          padding: const EdgeInsets.all(5),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      item['company_title'],
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      softWrap: false,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                    flex: 4,
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                border: Border.all(
                                                    color: ApplicationConstants
                                                        .lacivert,
                                                    width: 1.0),
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
                                            const SizedBox(width: 15),
                                            Container(
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                border: Border.all(
                                                    color: ApplicationConstants
                                                        .yesil,
                                                    width: 1.0),
                                                borderRadius:
                                                    const BorderRadius.all(
                                                  Radius.circular(5.0),
                                                ),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(5.0),
                                                child: Text(
                                                    item['license_id']
                                                        .toString(),
                                                    style: const TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 14,
                                            ),
                                            Expanded(
                                              child: Column(
                                                children: <Widget>[
                                                  const Icon(
                                                    Icons.star,
                                                    color: Colors.amber,
                                                  ),
                                                  // const Text(
                                                  //   "PUAN",
                                                  //   overflow:
                                                  //       TextOverflow.ellipsis,
                                                  //   softWrap: false,
                                                  // ),
                                                  Text(
                                                    item['point'],
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    softWrap: false,
                                                    style:
                                                        TextStyle(color: color),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          DateFormat('dd/MM/yyyy')
                                              .format(item['created_at']),
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      children: <Widget>[
                                        ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            primary:
                                                ApplicationConstants.lacivert,
                                          ),
                                          onPressed: () {
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  backgroundColor:
                                                      ApplicationConstants
                                                          .yesil,
                                                  title: const Text(
                                                    'SON NOT',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  content: Text(
                                                    item['note'],
                                                    style: const TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  actions: <Widget>[
                                                    MaterialButton(
                                                      onPressed: () {
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder:
                                                                (context) =>
                                                                    NotesScreen(
                                                              id: item[
                                                                  'license_id'],
                                                              title: item[
                                                                  'company_title'],
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                      child: const Text(
                                                        'Tüm notlara git',
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                                    MaterialButton(
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                      child: const Text(
                                                        'Geri Gel',
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                                  ],
                                                );
                                              },
                                            );
                                          },
                                          child: const Text('Son Not'),
                                        ),
                                      ],
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
                separatorBuilder: (context, index) => const SizedBox(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
