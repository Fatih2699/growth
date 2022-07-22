import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:growth/models/package_model.dart';
import 'package:intl/intl.dart';

class CommonPackets extends StatefulWidget {
  final String title;
  final SInfo? package;

  const CommonPackets({Key? key, required this.title, required this.package})
      : super(key: key);

  @override
  State<CommonPackets> createState() => _CommonPacketsState();
}

class _CommonPacketsState extends State<CommonPackets> {
  @override
  Widget build(BuildContext context) {
    return widget.package == null
        ? Center(
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height / 30,
                ),
                SizedBox(),
                // Text(
                //   widget.title + ' Paketi Bulunamadı...',
                //   style: const TextStyle(
                //       fontWeight: FontWeight.bold, fontSize: 14),
                // )
              ],
            ),
          )
        : Card(
            elevation: 10,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.title,
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.red)),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      Text(
                          widget.package!.packageTitle.toString() +
                              ' - ' +
                              widget.package!.packagePrice.toString() +
                              '₺',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.blue)),
                    ],
                  ),
                  Container(
                    child: Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 5),
                              Row(
                                children: [
                                  const Text('İndirim Oranı: ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14)),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                      widget.package!.discountRate.toString() +
                                          ' % ',
                                      style: const TextStyle(fontSize: 14))
                                ],
                              ),
                              Row(
                                children: [
                                  const Text('Vopa: ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14)),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(widget.package!.vopa.toString() + '₺',
                                      style: const TextStyle(fontSize: 14))
                                ],
                              ),
                              Row(
                                children: [
                                  const Text('İndirim Tutarı: ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14)),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                      widget.package!.discountAmount
                                              .toString() +
                                          '₺',
                                      style: const TextStyle(fontSize: 14))
                                ],
                              ),
                              Row(
                                children: [
                                  const AutoSizeText(
                                    'İndirimli: ', //'İndirimli Fiyat: ',
                                    minFontSize: 8,
                                    maxFontSize: 14,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  AutoSizeText(
                                      widget.package!.generalTotal.toString() +
                                          '₺',
                                      minFontSize: 8,
                                      maxFontSize: 14,
                                      style: const TextStyle(fontSize: 14))
                                ],
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(DateFormat('dd/MM/yyyy')
                                      .format(widget.package!.startAt) +
                                  ' - ' +
                                  DateFormat('dd/MM/yyyy')
                                      .format(widget.package!.endAt)),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  const Text('A.T. İndirim Oranı: ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  Expanded(
                                    child: AutoSizeText(
                                      widget.package!.araToplamIndirimOrani! +
                                          '₺',
                                      maxLines: 1,
                                      minFontSize: 7,
                                      overflow: TextOverflow.ellipsis,
                                      maxFontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  const Text('A.T. İndirim Tutarı: ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  Expanded(
                                    child: AutoSizeText(
                                      widget.package!.araToplamIndirimTutari! +
                                          '₺',
                                      maxLines: 1,
                                      minFontSize: 7,
                                      overflow: TextOverflow.ellipsis,
                                      maxFontSize: 14,
                                    ),
                                  ),
                                  //Text(widget.package!.araToplamIndirimTutari!+'₺',style: TextStyle(fontSize: 14))
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Divider(thickness: 1, color: Colors.grey),
                  const SizedBox(height: 5),
                  const Text('Eklenen Firmalar',
                      style: TextStyle(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.start),
                  const SizedBox(height: 5),
                  SizedBox(
                    height: 40,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          ListView.builder(
                            controller: ScrollController(),
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: widget.package!.addedCompanies.length,
                            itemBuilder: (context, index) {
                              AddedCompany added =
                                  widget.package!.addedCompanies[index];
                              return Row(
                                children: [
                                  Text(
                                    added.licenseId.toString() + ' - ',
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                  Expanded(
                                    child: AutoSizeText(
                                      added.companyTitle.toString(),
                                      maxLines: 1,
                                      minFontSize: 7,
                                      overflow: TextOverflow.ellipsis,
                                      maxFontSize: 13,
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
