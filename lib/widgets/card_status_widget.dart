import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rf_power_meter/common/constant.dart';
import 'package:rf_power_meter/providers/sensor_data_provider.dart';

class CardStatusWidget extends StatelessWidget {
  const CardStatusWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.7,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      children: [
        Container(
          padding: EdgeInsets.all(defaultPadding),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(defaultBorderRadius),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Temperature",
                style: secondaryTextStyle.copyWith(
                  fontSize: 14,
                ),
              ),
              Consumer<SensorDataProvider>(
                builder: (context, sensorDataProvider, child) {
                  return Text(
                    "${sensorDataProvider.sensorDataModel?.temperature ?? 0} °C",
                    style: secondaryTextStyle.copyWith(
                        fontSize: 14, fontWeight: semiBold),
                  );
                },
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.all(defaultPadding),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(defaultBorderRadius),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "RF Radiation Power",
                style: secondaryTextStyle.copyWith(
                  fontSize: 14,
                ),
              ),
              Consumer<SensorDataProvider>(
                builder: (context, sensorDataProvider, child) {
                  return Text(
                    "${sensorDataProvider.sensorDataModel?.rfRadiationPower ?? 0} dBm",
                    style: secondaryTextStyle.copyWith(
                        fontSize: 14, fontWeight: semiBold),
                  );
                },
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.all(defaultPadding),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(defaultBorderRadius),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "SAR",
                style: secondaryTextStyle.copyWith(
                  fontSize: 14,
                ),
              ),
              Consumer<SensorDataProvider>(
                builder: (context, sensorDataProvider, child) {
                  return Text(
                    "${sensorDataProvider.sar} ${sensorDataProvider.unit}/kg",
                    style: secondaryTextStyle.copyWith(
                        fontSize: 14, fontWeight: semiBold),
                  );
                },
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.all(defaultPadding),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(defaultBorderRadius),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Power Density",
                style: secondaryTextStyle.copyWith(
                  fontSize: 14,
                ),
              ),
              Consumer<SensorDataProvider>(
                builder: (context, sensorDataProvider, child) {
                  return Text(
                    "${sensorDataProvider.powerDensity} ${sensorDataProvider.unit}/cm²",
                    style: secondaryTextStyle.copyWith(
                        fontSize: 14, fontWeight: semiBold),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
