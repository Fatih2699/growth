import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:growth/constants/app_constant.dart';
import 'package:intl/intl.dart';

class UtmDetail extends StatefulWidget {
  final String? refererData;
  const UtmDetail({Key? key, this.refererData}) : super(key: key);

  @override
  State<UtmDetail> createState() => _UtmDetailState();
}

class _UtmDetailState extends State<UtmDetail> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var jsonString = widget.refererData;
    var data = jsonDecode(jsonString!);
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        backgroundColor: ApplicationConstants.lacivert,
        title: const Text(
          'UTM-KAMPANYA DETAY',
          style: TextStyle(fontSize: 18),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
                child: ListView.builder(
                  controller: ScrollController(),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    DateTime date = DateTime.parse(data[index]['date']);
                    return SizedBox(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(width: 1.0),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(5.0))),
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    const Text('Aksiyon:   ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    Text(data[index]['action'].toString() ==
                                            'visit'
                                        ? 'Ziyaret'
                                        : 'Kayıt')
                                  ],
                                ),
                                const SizedBox(height: 5),
                                Row(
                                  children: const [
                                    Text('UTM-Arama Terimi:   ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    Text('-')
                                  ],
                                ),
                                const SizedBox(height: 5),
                                Row(
                                  children: const [
                                    Text('UTM-Source:   ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    Text('-')
                                  ],
                                ),
                                const SizedBox(height: 5),
                                Row(
                                  children: const [
                                    Text('UTM-Kampanya:   ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    Text('-')
                                  ],
                                ),
                                const SizedBox(height: 5),
                                Row(
                                  children: [
                                    const Text('Tarih:   ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    Text(DateFormat('dd.MM.yyyy   HH:mm:ss')
                                        .format(date)),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  children: [
                                    const Text('Source-URL:   ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    Expanded(
                                        child: Container(
                                            alignment: Alignment.center,
                                            height: 70,
                                            child: SingleChildScrollView(
                                                child: Text(Uri.decodeFull(
                                                    data[index]['source']
                                                        .toString())))))
                                  ],
                                ),
                                const SizedBox(height: 15),
                                Row(
                                  children: [
                                    const Text('Redirect-URL:   ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    Expanded(
                                        child: Container(
                                      alignment: Alignment.center,
                                      height: 70,
                                      child: SingleChildScrollView(
                                        child: Text(
                                          Uri.decodeFull(data[index]['redirect']
                                              .toString()),
                                        ),
                                      ),
                                    ))
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                )
                //child:Text(data.length.toString())
                ),
          ],
        ),
      ),
    );
  }
}
