import 'package:flutter/material.dart';
import 'package:growth/common_widgets/drawer_widget.dart';
import 'package:growth/common_widgets/isLoading_widget.dart';
import 'package:growth/constants/app_constant.dart';
import 'package:growth/models/referer_model.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'utm_kampanya_detail.dart';

class RefererScreen extends StatefulWidget {
  const RefererScreen({Key? key}) : super(key: key);

  @override
  State<RefererScreen> createState() => _RefererScreenState();
}

class _RefererScreenState extends State<RefererScreen> {
  bool _isLoading = true;
  var data;
  DateTimeRange dateRange = DateTimeRange(
      start: DateTime.now(),
      end: DateTime.now().subtract(const Duration(days: -90)));
  int? counter;
  _changeLoading() {
    setState(() {
      _isLoading = !_isLoading;
    });
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

  int? sortColumnIndex;
  bool isAscending = false;
  final _scrollController = ScrollController();
  late List<Log> logs;
  String endDate = DateFormat(
    'yyyy-MM-dd',
  ).format(DateTime.now());
  String startDate = DateFormat(
    'yyyy-MM-dd',
  ).format(DateTime.now().subtract(const Duration(days: 90)));

  Future callReferer({Map<String, String>? filters}) async {
    String startDate = filters != null && filters['start_date'] != null
        ? filters['start_date']!
        : DateFormat('yyyy-MM-dd')
            .format(DateTime.now().subtract(const Duration(days: 90)));
    String endDate = filters != null && filters['end_date'] != null
        ? filters['end_date']!
        : DateFormat('yyyy-MM-dd').format(DateTime.now());
    String url = '...start_date=$startDate&end_date=$endDate';
    debugPrint(url);
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    var token = _prefs.get('token');
    try {
      final response = await http
          .get(Uri.parse(url), headers: {'Authorization': 'Bearer $token'});
      var result = refererFromJson(response.body);
      setState(() {
        counter = result.logs.length;
        data = result;
        logs = result.logs;
      });
      _changeLoading();
      return result;
    } catch (e) {
      debugPrint('HATA VAR ' + e.toString());
    }
  }

  final Map<String, String> _filters = {};
  @override
  void initState() {
    super.initState();
    callReferer(filters: _filters);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerWidget(),
      appBar: AppBar(
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            const Text(
              "REFERER  ",
              style: TextStyle(fontSize: 18),
            ),
            Text(
              '(${counter.toString()})',
            ),
          ],
        ),
        backgroundColor: ApplicationConstants.lacivert,
      ),
      body: _isLoading
          ? const IsLoadingWidget()
          : SingleChildScrollView(
              child: Scrollbar(
                isAlwaysShown: true,
                controller: _scrollController,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            child: TextButton(
                              child: Text(
                                DateFormat('dd.MM.yyyy')
                                    .format(dateRange.start),
                              ),
                              style: TextButton.styleFrom(
                                  primary: ApplicationConstants.yesil),
                              onPressed: pickDateRange,
                            ),
                          ),
                          const SizedBox(
                            width: 12,
                          ),
                          Expanded(
                            child: TextButton(
                              child: Text(
                                DateFormat('dd.MM.yyyy').format(dateRange.end),
                              ),
                              style: TextButton.styleFrom(
                                  primary: ApplicationConstants.yesil),
                              onPressed: pickDateRange,
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                _filters['start_date'] =
                                    DateFormat('yyyy-MM-dd')
                                        .format(dateRange.start);
                                _filters['end_date'] = DateFormat('yyyy-MM-dd')
                                    .format(dateRange.end);
                              });
                              _changeLoading();
                              callReferer(filters: _filters);
                            },
                            child: const Text('Filtrele'),
                            style: ElevatedButton.styleFrom(
                                primary: ApplicationConstants.lacivert),
                          )
                        ],
                      ),
                    ),
                    buildDataTable(),
                  ],
                ),
              ),
            ),
    );
  }

  Widget buildDataTable() {
    final columns = [
      'UTM-KAMPANYA',
      'KAYIT',
      'LEAD',
      'SATIŞ',
    ];
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      controller: _scrollController,
      child: DataTable(
        showCheckboxColumn: true,
        headingRowColor:
            MaterialStateProperty.all(ApplicationConstants.lacivert),
        decoration: const BoxDecoration(shape: BoxShape.circle),
        sortAscending: isAscending,
        sortColumnIndex: sortColumnIndex,
        columns: getColumns(columns),
        rows: getRows(logs),
      ),
    );
  }

  List<DataColumn> getColumns(List<String> columns) => columns
      .map(
        (String column) => DataColumn(
          label: Text(
            column,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ),
      )
      .toList();

  List<DataRow> getRows(List<Log> data) => data.map((Log log) {
        final cells = [
          log.source,
          log.register,
          log.lead,
          log.win,
        ];
        return DataRow(
          selected: false,
          cells: getCells(cells),
        );
      }).toList();
  final List<String> _clickItems = ["all", "register", "lead", "win"];
  List<DataCell> getCells(List<dynamic> cells) {
    List<DataCell> _data = [];
    for (var i = 0; i < cells.length; i++) {
      _data.add(DataCell(
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => UtmKampanya(
                  source: cells[0],
                  type: _clickItems[i],
                ),
              ),
            );
          },
          child: Text(
            '${cells[i]}-${_clickItems[i]}',
            style: const TextStyle(
                color: ApplicationConstants.lacivert,
                fontSize: 10,
                fontWeight: FontWeight.bold),
          ),
        ),
      ));
    }
    return _data;
  }
}
