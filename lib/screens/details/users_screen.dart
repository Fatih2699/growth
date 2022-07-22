// ignore_for_file: avoid_print

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:growth/models/customer_detail_model.dart';
import 'package:timeago/timeago.dart' as timeago;

class UsersScreen extends StatefulWidget {
  final Customer customer;
  const UsersScreen({Key? key, required this.customer}) : super(key: key);

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  @override
  void initState() {
    super.initState();
    timeago.setLocaleMessages('tr', timeago.TrMessages());
  }

  String timeAgo(DateTime d) {
    Duration diff = DateTime.now().difference(d);
    print(DateTime.now().toString() +
        '-->' +
        d.toString() +
        '-->' +
        diff.inHours.toString());
    return diff.inHours.toString();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ListView.builder(
            controller: ScrollController(),
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: widget.customer.users.length,
            itemBuilder: (context, index) {
              return Card(
                elevation: 10,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 5.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                                child: AutoSizeText(
                              widget.customer.users[index].name!,
                              maxLines: 3,
                              maxFontSize: 15,
                            )),
                            Column(
                              children: [
                                widget.customer.users[index].lastActivity != '-'
                                    ? Text(
                                        timeago.format(
                                            DateTime.parse(widget.customer
                                                .users[index].lastActivity),
                                            locale: 'tr'),
                                        style: const TextStyle(
                                            color: Colors.green),
                                      )
                                    : const Text('-'),
                                Text(
                                    widget.customer.users[index].lastActivity ??
                                        '-'),
                              ],
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 5.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                children: [
                                  Text(widget.customer.users[index].email!),
                                  const SizedBox(height: 5),
                                  Text(widget.customer.users[index].phone!),
                                ],
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 3.2,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.green,
                                    border: Border.all(
                                      width: 3.0,
                                      color: Colors.green,
                                    ),
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(5.0),
                                    )),
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.people,
                                        color: Colors.white,
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                          widget.customer.users[index]
                                                      .hasLocked ==
                                                  0
                                              ? 'Açık'
                                              : 'Kilitli',
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
