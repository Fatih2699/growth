import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:growth/common_widgets/drawer_widget.dart';
import 'package:growth/common_widgets/isLoading_widget.dart';
import 'package:growth/constants/app_constant.dart';
import 'package:growth/models/non_data_model.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NonDataBaseScreen extends StatefulWidget {
  const NonDataBaseScreen({Key? key}) : super(key: key);

  @override
  State<NonDataBaseScreen> createState() => _NonDataBaseScreenState();
}

class _NonDataBaseScreenState extends State<NonDataBaseScreen> {
  bool _isloading = true;
  String query = '';
  final url = '...search=';
  int counter = 0;
  int? sortColumnIndex;
  bool isAscending = false;

  late List<LicenseDetail> detail;
  void _changeLoading() async {
    setState(() {
      _isloading = !_isloading;
    });
  }

  Future callNonDAta() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    var token = _prefs.get('token');
    try {
      final response = await http.get(Uri.parse(url), headers: {
        'Authorization': 'Bearer $token',
      });
      var result = nonDataFromJson(response.body);
      setState(() {
        counter = result.licenseDetails.length;
        detail = result.licenseDetails;
      });
      _changeLoading();
      return result;
    } catch (e) {
      debugPrint("HATA::" + e.toString());
    }
  }

  Future callSearch(String query) async {
    final url = '...search=$query';
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    var token = _prefs.get('token');
    try {
      final response = await http.get(Uri.parse(url), headers: {
        'Authorization': 'Bearer $token',
      });
      var result = nonDataFromJson(response.body);
      setState(() {
        counter = result.licenseDetails.length;
        detail = result.licenseDetails;
      });
      return result;
    } catch (e) {
      debugPrint("HATA::" + e.toString());
    }
  }

  Future<void> delete(int? id) async {
    String url = '...';
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    var token = _prefs.get('token');
    try {
      final response = await http.post(Uri.parse(url), headers: {
        'Authorization': 'Bearer $token',
      }, body: {
        "user_id": id.toString()
      });
      debugPrint(response.body);
    } catch (e) {
      debugPrint("HATA::" + e.toString());
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    callNonDAta();
  }

  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerWidget(),
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            const AutoSizeText(
              "VERİ TABANI OLUŞMAYANLAR",
              maxLines: 1,
              minFontSize: 10,
              overflow: TextOverflow.ellipsis,
              maxFontSize: 13,
            ),
            AutoSizeText(
              '(${counter.toString()})',
              maxLines: 1,
              minFontSize: 7,
              overflow: TextOverflow.ellipsis,
              maxFontSize: 13,
            )
          ],
        ),
        //centerTitle: true,
        backgroundColor: ApplicationConstants.lacivert,
      ),
      body: _isloading
          ? const IsLoadingWidget()
          : counter == 0
              ? RefreshIndicator(
                  //refresh yapılacak
                  onRefresh: () async {
                    setState(() {
                      _changeLoading();
                      //await getCallsFromPhone(endDate);
                      callNonDAta();
                    });
                  },
                  child: const Center(
                    child: Text('Kayıt Bulunamadı'),
                  ),
                )
              : RefreshIndicator(
                  onRefresh: callNonDAta,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            keyboardType: TextInputType.text,
                            controller: searchController,
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                icon: const Icon(
                                  Icons.search,
                                  size: 25,
                                  color: ApplicationConstants.lacivert,
                                ),
                                onPressed: () async {
                                  await callSearch(searchController.text);
                                },
                              ),
                              hintText: 'Kayıt Ara...',
                              hintStyle: const TextStyle(
                                  color: ApplicationConstants.lacivert,
                                  fontWeight: FontWeight.bold),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(6.0),
                              ),
                            ),
                          ),
                        ),
                        ListView.builder(
                          itemCount: counter,
                          controller: ScrollController(),
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            DateTime? date = detail[index].createdAt;
                            String formattedDate =
                                DateFormat('dd/MM/yyyy kk:mm').format(date!);
                            return Slidable(
                              key: const ValueKey(0),
                              endActionPane: ActionPane(
                                motion: const ScrollMotion(),
                                children: [
                                  SlidableAction(
                                    flex: 2,
                                    onPressed: (ctx) async {
                                      _changeLoading();
                                      await delete(detail[index].id);
                                      setState(() {
                                        callNonDAta();
                                      });
                                    },
                                    backgroundColor: Colors.redAccent,
                                    foregroundColor: Colors.white,
                                    icon: Icons.delete,
                                  ),
                                ],
                              ),
                              child: Container(
                                margin: const EdgeInsets.only(
                                    left: 2, top: 5, bottom: 5),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(18),
                                  color: Colors.grey.shade300,
                                ),
                                height: MediaQuery.of(context).size.height / 6,
                                width: MediaQuery.of(context).size.width,
                                child: Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text(
                                            "#" + detail[index].id.toString(),
                                            style: style(),
                                          ),
                                          Text(
                                            formattedDate,
                                            style: style(),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text(
                                            detail[index].name.toString(),
                                            style: style(),
                                          ),
                                          Row(
                                            children: <Widget>[
                                              Icon(Icons.smartphone),
                                              Text(
                                                detail[index].phone.toString(),
                                                style: style(),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text(
                                            detail[index].email.toString(),
                                            style: style(),
                                          ),
                                          // ElevatedButton(
                                          //     style: ElevatedButton.styleFrom(
                                          //         primary: ApplicationConstants
                                          //             .yesil),
                                          //     child: const Text('DETAY',
                                          //         style: TextStyle(
                                          //             color: Colors.white)),
                                          //     onPressed: () {
                                          //       // Navigator.push(
                                          //       //   context,
                                          //       //   MaterialPageRoute(
                                          //       //     builder: (context) =>
                                          //       //         UtmDetail(
                                          //       //       refererData:item['referer_data'],
                                          //       //     ),
                                          //       //   ),
                                          //       // );
                                          //     })
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
    );
  }

  TextStyle style() {
    return const TextStyle(fontWeight: FontWeight.bold, fontSize: 16);
  }
}
