import 'package:flutter/material.dart';

class IsLoadingWidget extends StatelessWidget {
  const IsLoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}
