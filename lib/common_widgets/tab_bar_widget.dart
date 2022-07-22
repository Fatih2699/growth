import 'package:flutter/material.dart';
import 'package:growth/common_widgets/drawer_widget.dart';
import 'package:growth/constants/app_constant.dart';

class TabBarWidget extends StatefulWidget {
  final List<Widget> children;
  final int length;
  final String text;
  final PreferredSizeWidget child;
  const TabBarWidget({
    Key? key,
    required this.children,
    required this.length,
    required this.text,
    required this.child,
  }) : super(key: key);
  @override
  State<TabBarWidget> createState() => _TabBarWidgetState();
}

class _TabBarWidgetState extends State<TabBarWidget> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: widget.length,
      child: Scaffold(
        drawer: const DrawerWidget(),
        appBar: AppBar(
          title: Text(widget.text),
          centerTitle: true,
          toolbarHeight: 30,
          elevation: 5,
          backgroundColor: ApplicationConstants.lacivert,
          bottom: widget.child,
        ),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: TabBarView(
            children: widget.children,
          ),
        ),
      ),
    );
  }
}
