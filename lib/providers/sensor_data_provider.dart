import 'dart:developer' as dev;
import 'dart:math';
import 'package:flutter/foundation.dart';
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

  Future<void> connect() async {
    try {
      // Hubungkan ke broker MQTT
      await _sensorDataService.connect();

      // Tunggu data pertama dari `listenToMessages`
      final sensorData = await _sensorDataService.listenToMessages();
      // Perbarui data di provider
      _sensorDataModel = sensorData;
      setSar();
      setPowerDensity();

      notifyListeners();
    } catch (e) {
      dev.log("Error: $e");
    }
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
    dev.log("power density: ${sensorDataModel?.powerDensity}");
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
}
