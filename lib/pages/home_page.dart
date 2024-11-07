import 'package:flutter/material.dart';
import 'package:rf_power_meter/common/constant.dart';
import 'package:rf_power_meter/widgets/card_status_widget.dart';
import 'package:rf_power_meter/widgets/rf_radiation_power_chart_widget.dart';
import 'package:rf_power_meter/widgets/sar_chart_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: white,
        shadowColor: white,
        foregroundColor: white,
        surfaceTintColor: white,
        elevation: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Penting Hari Ini",
              style: secondaryTextStyle.copyWith(
                fontWeight: semiBold,
                fontSize: 16,
              ),
            ),
            Text(
              "Moniroting di sini!",
              style: secondaryTextStyle.copyWith(
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.all(defaultPadding),
          child: Column(
            children: [
              const CardStatusWidget(),
              SizedBox(
                height: defaultPadding,
              ),
              const SarChartWidget(),
              SizedBox(
                height: defaultPadding,
              ),
              const RfRadiationPowerChartWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
