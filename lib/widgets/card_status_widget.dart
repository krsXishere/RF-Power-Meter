import 'package:flutter/material.dart';
import 'package:rf_power_meter/common/constant.dart';

class CardStatusWidget extends StatelessWidget {
  const CardStatusWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2,
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
              Text(
                "3 °C",
                style: secondaryTextStyle.copyWith(
                    fontSize: 14, fontWeight: semiBold),
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
              Text(
                "3 dBm",
                style: secondaryTextStyle.copyWith(
                    fontSize: 14, fontWeight: semiBold),
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
              Text(
                "3 Watt/kg",
                style: secondaryTextStyle.copyWith(
                    fontSize: 14, fontWeight: semiBold),
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
              Text(
                "3 mW/cm²",
                style: secondaryTextStyle.copyWith(
                    fontSize: 14, fontWeight: semiBold),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
