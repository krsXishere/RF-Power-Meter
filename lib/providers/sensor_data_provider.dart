import 'dart:async';
import 'dart:developer' as dev;
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:rf_power_meter/models/chart_data_rf_radiation_power_model.dart';
import 'package:rf_power_meter/models/chart_data_sar_model.dart';
import 'package:rf_power_meter/models/sensor_data_model.dart';
import 'package:rf_power_meter/services/sensor_data_service.dart';

class SensorDataProvider with ChangeNotifier {
  final _sensorDataService = SensorDataService();
  SensorDataModel? _sensorDataModel;
  SensorDataModel? get sensorDataModel => _sensorDataModel;
  String _unit = "Watt";
  String get unit => _unit;
  String _sar = "";
  String get sar => _sar;
  String _powerDensity = "";
  String get powerDensity => _powerDensity;
  final List<ChartDataSARModel> _chartSar = [];
  List<ChartDataSARModel> get chartSar => _chartSar;
  final List<ChartDataRFRadiationPowerModel> _chartRFRadiationPower = [];
  List<ChartDataRFRadiationPowerModel> get chartRFRadiationPower =>
      _chartRFRadiationPower;

  String _status = "Normal";
  String get status => _status;
  Color _statusColor = Colors.green;
  Color get statusColor => _statusColor;

  Timer? _timer; // Tambahkan timer sebagai properti dalam class

  Future<void> connect() async {
    try {
      // Hubungkan ke broker MQTT
      await _sensorDataService.connect();

      // Polling data secara periodik
      _timer = Timer.periodic(const Duration(milliseconds: 500), (timer) async {
        try {
          final sensorData = await _sensorDataService.listenToMessages();
          _sensorDataModel = sensorData;
          setStatus();

          setSar(); // Update nilai SAR
          setPowerDensity(); // Update Power Density

          // Tambahkan data ke grafik
          _chartSar.add(ChartDataSARModel(
            dateTime: DateTime.now(),
            sar: convertValue(sensorData.sar ?? 0, "µW").toStringAsFixed(2),
          ));
          _chartRFRadiationPower.add(ChartDataRFRadiationPowerModel(
            dateTime: DateTime.now(),
            rfRadiationPower: sensorData.rfRadiationPower.toString(),
          ));

          notifyListeners();
        } catch (e) {
          dev.log("Error fetching data: $e");
        }
      });
    } catch (e) {
      dev.log("Error: $e");
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void setUnit(String value) {
    _unit = value;
    setSar();
    setPowerDensity();
    notifyListeners();
  }

  void setSar() async {
    if (_unit == "Watt") {
      _sar = convertValue(sensorDataModel?.sar ?? 0, _unit).toString();
    } else if (_unit == "mW") {
      _sar = convertValue(sensorDataModel?.sar ?? 0, _unit).toStringAsFixed(4);
    } else {
      _sar = convertValue(sensorDataModel?.sar ?? 0, _unit).toStringAsFixed(2);
    }
  }

  void setPowerDensity() async {
    if (_unit == "Watt") {
      _powerDensity =
          convertValue(sensorDataModel?.powerDensity ?? 0, _unit).toString();
    } else if (_unit == "mW") {
      _powerDensity = convertValue(sensorDataModel?.powerDensity ?? 0, _unit)
          .toStringAsFixed(4);
    } else {
      _powerDensity = convertValue(sensorDataModel?.powerDensity ?? 0, _unit)
          .toStringAsFixed(2);
    }
  }

  double convertValue(double value, String unit) {
    switch (unit) {
      case "Watt":
        return value; // Tidak ada perubahan jika satuannya Watt
      case "mW":
        return value * pow(10, 3); // Dari Watt ke miliWatt
      case "µW":
        return value * pow(10, 6); // Dari Watt ke mikroWatt
      default:
        throw Exception("Unit tidak dikenal: $unit");
    }
  }

  Stream<List<ChartDataSARModel>> get chartDataSarStream async* {
    yield* Stream.periodic(const Duration(milliseconds: 500), (_) {
      try {
        return _chartSar;
        // return [];
      } catch (e) {
        dev.log(e.toString());
        throw Exception(e);
      }
    });
  }

  Stream<List<ChartDataRFRadiationPowerModel>>
      get chartDataRFRadiationPowerStream async* {
    yield* Stream.periodic(const Duration(milliseconds: 500), (_) {
      try {
        return _chartRFRadiationPower;
        // return [];
      } catch (e) {
        dev.log(e.toString());
        throw Exception(e);
      }
    });
  }

  setStatus() {
    // dev.log("SAR ROUND: ${sensorDataModel!.sar!.round()}");
    if (sensorDataModel != null) {
      if (sensorDataModel!.sar!.round() < 1) {
        _status = "Normal";
        _statusColor = Colors.green;
      } else if (sensorDataModel!.sar!.round() >= 1 &&
          sensorDataModel!.sar!.round() <= 2) {
        _status = "Moderate";
        _statusColor = Colors.orange;
      } else {
        _status = "Danger";
        _statusColor = Colors.red;
      }
    }

    notifyListeners();
  }
}
