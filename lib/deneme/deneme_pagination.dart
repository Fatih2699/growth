import 'package:flutter/material.dart';
import 'package:growth/models/register_model.dart';
import 'package:http/http.dart' as http;
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CharacterListView extends StatefulWidget {
  @override
  _CharacterListViewState createState() => _CharacterListViewState();
}

class _CharacterListViewState extends State<CharacterListView> {
  static const _pageSize = 20;

  final PagingController<int, RegisterModel> _pagingController =
      PagingController(firstPageKey: 0);
  int counter = 0;
  var data;
  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      sayfala(pageKey);
    });
    super.initState();
  }

  Future sayfala(int page) async {
    String url =
        '...page=$page&title=&authorized=&step=&listType=all&start_date=2022-02-12&end_date=2022-05-12';
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    var token = _prefs.getString('token');
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      var result = registerFromJson(response.body);
      setState(() {
        data = result;
        counter = result.record.length;
      });
      return result;
    } catch (e) {
      debugPrint('FİLTRELEME HATA VAR: ' + e.toString());
    }
  }

  @override
  Widget build(BuildContext context) => PagedListView<int, RegisterModel>(
        pagingController: _pagingController,
        builderDelegate: PagedChildBuilderDelegate<RegisterModel>(
          itemBuilder: (context, item, index) => ListTile(
            leading: Text(data.record[index].companyTitle),
          ),
        ),
      );

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }
}
