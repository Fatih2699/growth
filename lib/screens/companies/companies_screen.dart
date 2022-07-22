import 'package:flutter/material.dart';
import 'package:growth/common_widgets/tab_bar_widget.dart';
import 'package:growth/screens/companies/account_activities_screen.dart';
import 'package:growth/screens/companies/all_companies_screen.dart';
import 'package:growth/screens/companies/integration_screen.dart';
import 'package:growth/screens/companies/ots_screen.dart';
import 'package:growth/screens/companies/pos_rapor_screen.dart';
import 'package:growth/screens/companies/vomsis_pos_screen.dart';

class CompaniesScreen extends StatelessWidget {
  const CompaniesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const TabBarWidget(
      children: [
        AllCompaniesScreen(),
        AccountActivitiesScreen(),
        PosRaporScreen(),
        OtsScreen(),
        IntegrationScreen(),
        VomsisPosScreen(),
      ],
      length: 6,
      text: 'FİRMALAR',
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
