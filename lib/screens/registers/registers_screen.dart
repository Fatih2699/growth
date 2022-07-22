import 'package:flutter/material.dart';
import 'package:growth/common_widgets/tab_bar_widget.dart';
import 'package:growth/screens/registers/all_register_screen.dart';
import 'package:growth/screens/registers/this_month_screen.dart';

class RegistersScreen extends StatelessWidget {
  const RegistersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const TabBarWidget(
      children: [
        AllRegister(),
        ThisMonthRegister(),
      ],
      text: 'Kayıtlar',
      length: 2,
      child: TabBar(
        tabs: [
          Tab(
            text: 'Hepsi',
          ),
          Tab(
            text: 'Bu Ay',
          ),
        ],
      ),
    );
  }
}
