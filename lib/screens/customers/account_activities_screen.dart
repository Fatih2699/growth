import 'package:flutter/material.dart';
import 'package:growth/common_widgets/company_customer_widget.dart';
import 'package:growth/models/customer_model.dart';
import 'package:http/http.dart' as http;
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountActivitiesScreen extends StatefulWidget {
  const AccountActivitiesScreen({Key? key}) : super(key: key);

  @override
  State<AccountActivitiesScreen> createState() =>
      _AccountActivitiesScreenState();
}

class _AccountActivitiesScreenState extends State<AccountActivitiesScreen> {
  Future callAccountActivities(int page, PagingController _controller,
      {Map<String, String>? filters}) async {
    debugPrint(page.toString());
    print('FILTERSS:' + filters.toString());
    String title =
        filters != null && filters['title'] != null ? filters['title']! : '';
    String authorized = filters != null && filters['authorized'] != null
        ? filters['authorized']!
        : '';
    String url = Uri.encodeFull(
        '...?page=$page&title=$title&authorized=$authorized&step=&package=&dashboard_filter_type=hepsi&selected_package_type=hesap_hareketleri');
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    var token = _prefs.getString('token');
    print(url);
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      var result = customersFromJson(response.body);
      List<Map<String, dynamic>> data = [];
      for (var index = 0; index < result.customers.length; index++) {
        String formattedDate = "-";
        if (result.customers[index].lastLoginDate != null) {
          formattedDate = DateFormat('dd/MM/yyyy')
              .format(result.customers[index].lastLoginDate!);
        }
        var names = result.customers[index].adminUser.toString().split('#');
        var package = result.customers[index].packageName.toString().split('#');
        Map<String, dynamic> item = {
          "title": result.customers[index].companyTitle,
          "license_type": result.customers[index].licenseType == 'Kurumsal'
              ? 'assets/icons/verified.png'
              : 'assets/icons/non_verified.png',
          "name": names[0],
          "number": names[1],
          "email": names[2],
          "code": result.customers[index].code,
          "date": formattedDate,
          "last_login_name": result.customers[index].lastLoginName,
          "last_login_date": result.customers[index].lastLoginDate,
          "package_name": package[2],
          'id': result.customers[index].id,
        };
        data.add(item);
      }
      if (data.isEmpty) {
        _controller.appendLastPage(data);
      } else {
        _controller.appendPage(data, page + 1);
      }
    } catch (e) {
      debugPrint('ALL COMPANIES HATA VAR' + e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return CommonListCCWidget(getData: callAccountActivities);
  }
}
