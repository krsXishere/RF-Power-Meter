import 'package:flutter/material.dart';
import 'package:rf_power_meter/common/constant.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Penting Hari Ini",
          style: secondaryTextStyle,
        ),
      ),
    );
  }
}
