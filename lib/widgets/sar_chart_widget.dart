import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:rf_power_meter/common/constant.dart';
import 'package:rf_power_meter/models/chart_data_sar_model.dart';
import 'package:rf_power_meter/providers/sensor_data_provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class SarChartWidget extends StatelessWidget {
  const SarChartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // final List<ChartDataSARModel> sarChartData = [
    //   ChartDataSARModel(
    //     sar: '10',
    //     dateTime: DateTime.tryParse(
    //       '2024-11-07 17:48:38.921105',
    //     ),
    //   ),
    //   ChartDataSARModel(
    //     sar: '20',
    //     dateTime: DateTime.tryParse(
    //       '2024-11-07 18:48:38.921105',
    //     ),
    //   ),
    //   ChartDataSARModel(
    //     sar: '30',
    //     dateTime: DateTime.tryParse(
    //       '2024-11-07 19:48:38.921105',
    //     ),
    //   ),
    //   ChartDataSARModel(
    //     sar: '25',
    //     dateTime: DateTime.tryParse(
    //       '2024-11-07 20:48:38.921105',
    //     ),
    //   ),
    //   ChartDataSARModel(
    //     sar: '13',
    //     dateTime: DateTime.tryParse(
    //       '2024-11-07 21:48:38.921105',
    //     ),
    //   ),
    // ];

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
                  "µW/kg",
                  style: secondaryTextStyle.copyWith(
                    fontSize: 14,
                  ),
                ),
              ),
              Consumer<SensorDataProvider>(
                builder: (context, sensorDataProvider, child) {
                  return StreamBuilder(
                    stream: sensorDataProvider.chartDataSarStream,
                    builder: (context, snapshot) {
                      return SfCartesianChart(
                        title: ChartTitle(
                          text: 'Specific Absorption Rate',
                          textStyle: secondaryTextStyle.copyWith(
                            fontSize: 14,
                            fontWeight: semiBold,
                          ),
                        ),
                        primaryXAxis: DateTimeAxis(
                          intervalType: DateTimeIntervalType.minutes,
                        ),
                        primaryYAxis: NumericAxis(
                        ),
                        series: [
                          SplineAreaSeries<ChartDataSARModel, DateTime>(
                            animationDelay: 0,
                            animationDuration: 0,
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                primaryColor,
                                white,
                              ],
                            ),
                            // splineType: SplineType.clamped,
                            dataSource: snapshot.data ?? [],
                            xValueMapper: (ChartDataSARModel sar, _) =>
                                sar.dateTime!,
                            yValueMapper: (ChartDataSARModel sar, _) =>
                                double.tryParse(sar.sar ?? '0') ?? 0,
                          ),
                        ],
                      );
                    },
                  );
                },
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
