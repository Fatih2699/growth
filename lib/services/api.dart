import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../cache/locale_manager.dart';

class CallApi {
  final String _loginurl = '...';
  final String _url = '...';
  final String _token = LocaleManager.instance.getStringValue("token");

  postData(data, apiUrl) async {
    var fullUrl = _loginurl + apiUrl;
    return await http.post(Uri.parse(fullUrl),
        body: jsonEncode(data), headers: _setHeaders());
  }

  _setHeaders() => {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      };
  getUser(apiUrl) async {
    final prefs = await SharedPreferences.getInstance();
    String value = prefs.getString('user').toString();
    String token = '';
    token = jsonDecode(value)['token'];
    var fullUrl = _url + apiUrl;
    return await http.get(Uri.parse(fullUrl), headers: {
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
    });
  }

  // callSearch(String query) async {
  //   final url = _url + '...?search=$query';
  //   SharedPreferences _pref = await SharedPreferences.getInstance();
  //   var token = _pref.get('token');
  //   try {
  //     final response = await http.get(Uri.parse(url), headers: {
  //       'Authorization': 'Bearer $token',
  //     });
  //     return nonDataFromJson(response.body);
  //   } catch (e) {
  //     debugPrint('HATA!!:' + e.toString());
  //   }
  // }
}
