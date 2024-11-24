import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rf_power_meter/common/constant.dart';
import 'package:rf_power_meter/providers/sensor_data_provider.dart';
import 'package:rf_power_meter/widgets/card_status_widget.dart';
import 'package:rf_power_meter/widgets/rf_radiation_power_chart_widget.dart';
import 'package:rf_power_meter/widgets/sar_chart_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timestamp) {
      Provider.of<SensorDataProvider>(
        context,
        listen: false,
      ).connect();
    });

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
              "Monitoring di sini!",
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
              SizedBox(
                width: double.maxFinite,
                child: Consumer<SensorDataProvider>(
                  builder: (context, sensorDataProvider, child) {
                    return DropdownButtonFormField(
                      dropdownColor: white,
                      style: primaryTextStyle.copyWith(
                        fontSize: 14,
                      ),
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 10,
                        ),
                        filled: false,
                        border: InputBorder.none,
                        hintText: "Pilih Satuan",
                        hintStyle: primaryTextStyle.copyWith(
                          fontWeight: regular,
                          color: grey400,
                          fontSize: 12,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(11),
                          borderSide: BorderSide(
                            color: primaryColor,
                          ),
                        ),
                        disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(11),
                          borderSide: const BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      items: [
                        DropdownMenuItem(
                          value: "Watt",
                          child: Text(
                            "Watt",
                            style: secondaryTextStyle,
                          ),
                        ),
                        DropdownMenuItem(
                          value: "mW",
                          child: Text(
                            "mW",
                            style: secondaryTextStyle,
                          ),
                        ),
                        DropdownMenuItem(
                          value: "µW",
                          child: Text(
                            "µW",
                            style: secondaryTextStyle,
                          ),
                        ),
                      ],
                      onChanged: (value) {
                        sensorDataProvider.setUnit(value!);
                      },
                    );
                  },
                ),
              ),
              SizedBox(
                height: defaultPadding,
              ),
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
