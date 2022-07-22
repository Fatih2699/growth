import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:growth/screens/details/account_detail/account_detail_info.dart';

class AccountDetailScreen extends StatefulWidget {
  final int? id;
  final String? title;
  const AccountDetailScreen({Key? key, this.id, this.title}) : super(key: key);

  @override
  State<AccountDetailScreen> createState() => _AccountDetailScreenState();
}

class _AccountDetailScreenState extends State<AccountDetailScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF06113C),
          elevation: 5,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
          child: Column(
            children: [
              const SizedBox(height: 10),
              AutoSizeText(widget.title!,
                  style: const TextStyle(
                      fontSize: 19, fontWeight: FontWeight.bold),
                  maxFontSize: 19,
                  maxLines: 2),
              const SizedBox(height: 10),
              const Divider(thickness: 2, color: Colors.black12),
              const SizedBox(height: 10),
              Expanded(
                child: DefaultTabController(
                  length: 4,
                  initialIndex: 0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      const TabBar(
                        isScrollable: true,
                        labelColor: Color(0xFF5c59ef),
                        unselectedLabelColor: Colors.black,
                        tabs: [
                          Tab(
                            text: ' Hesap Hareketi',
                          ),
                          Tab(text: 'Pos Rapor'),
                          Tab(text: 'OTS'),
                          Tab(text: 'Entegrasyon'),
                        ],
                      ),
                      Expanded(
                        child: TabBarView(
                          children: [
                            DetailInfo(
                                id: widget.id!, type: 'account_transactions'),
                            DetailInfo(id: widget.id!, type: 'pos_report'),
                            DetailInfo(id: widget.id!, type: 'ots'),
                            DetailInfo(
                              id: widget.id!,
                              type: 'entegrasyon',
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
