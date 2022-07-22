import 'package:flutter/material.dart';
import 'package:growth/common_widgets/company_customer_widget.dart';
import 'package:growth/models/companies_model.dart';
import 'package:http/http.dart' as http;
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OtsScreen extends StatefulWidget {
  const OtsScreen({Key? key}) : super(key: key);

  @override
  State<OtsScreen> createState() => _OtsScreenState();
}

class _OtsScreenState extends State<OtsScreen> {
  Future callCompanies(int page, PagingController _controller,
      {Map<String, String>? filters}) async {
    debugPrint(page.toString());
    print('FILTERSS:' + filters.toString());
    String title =
        filters != null && filters['title'] != null ? filters['title']! : '';
    String authorized = filters != null && filters['authorized'] != null
        ? filters['authorized']!
        : '';
    String url = Uri.encodeFull(
        '...?page=$page&title=$title&authorized=$authorized&step=&package=&dashboard_filter_type=hepsi&selected_package_type=sanal_pos');
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
      var result = companiesFromJson(response.body);
      List<Map<String, dynamic>> data = [];
      for (var index = 0; index < result.companies.length; index++) {
        String formattedDate = "-";
        if (result.companies[index].lastLoginDate != null) {
          formattedDate = DateFormat('dd/MM/yyyy')
              .format(result.companies[index].lastLoginDate!);
        }
        var names = result.companies[index].adminUser.toString().split('#');
        var package = result.companies[index].packageName.toString().split('#');
        Map<String, dynamic> item = {
          "title": result.companies[index].companyTitle,
          "license_type": result.companies[index].licenseType == 'Kurumsal'
              ? 'assets/icons/verified.png'
              : 'assets/icons/non_verified.png',
          "name": names[0],
          "number": names[1],
          "email": names[2],
          "code": result.companies[index].code,
          "date": formattedDate,
          "last_login_name": result.companies[index].lastLoginName,
          "last_login_date": result.companies[index].lastLoginDate,
          "package_name": package[2],
          'id': result.companies[index].id,
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
    return CommonListCCWidget(getData: callCompanies);
  }
}
