class SensorDataModel {
  double? temperature, rfRadiationPower, sar, powerDensity;

  SensorDataModel({
    required this.temperature,
    required this.rfRadiationPower,
    required this.sar,
    required this.powerDensity,
  });

  factory SensorDataModel.fromJson(Map<String, dynamic> object) {
    // log("power density: ${object['power_density']}");
    return SensorDataModel(
      temperature: object['temperature'],
      rfRadiationPower: object['rf_radiation_power'],
      sar: object['sar'],
      powerDensity: object['power_density'],
    );
  }

  // Factory method untuk parsing dari String
  factory SensorDataModel.fromString(String csvString) {
    // Split string berdasarkan koma
    final List<String> values = csvString.split(',');

    if (values.length != 4) {
      throw const FormatException(
          'Invalid input: Expected 4 comma-separated values.');
    }

    // Konversi menjadi Map<String, dynamic>
    final Map<String, dynamic> jsonObject = {
      'temperature': double.parse(values[0]),
      'rf_radiation_power': double.parse(values[1]),
      'sar': double.parse(values[2]),
      'power_density': double.parse(values[3]),
    };

    // Parsing menggunakan `fromJson`
    return SensorDataModel.fromJson(jsonObject);
  }

  void updateSar(double newSar) {
    sar = newSar;
  }

  void updatePowerDensity(double newPowerDensity) {
    powerDensity = newPowerDensity;
  }
}
