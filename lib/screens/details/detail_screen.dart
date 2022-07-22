import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:growth/common_widgets/isLoading_widget.dart';
import 'package:growth/constants/app_constant.dart';
import 'package:growth/models/customer_detail_model.dart';
import 'package:growth/screens/details/account_detail/account_detail_screen.dart';
import 'package:growth/screens/details/note_screen.dart';
import 'package:growth/screens/details/package_detail_screen.dart';
import 'package:growth/screens/details/reminder/event_editing_screen.dart';
import 'package:growth/screens/details/users_screen.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timeago/timeago.dart' as timeago;

class DetailScreen extends StatefulWidget {
  final int? id;
  const DetailScreen({Key? key, this.id}) : super(key: key);

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    timeago.setLocaleMessages('tr', timeago.TrMessages());
    callDetail();
  }

  String timeAgo(DateTime d) {
    Duration diff = DateTime.now().difference(d);
    debugPrint(DateTime.now().toString() +
        '-->' +
        d.toString() +
        '-->' +
        diff.inHours.toString());
    return diff.inHours.toString();
  }

  int? counter;
  var results;
  var packageResults;
  bool _isLoading = true;
  void _changeLoading() async {
    setState(() {
      _isLoading = !_isLoading;
    });
  }

  Future callDetail() async {
    String url = '.../' + widget.id.toString();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    try {
      final response = await http.get(Uri.parse(url), headers: {
        'Authorization': 'Bearer $token',
      });
      var result = customerDetayFromJson(response.body);
      setState(() {
        counter = result.customer.users.length;
        results = result;
      });
      _changeLoading();
      return result;
    } catch (e) {
      debugPrint("HATAs: " + e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: _isLoading
          ? Scaffold(body: const IsLoadingWidget())
          : Scaffold(
              appBar: AppBar(
                title: Text(
                  results.customer.companyTitle,
                ),
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                backgroundColor: ApplicationConstants.lacivert,
                centerTitle: true,
              ),
              body: Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    results.customer.companyTitle != null
                        ? AutoSizeText(
                            results.customer.companyTitle,
                            style: const TextStyle(
                                fontSize: 19, fontWeight: FontWeight.bold),
                            maxFontSize: 19,
                            maxLines: 2,
                          )
                        : Text(' - '),
                    const SizedBox(
                      height: 10,
                    ),
                    const Divider(
                      thickness: 2,
                      color: Colors.black12,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: const Color(0xFF71A0A5),
                              border: Border.all(
                                  color: const Color(0xFF71A0A5), width: 3.0),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(5.0),
                              )),
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Row(
                              // ignore: prefer_const_literals_to_create_immutables
                              children: [
                                Text(
                                    results.customer.status == 1
                                        ? 'Aktif'
                                        : 'Pasif',
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 112, 186, 107),
                              border: Border.all(
                                width: 3.0,
                                color: const Color.fromARGB(255, 112, 186, 107),
                              ),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(5.0),
                              )),
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Text(results.customer.licenseType,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: const Color(0xFFE3B7A0),
                              border: Border.all(
                                width: 3.0,
                                color: const Color(0xFFE3B7A0),
                              ),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(5.0),
                              )),
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Text(results.customer.firmaStatus,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: const Color(0xFF1572A1),
                              border: Border.all(
                                width: 3.0,
                                color: const Color(0xFF1572A1),
                              ),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(5.0),
                              )),
                          child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: results.customer.customerLicenseType ==
                                      'customer'
                                  ? const Text('Müşteri',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold))
                                  : results.customer.customerLicenseType ==
                                          'advisor'
                                      ? const Text('Müşavir',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold))
                                      : results.customer.customerLicenseType ==
                                              'lead'
                                          ? const Text('Lead',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold))
                                          : results.customer
                                                      .customerLicenseType !=
                                                  null
                                              ? Text(
                                                  results.customer
                                                      .customerLicenseType,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )
                                              : Text('-')),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                results.customer.name,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 17),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  const Icon(Icons.phone_android, size: 18),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      _showDialog();
                                      //await FlutterPhoneDirectCaller.callNumber(results.customer.phone);
                                    },
                                    child: Text(results.customer.phone,
                                        style: const TextStyle(fontSize: 14)),
                                  )
                                ],
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.mail_outline,
                                    size: 18,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Expanded(
                                    child: AutoSizeText(
                                      results.customer.email,
                                      maxLines: 1,
                                      minFontSize: 7,
                                      overflow: TextOverflow.ellipsis,
                                      maxFontSize: 13,
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  const Text('MÜŞTERİ NO: ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  Text(results.customer.code,
                                      style: const TextStyle(fontSize: 14))
                                ],
                              ),
                              const SizedBox(height: 8),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  const Text('ID: ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  Text(results.customer.licenseId.toString(),
                                      style: const TextStyle(fontSize: 14))
                                ],
                              ),
                              const SizedBox(height: 5),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  const Text(
                                    'KYC: ',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                      results.customer.kycPoint.toString() ==
                                              'null'
                                          ? '-'
                                          : results.customer.kycPoint
                                              .toString(),
                                      style: const TextStyle(fontSize: 16))
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: ApplicationConstants.lacivert,
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => NotesScreen(
                                          id: results.customer.licenseId,
                                          title: results.customer.companyTitle,
                                        )));
                          },
                          child: Text('Notlar'),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: const Color(0xFF06113C),
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => EventEditingPage(
                                          id: results.customer.licenseId
                                              .toInt(),
                                          title: results.customer.companyTitle,
                                        )));
                          },
                          child: Text('Hatırlatıcı'),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: const Color(0xFF06113C),
                          ),
                          onPressed: () {
                            //debugPrint('CALISTI');
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AccountDetailScreen(
                                    id: results.customer.licenseId,
                                    title: results.customer.companyTitle),
                              ),
                            );
                          },
                          child: const Text('Hesap Detay'),
                        ),
                      ],
                    ),
                    const Divider(
                      thickness: 2,
                      color: Colors.black26,
                    ),
                    //burdan itibaren hata var
                    Expanded(
                      child: DefaultTabController(
                        length: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            const TabBar(
                              labelColor: Color(0xFF5c59ef),
                              unselectedLabelColor: Colors.black,
                              tabs: [
                                Tab(
                                  text: 'KULLANICILAR',
                                ),
                                Tab(text: 'PAKET'),
                              ],
                            ),
                            Expanded(
                              child: TabBarView(
                                children: <Widget>[
                                  UsersScreen(
                                    customer: results.customer,
                                  ),
                                  PackageDetailScreen(
                                    id: results.customer.licenseId,
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
    );
  }

  Future _showDialog() async {
    return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text(
            results.customer.name +
                "\nisimli müşteriyi aramak istediğinize emin misiniz?",
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
          actions: <Widget>[
            MaterialButton(
              color: ApplicationConstants.lacivert,
              onPressed: () async {
                String firstPhoneNumber =
                    results.customer.phone.toString().replaceAll(' ', '');
                if (firstPhoneNumber.length < 11) {
                  debugPrint('buraya girdi');
                  firstPhoneNumber = "0" + firstPhoneNumber;
                }
                debugPrint("PhoneNumber:" + firstPhoneNumber);
                await FlutterPhoneDirectCaller.callNumber(firstPhoneNumber);
              },
              child: const Text(
                'Ara',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            MaterialButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'İptal',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        );
      },
    );
  }
}
/*
    Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              child: ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    await _formSubmit();
                  }
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(80.0),
                  ),
                  padding: const EdgeInsets.all(0),
                ),
                child: Container(
                  alignment: Alignment.center,
                  height: MediaQuery.of(context).size.height / 16,
                  width: size.width * 0.5,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(80.0),
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFF5c59ef),
                        Color(0xFF04d1aa),
                      ],
                    ),
                  ),
                  child: const Text(
                    "GİRİŞ YAP",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
              ),
            )
              */
