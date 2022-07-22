import 'package:flutter/material.dart';
import 'package:growth/common_widgets/drawer_widget.dart';
import 'package:growth/constants/app_constant.dart';
import 'package:growth/models/call_model.dart';
import 'package:growth/screens/details/detail_screen.dart';
import 'package:http/http.dart' as http;
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SupportScreen extends StatefulWidget {
  const SupportScreen({Key? key}) : super(key: key);

  @override
  State<SupportScreen> createState() => _SupportScreenState();
}

class _SupportScreenState extends State<SupportScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pagingController.addPageRequestListener((pageKey) {
      callData(pageKey, _pagingController, filters: _filters);
    });
    initializeDateFormatting();
  }

  final PagingController<int, Map<String, dynamic>> _pagingController =
      PagingController(firstPageKey: 1, invisibleItemsThreshold: 1);
  final Map<String, String> _filters = {};
  final TextEditingController _aciklama = TextEditingController();
  final TextEditingController _arayan = TextEditingController();
  final TextEditingController _firmaAdi = TextEditingController();
  final TextEditingController _mincontroller = TextEditingController();
  final TextEditingController _maxcontroller = TextEditingController();
  String _bank = 'Banka';
  String _product = 'Ürün';
  String _explanation = 'Süreç';
  DateTimeRange dateRange =
      DateTimeRange(start: DateTime(2022, 4, 20), end: DateTime(2022, 5, 27));
  String endDate = DateFormat(
    'yyyy-MM-dd',
  ).format(DateTime.now());
  String startDate = DateFormat(
    'yyyy-MM-dd',
  ).format(DateTime.now().subtract(const Duration(days: 90)));

  Future<void> callData(int page, PagingController _controller,
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
    String companyName = filters != null && filters['companyName'] != null
        ? filters['companyName']!
        : '';
    String caller =
        filters != null && filters['caller'] != null ? filters['caller']! : '';
    String subject = filters != null && filters['subject'] != null
        ? filters['subject']!
        : '';
    String bankName = filters != null && filters['bankName'] != null
        ? filters['bankName']!
        : '';
    String productName = filters != null && filters['productName'] != null
        ? filters['productName']!
        : '';
    String callTypes = filters != null && filters['callTypes'] != null
        ? filters['callTypes']!
        : '';
    String url = Uri.encodeFull(
        '...?page=$page&companyName=$companyName&caller=$caller&subject=$subject&minMinutes=$min&maxMinutes=$max&startDate=$startDate&endDate=$endDate&bankName=$bankName&productName=$productName&callType=$callTypes');
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    var token = _prefs.getString('token');
    print(url);
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      var result = callModelFromJson(response.body);
      List<Map<String, dynamic>> data = [];
      for (var index = 0; index < result.data.data.length; index++) {
        Map<String, dynamic> item = {
          'license_id': result.data.data[index].licenseId,
          'firma_adi': result.data.data[index].firmaAdi,
          'arayan': result.data.data[index].arayan,
          'arama_tarihi': result.data.data[index].aramaTarihi,
          'arama_baslangic': result.data.data[index].aramaBaslangic,
          'arama_bitis': result.data.data[index].aramaBitis,
          'arama_suresi': result.data.data[index].aramaSuresiDk,
          'yetkili': result.data.data[index].yetkili,
          'konu': result.data.data[index].konu,
        };
        data.add(item);
      }
      if (data.isEmpty) {
        _controller.appendLastPage(data);
      } else {
        _controller.appendPage(data, page + 1);
      }
    } catch (e) {
      debugPrint('HATA VAR ARAMALAR: ' + e.toString());
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
      endDrawer: endDrawer(),
      drawer: const DrawerWidget(),
      appBar: AppBar(
        actions: [
          Builder(
            builder: (context) {
              return IconButton(
                icon: Image.asset(
                  'assets/icons/filter.png',
                  color: Colors.white,
                  height: 24,
                  width: 24,
                ),
                onPressed: () {
                  Scaffold.of(context).openEndDrawer();
                },
              );
            },
          )
        ],
        elevation: 5,
        backgroundColor: ApplicationConstants.lacivert,
        title: const Text(
          "ARAMA GEÇMİŞİ",
          style: TextStyle(fontSize: 18),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: PagedListView<int, Map<String, dynamic>>.separated(
          pagingController: _pagingController,
          builderDelegate:
              PagedChildBuilderDelegate(itemBuilder: (context, item, index) {
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
                height: MediaQuery.of(context).size.height / 3,
                child: Card(
                  color: Colors.white,
                  elevation: 10,
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  Text(
                                    item['firma_adi'],
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    softWrap: false,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                          color: ApplicationConstants.yesil,
                                          width: 1.0),
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(5.0),
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Text(
                                        "M.ID: " +
                                            item['license_id'].toString(),
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                          color: ApplicationConstants.yesil,
                                          width: 1.0),
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(5.0),
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Column(
                                        children: <Widget>[
                                          const Text(
                                            'Görüşülen Kişi',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            item['yetkili'],
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text('Arayan: ' + item['arayan']),
                                ],
                                crossAxisAlignment: CrossAxisAlignment.start,
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    DateFormat.yMMMMd('tr')
                                        .format(item['arama_tarihi']),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    softWrap: false,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  Text(item['arama_baslangic']),
                                  Text(item['arama_bitis']),
                                  Text('Süre: ' +
                                      item['arama_suresi'].toString() +
                                      ' dakika'),
                                  SizedBox(
                                    height:
                                        MediaQuery.of(context).size.height / 15,
                                  ),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      primary: ApplicationConstants.lacivert,
                                    ),
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            backgroundColor: Colors.white,
                                            title: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: <Widget>[
                                                const Text(
                                                  'AÇIKLAMA',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                IconButton(
                                                  onPressed: () =>
                                                      Navigator.pop(context),
                                                  icon: const Icon(
                                                    Icons.clear,
                                                    color: Colors.black,
                                                  ),
                                                )
                                              ],
                                            ),
                                            content: Text(
                                              item['konu'],
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          );
                                        },
                                      );
                                    },
                                    child: const Text('Açıklamayı Gör'),
                                  )
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
    );
  }

  Widget endDrawer() {
    return SafeArea(
      child: Drawer(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Material(
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        child: Text(
                          DateFormat('dd.MM.yyyy').format(dateRange.end),
                          style: const TextStyle(fontSize: 15),
                        ),
                        style: TextButton.styleFrom(
                            primary: ApplicationConstants.mor),
                        onPressed: pickDateRange,
                      ),
                      TextButton(
                        child: Text(
                          DateFormat('dd.MM.yyyy').format(dateRange.end),
                          style: const TextStyle(fontSize: 15),
                        ),
                        style: TextButton.styleFrom(
                            primary: ApplicationConstants.mor),
                        onPressed: pickDateRange,
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
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
                                borderSide: const BorderSide(
                                    color: ApplicationConstants.mor),
                              ),
                              focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: ApplicationConstants.mor,
                                    width: 2.0),
                              ),
                              hintStyle: const TextStyle(color: Colors.black),
                              hintText: 'MIN: ',
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 10)),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ),
                    const SizedBox(
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
                                borderSide: BorderSide(
                                    color: ApplicationConstants.mor,
                                    width: 2.0),
                              ),
                              hintStyle: const TextStyle(color: Colors.black),
                              hintText: 'MAX: ',
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 10)),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ),
                  ],
                ),
                // SizedBox(
                //   height: MediaQuery.of(context).size.height / 40,
                // ),
                Column(
                  children: <Widget>[
                    TextField(
                      textAlign: TextAlign.center,
                      controller: _firmaAdi,
                      decoration: InputDecoration(
                        contentPadding:
                            const EdgeInsets.symmetric(vertical: 10),
                        hintText: ' Firma Adı',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6.0),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 40,
                    ),
                    TextField(
                      textAlign: TextAlign.center,
                      controller: _arayan,
                      decoration: InputDecoration(
                        contentPadding:
                            const EdgeInsets.symmetric(vertical: 10),
                        hintText: ' Arayan',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6.0),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 40,
                    ),
                    TextField(
                      textAlign: TextAlign.center,
                      controller: _aciklama,
                      decoration: InputDecoration(
                        contentPadding:
                            const EdgeInsets.symmetric(vertical: 10),
                        hintText: 'Açıklama',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6.0),
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    DropdownButton<String>(
                      isExpanded: true,
                      value: _bank,
                      style: const TextStyle(color: Colors.black),
                      items: <String>[
                        'Banka',
                        'Akbank',
                        'Albaraka Türk',
                        'Anadolu Bank',
                        'Deniz Bank',
                        'Fiba Banka',
                        'QNB FinansBank',
                        'Garanti BBVA',
                        'Halkbank',
                        'ING Bank',
                        'Kuveyt Türk',
                        'TEB',
                        'Türkiye Finans',
                        'Türkiye İş Bankası',
                        'Şekerbank',
                        'Vakıfbank',
                        'Yapı Kredi',
                        'Ziraat',
                        'Enpara',
                        'Vakıf Katılım',
                        'Aktifbank',
                        'Ziraat Katılım',
                        'Emlak Katılım',
                        'Alternatif Katılım',
                        'Odea Bank',
                        'Burgan Bank',
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      hint: const Text(
                        "Banka",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      ),
                      onChanged: (String? value) {
                        setState(() {
                          _bank = value!;
                        });
                      },
                    ),
                    DropdownButton<String>(
                      isExpanded: true,
                      value: _product,
                      style: const TextStyle(color: Colors.black),
                      items: <String>[
                        'Ürün',
                        'Hesap Hareketleri',
                        'Pos Rapor',
                        'Online Tahsilat Sistemi',
                        'Vomsis POS',
                        'Erp Entegrasyon',
                        'Toplu Ödeme',
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      hint: const Text(
                        "Ürün",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      ),
                      onChanged: (String? value) {
                        setState(() {
                          _product = value!;
                        });
                      },
                    ),
                    DropdownButton<String>(
                      isExpanded: true,
                      value: _explanation,
                      style: const TextStyle(color: Colors.black),
                      items: <String>[
                        'Süreç',
                        'Destek Araması',
                        'OTS Test Ortam Aşamaları ve Tanımı',
                        'Banka Bağlantı (kopma) Sorunu',
                        'Banka Bağlama Süreci',
                        'Form Süreci',
                        'OTS Bankya Talep Gönderimi',
                        'Mail Süreçleri',
                        'Canlı Ortam Süreci',
                        'Tanımlı Banka Sorunları(Bakiye-Hareket)',
                        'Domain Oluşturma',
                        'Kullanıcı Yetkilendirme',
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      hint: const Text(
                        "Süreç",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      ),
                      onChanged: (String? value) {
                        setState(() {
                          _explanation = value!;
                        });
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 40,
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _filters['max'] = _maxcontroller.text;
                      _filters['min'] = _mincontroller.text;
                      _filters['start_date'] =
                          DateFormat('yyyy-MM-dd').format(dateRange.start);
                      _filters['end_date'] =
                          DateFormat('yyyy-MM-dd').format(dateRange.end);
                      _filters['companyName'] = _firmaAdi.text;
                      _filters['caller'] = _arayan.text;
                      _filters['subject'] = _aciklama.text;
                      _filters['productName'] =
                          _product == 'Ürün' ? '' : _product;
                      _filters['callTypes'] =
                          _explanation == 'Süreç' ? '' : _explanation;
                      _filters['bankName'] = _bank == 'Banka' ? '' : _bank;
                    });
                    print(_filters);
                    _pagingController.refresh();
                    Navigator.pop(context);
                  },
                  child: const Text('Filtrele'),
                  style: ElevatedButton.styleFrom(
                    primary: ApplicationConstants.lacivert,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
