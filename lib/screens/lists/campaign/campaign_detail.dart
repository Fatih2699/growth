import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:growth/constants/app_constant.dart';
import 'package:growth/models/campaing_detail_model.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CampaignDetail extends StatefulWidget {
  final String id;
  const CampaignDetail({Key? key, required this.id}) : super(key: key);

  @override
  State<CampaignDetail> createState() => _CampaignDetailState();
}

class _CampaignDetailState extends State<CampaignDetail> {
  List data = [];
  Future<void> callCampaignDetail() async {
    String url = '...${widget.id}';
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    var token = _prefs.getString('token');
    debugPrint(url);
    try {
      final response = await http.get(Uri.parse(url), headers: {
        'Authorization': 'Bearer $token',
      });
      var result = campaignDetailFromJson(response.body);
      setState(() {
        data = result.data;
      });
    } catch (e) {
      debugPrint('HATA VAR KAMPANYALAR: ' + e.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    callCampaignDetail();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ApplicationConstants.lacivert,
        centerTitle: true,
        title: const Text('Kampanya Detay'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView.builder(
            itemBuilder: (context, index) {
              return SizedBox(
                height: MediaQuery.of(context).size.height / 6,
                child: Card(
                  color: Colors.white,
                  elevation: 10,
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                data[index].companyName,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                softWrap: false,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              flex: 4,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                    color: ApplicationConstants.lacivert,
                                    width: 1.0),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(5.0),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(data[index].licenseId.toString(),
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold)),
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "OY SAYISI: ${data[index].vote.toString()}",
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                backgroundColor: Colors.white,
                                                title: SingleChildScrollView(
                                                  child: Container(
                                                    height: 50,
                                                    width: 50,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        const AutoSizeText(
                                                          'Kullanılan Oylar',
                                                          minFontSize: 15,
                                                          maxFontSize: 20,
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        IconButton(
                                                          onPressed: () =>
                                                              Navigator.pop(
                                                                  context),
                                                          icon: const Icon(
                                                            Icons.clear,
                                                            color: Colors.black,
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                content: Container(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height /
                                                      2,
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  child: ListView.builder(
                                                    scrollDirection:
                                                        Axis.vertical,
                                                    shrinkWrap: true,
                                                    controller:
                                                        ScrollController(),
                                                    itemBuilder:
                                                        (context, index2) {
                                                      return Column(
                                                        children: <Widget>[
                                                          Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              border:
                                                                  Border.all(
                                                                color:
                                                                    ApplicationConstants
                                                                        .lacivert,
                                                                width: 1.0,
                                                              ),
                                                            ),
                                                            height: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height /
                                                                7,
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8),
                                                              child: Column(
                                                                children: <
                                                                    Widget>[
                                                                  buildRow(
                                                                      'AD',
                                                                      data[index]
                                                                          .voteUsers[
                                                                              index2]
                                                                          .name),
                                                                  buildRow(
                                                                      'Telefon',
                                                                      data[index]
                                                                          .voteUsers[
                                                                              index2]
                                                                          .phone),
                                                                  buildRow(
                                                                      'E-mail',
                                                                      data[index]
                                                                          .voteUsers[
                                                                              index2]
                                                                          .email),
                                                                  buildRow(
                                                                    'Tarih',
                                                                    DateFormat('dd.MM.yyyy').format(data[
                                                                            index]
                                                                        .voteUsers[
                                                                            index2]
                                                                        .date),
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height /
                                                                70,
                                                          ),
                                                        ],
                                                      );
                                                    },
                                                    itemCount: data[index]
                                                        .voteUsers
                                                        .length,
                                                  ),
                                                ),
                                              );
                                            },
                                          );
                                        },
                                        child: const Text('DETAY'),
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
            itemCount: data.length),
      ),
    );
  }

  Row buildRow(String title, String content) {
    return Row(
      children: <Widget>[
        Text(
          title + " :",
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        Expanded(
          child: AutoSizeText(
            content,
            maxLines: 1,
            minFontSize: 2,
            overflow: TextOverflow.ellipsis,
            maxFontSize: 13,
          ),
        )
      ],
    );
  }
}
