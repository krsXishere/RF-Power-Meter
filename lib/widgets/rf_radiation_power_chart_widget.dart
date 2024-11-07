import 'package:flutter/material.dart';
import 'package:rf_power_meter/common/constant.dart';
import 'package:rf_power_meter/models/chart_data_rf_radiation_power_model.dart';

import 'package:syncfusion_flutter_charts/charts.dart';

class RfRadiationPowerChartWidget extends StatelessWidget {
  const RfRadiationPowerChartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final List<ChartDataRFRadiationPowerModel> rfRadiationPowerChartData = [
      ChartDataRFRadiationPowerModel(
        rfRadiationPower: '10',
        dateTime: DateTime.tryParse(
          '2024-11-07 17:48:38.921105',
        ),
      ),
      ChartDataRFRadiationPowerModel(
        rfRadiationPower: '20',
        dateTime: DateTime.tryParse(
          '2024-11-07 18:48:38.921105',
        ),
      ),
      ChartDataRFRadiationPowerModel(
        rfRadiationPower: '30',
        dateTime: DateTime.tryParse(
          '2024-11-07 19:48:38.921105',
        ),
      ),
      ChartDataRFRadiationPowerModel(
        rfRadiationPower: '25',
        dateTime: DateTime.tryParse(
          '2024-11-07 20:48:38.921105',
        ),
      ),
      ChartDataRFRadiationPowerModel(
        rfRadiationPower: '13',
        dateTime: DateTime.tryParse(
          '2024-11-07 21:48:38.921105',
        ),
      ),
    ];

    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(defaultBorderRadius),
      ),
      child: Column(
        children: [
          Row(
            children: [
              RotatedBox(
                quarterTurns: 3,
                child: Text(
                  "dBm",
                  style: secondaryTextStyle.copyWith(
                    fontSize: 14,
                  ),
                ),
              ),
              SfCartesianChart(
                title: ChartTitle(
                  text: 'RF Radiation Power',
                  textStyle: secondaryTextStyle.copyWith(
                    fontSize: 14,
                    fontWeight: semiBold,
                  ),
                ),
                primaryXAxis: DateTimeAxis(
                  intervalType: DateTimeIntervalType.hours,
                ),
                primaryYAxis: NumericAxis(),
                series: [
                  SplineAreaSeries<ChartDataRFRadiationPowerModel, DateTime>(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        primaryColor,
                        white,
                      ],
                    ),
                    // splineType: SplineType.clamped,
                    dataSource: rfRadiationPowerChartData,
                    xValueMapper:
                        (ChartDataRFRadiationPowerModel rfRadiationPower, _) =>
                            rfRadiationPower.dateTime!,
                    yValueMapper:
                        (ChartDataRFRadiationPowerModel rfRadiationPower, _) =>
                            double.tryParse(
                                rfRadiationPower.rfRadiationPower ?? '0') ??
                            0,
                  ),
                ],
              ),
            ],
          ),
          Text(
            "Waktu",
            style: secondaryTextStyle.copyWith(
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
