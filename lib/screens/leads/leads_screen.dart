import 'package:flutter/material.dart';
import 'package:growth/common_widgets/tab_bar_widget.dart';
import 'package:growth/screens/leads/all_leads_screen.dart';
import 'package:growth/screens/leads/this_month_leads_screen.dart';

class LeadsScreen extends StatelessWidget {
  const LeadsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const TabBarWidget(
      children: [
        AllLeads(),
        ThisMonthLeads(),
      ],
      length: 2,
      text: "LEADS",
      child: TabBar(
        tabs: [
          Tab(
            text: 'Hepsi',
          ),
          Tab(
            text: 'Bu Ay',
          )
        ],
      ),
    );
  }
}
