import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:growth/cache/locale_manager.dart';
import 'package:growth/services/api.dart';
import 'package:growth/services/auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserModel with ChangeNotifier implements Auth {
  @override
  Future<void> login(String email, String password, String code) async {
    var data = {
      'code': code,
      'email': email,
      'password': password,
    };
    debugPrint(data.toString());
    var res = await CallApi().postData(data, 'login');
    var body = json.decode(res.body);
    try {
      LocaleManager.instance.setStringValue("token", body['token']);
      LocaleManager.instance.setStringValue("name", body['name']);
      LocaleManager.instance.setStringValue("email", body['email']);
      SharedPreferences _prefs = await SharedPreferences.getInstance();
      _prefs.setInt('user_id', body['id']);
      var son = _prefs.getInt('user_id');
      debugPrint('SON:::' + son.toString());
      debugPrint("BODY:" + body.toString());
    } catch (e) {
      debugPrint('HATA VAR LOGIN ::' + e.toString());
      debugPrint("BODY:" + body['status']);
    }
  }
}
