import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:growth/common_widgets/drawer_widget.dart';
import 'package:growth/constants/app_constant.dart';
import 'package:growth/models/campaign_model.dart';
import 'package:growth/screens/lists/campaign/campaign_detail.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class CampaignScreen extends StatefulWidget {
  const CampaignScreen({Key? key}) : super(key: key);

  @override
  State<CampaignScreen> createState() => _CampaignScreenState();
}

class _CampaignScreenState extends State<CampaignScreen> {
  Future<void> callCampaign() async {
    String url = '...';
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    var token = _prefs.getString('token');
    try {
      final response = await http.get(Uri.parse(url), headers: {
        'Authorization': 'Bearer $token',
      });
      var result = campaignModelFromJson(response.body);
      setState(() {
        data = result.data;
      });
      debugPrint(data.length.toString());
    } catch (e) {
      debugPrint('HATA VAR KAMPANYALAR: ' + e.toString());
    }
  }

  List data = [];
  @override
  void initState() {
    super.initState();
    callCampaign();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerWidget(),
      appBar: AppBar(
        backgroundColor: ApplicationConstants.lacivert,
        centerTitle: true,
        title: const Text('Kampanya'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              controller: ScrollController(),
              itemBuilder: (context, index) {
                return SizedBox(
                  height: MediaQuery.of(context).size.height / 6,
                  width: MediaQuery.of(context).size.width,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CampaignDetail(
                            id: data[index].id.toString(),
                          ),
                        ),
                      );
                    },
                    child: Card(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          buildColumn('ID', data[index].id.toString()),
                          buildColumn(
                              'Customer Type', data[index].customerType),
                          buildColumn('User type', data[index].userType),
                          buildColumn('Feature', data[index].feature),
                          buildColumn('Status', data[index].status.toString()),
                          buildColumn(
                              'Duration', data[index].duration.toString()),
                        ],
                      ),
                    ),
                  ),
                );
              },
              itemCount: data.length,
            ),
          ],
        ),
      ),
    );
  }

  Column buildColumn(String title, String data) {
    return Column(
      children: [
        Text(
          title,
          style: style(),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: MediaQuery.of(context).size.height / 90),
        Text(data),
      ],
    );
  }

  style() {
    return const TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
  }
}
