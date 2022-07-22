import 'dart:async';

import 'package:flutter/material.dart';
import 'package:growth/common_widgets/isLoading_widget.dart';
import 'package:growth/models/search_model.dart';
import 'package:growth/screens/details/detail_screen.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class SearchRowWidget extends StatefulWidget {
  const SearchRowWidget({Key? key}) : super(key: key);

  @override
  State<SearchRowWidget> createState() => _SearchRowWidgetState();
}

class _SearchRowWidgetState extends State<SearchRowWidget> {
  late TextEditingController _controller = TextEditingController();
  late List<Customer> search = [];
  int counter = 0;
  var _isLoading = false;
  changeLoading() {
    setState(() {
      _isLoading = !_isLoading;
    });
  }

  Future query(String? query) async {
    final url = '...search=$query';
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    var token = _prefs.getString('token');
    changeLoading();
    try {
      final response = await http.get(Uri.parse(url), headers: {
        'Authorization': 'Bearer $token',
      });
      var result = searchModelFromJson(response.body);
      setState(() {
        search = result.customers;
        counter = result.customers.length;
      });
      changeLoading();
      return result;
    } catch (e) {
      debugPrint('HATA VAR:  ' + e.toString());
    }
  }

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Timer? timer;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TextField(
          controller: _controller,
          onChanged: (v) {
            timer?.cancel();
            timer = Timer(
              const Duration(seconds: 1),
              () {
                query(_controller.text);
              },
            );
          },
          style: const TextStyle(color: Colors.black, fontSize: 16),
          decoration: InputDecoration(
              hintText: 'Kayıt Ara...',
              hintStyle: const TextStyle(color: Colors.black, fontSize: 16),
              suffixIcon: IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () => clearResults(),
              ),
              border: const UnderlineInputBorder()),
        ),
        _isLoading
            ? const IsLoadingWidget()
            : SizedBox(
                height: counter > 0 ? 150 : 0,
                child: ListView.builder(
                  itemCount: counter,
                  controller: ScrollController(),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        InkWell(
                          child: Card(
                            color: Colors.white,
                            elevation: 10,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        children: <Widget>[
                                          Text('MN:' +
                                              search[index].code.toString()),
                                          Text(
                                              '#' + search[index].id.toString())
                                        ],
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        child: Text(
                                          search[index].companyTitle.toString(),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          softWrap: false,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16),
                                        ),
                                        flex: 4,
                                      ),
                                      Expanded(
                                        child: CircleAvatar(
                                          backgroundColor: Colors.transparent,
                                          child: Image.asset(
                                            search[index]
                                                        .licenseType
                                                        .toString() ==
                                                    'Kurumsal'
                                                ? 'assets/icons/verified.png'
                                                : 'assets/icons/non_verified.png',
                                            fit: BoxFit.cover,
                                            height: 20,
                                            width: 20,
                                          ),
                                        ),
                                        flex: 1,
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
                                          children: const <Widget>[
                                            SizedBox(
                                              height: 5,
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: <Widget>[
                                            Text(
                                              search[index].name.toString(),
                                              overflow: TextOverflow.ellipsis,
                                              softWrap: false,
                                            ),
                                            Text(
                                              search[index].phone.toString(),
                                              overflow: TextOverflow.ellipsis,
                                              softWrap: false,
                                            ),
                                            Text(
                                              search[index].email.toString(),
                                              overflow: TextOverflow.ellipsis,
                                              softWrap: false,
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  DetailScreen(id: search[index].id),
                            ),
                          ),
                        )
                      ],
                    );
                  },
                ),
              )
      ],
    );
  }

  void clearResults() {
    setState(() {
      search = [];
      counter = 0;
    });
    _controller.clear();
  }
}
