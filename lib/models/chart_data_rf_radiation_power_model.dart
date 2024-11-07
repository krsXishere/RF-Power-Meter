class ChartDataRFRadiationPowerModel {
  String? rfRadiationPower;
  DateTime? dateTime;

  ChartDataRFRadiationPowerModel({
    required this.rfRadiationPower,
    required this.dateTime,
  });

  Map<String, dynamic> toMap() {
    return {
      'rf_radiation_power': rfRadiationPower,
      'datetime': dateTime,
    };
  }
}
