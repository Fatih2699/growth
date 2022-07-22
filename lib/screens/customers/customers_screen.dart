import 'package:flutter/material.dart';
import 'package:growth/common_widgets/tab_bar_widget.dart';
import 'package:growth/screens/customers//ots_screen.dart';
import 'package:growth/screens/customers/account_activities_screen.dart';
import 'package:growth/screens/customers/all_customers_screen.dart';
import 'package:growth/screens/customers/integration_screen.dart';
import 'package:growth/screens/customers/pos_rapor_screen.dart';
import 'package:growth/screens/customers/vomsis_pos_screen.dart';

class CustomerScreen extends StatelessWidget {
  const CustomerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const TabBarWidget(
      children: [
        AllCustomersScreen(),
        AccountActivitiesScreen(),
        PosRaporScreen(),
        OtsScreen(),
        IntegrationScreen(),
        VomsisPosScreen(),
      ],
      length: 6,
      text: 'MÜŞTERİLER',
      child: TabBar(
        isScrollable: true,
        tabs: [
          Tab(
            text: 'Hepsi',
          ),
          Tab(
            text: 'Hesap Hareketleri',
          ),
          Tab(
            text: 'Pos Rapor',
          ),
          Tab(
            text: 'OTS',
          ),
          Tab(
            text: 'Entegrasyon',
          ),
          Tab(
            text: 'Vomsis Pos',
          ),
        ],
      ),
    );
  }
}
