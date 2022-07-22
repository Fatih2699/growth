import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:growth/common_widgets/search_row_widget.dart';
import 'package:growth/constants/app_constant.dart';
import 'package:growth/screens/details/detail_screen.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;

class CommonListCCWidget extends StatefulWidget {
  final Function getData;
  const CommonListCCWidget({Key? key, required this.getData}) : super(key: key);
  @override
  State<CommonListCCWidget> createState() => _CommonListCCWidgetState();
}

class _CommonListCCWidgetState extends State<CommonListCCWidget> {
  final Map<String, String> _filters = {};
  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener((pageKey) {
      print(_filters.toString());
      widget.getData(pageKey, _pagingController, filters: _filters);
    });
    timeago.setLocaleMessages('tr', timeago.TrMessages());
  }

  final PagingController<int, Map<String, dynamic>> _pagingController =
      PagingController(firstPageKey: 1);
  DateTimeRange dateRange = DateTimeRange(
    start: DateTime.now().subtract(
      const Duration(days: 90),
    ),
    end: DateTime.now(),
  );
  String timeAgo(DateTime d) {
    Duration diff = DateTime.now().difference(d);
    return diff.inHours.toString();
  }

  Future pickDateRange() async {
    DateTimeRange? newDateRange = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime(2050),
      initialDateRange: dateRange,
    );
    if (newDateRange == null) return; //press "X"
    setState(() {
      dateRange = newDateRange;
    });
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController title = TextEditingController();
    TextEditingController authorized = TextEditingController();
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            const SearchRowWidget(),
            SizedBox(
              height: 20,
            ),
            // SingleChildScrollView(
            //   child: Row(
            //     children: <Widget>[
            //       Expanded(
            //         child: TextField(
            //           controller: title,
            //           decoration: InputDecoration(
            //             contentPadding:
            //                 const EdgeInsets.symmetric(vertical: 15),
            //             hintText: ' Firma Adı...',
            //             border: OutlineInputBorder(
            //               borderRadius: BorderRadius.circular(6.0),
            //             ),
            //           ),
            //         ),
            //       ),
            //       const SizedBox(
            //         width: 12,
            //       ),
            //       Expanded(
            //         child: TextField(
            //           controller: authorized,
            //           decoration: InputDecoration(
            //             contentPadding:
            //                 const EdgeInsets.symmetric(vertical: 15),
            //             hintText: ' Yetkili Kişi...',
            //             border: OutlineInputBorder(
            //               borderRadius: BorderRadius.circular(6.0),
            //             ),
            //           ),
            //         ),
            //       ),
            //       const SizedBox(
            //         width: 12,
            //       ),
            //       Expanded(
            //         child: ElevatedButton(
            //           style: ElevatedButton.styleFrom(
            //               primary: ApplicationConstants.lacivert),
            //           onPressed: () {
            //             setState(() {
            //               _filters['title'] = title.text;
            //               _filters['authorized'] = authorized.text;
            //             });
            //             _pagingController.refresh();
            //           },
            //           child: const Text('Filtrele'),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            Expanded(
              child: PagedListView<int, Map<String, dynamic>>.separated(
                pagingController: _pagingController,
                builderDelegate: PagedChildBuilderDelegate(
                  itemBuilder: (context, item, index) {
                    return GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailScreen(id: item['id']),
                        ),
                      ),
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height / 3,
                        child: Card(
                          color: Colors.white,
                          elevation: 10,
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Expanded(
                                      child: Text(
                                        item['title'],
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        softWrap: false,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      ),
                                      flex: 10,
                                    ),
                                    Expanded(
                                      child: CircleAvatar(
                                        backgroundColor: Colors.transparent,
                                        child: Image.asset(
                                          item['license_type'],
                                          fit: BoxFit.cover,
                                          height: 20,
                                          width: 20,
                                        ),
                                      ),
                                      flex: 1,
                                    )
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    Text(
                                      item['package_name'],
                                      style: const TextStyle(
                                          color: ApplicationConstants.yesil,
                                          fontWeight: FontWeight.bold),
                                    )
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
                                          Text(
                                            item['name'],
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(item['number']),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          AutoSizeText(
                                            item['email'],
                                            maxLines: 1,
                                            minFontSize: 7,
                                            overflow: TextOverflow.ellipsis,
                                            maxFontSize: 13,
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
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
                                          )
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: <Widget>[
                                          const Text(
                                            'SON GİRİŞ',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            item['last_login_name'],
                                            overflow: TextOverflow.ellipsis,
                                            softWrap: false,
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          item['last_login_date'] != null
                                              ? Text(
                                                  timeago.format(
                                                      DateTime.parse(item[
                                                              'last_login_date']
                                                          .toString()),
                                                      locale: 'tr'),
                                                  style: TextStyle(
                                                      color: Colors.green),
                                                )
                                              : Text('-'),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          item['last_login_date'] != null
                                              ? Text(DateFormat(
                                                      'dd.MM.yyyy   H:m')
                                                  .format(
                                                      item['last_login_date']))
                                              : Text('-'),
                                        ],
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
                separatorBuilder: (context, index) => const Divider(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
