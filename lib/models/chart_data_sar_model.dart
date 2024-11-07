class ChartDataSARModel {
  String? sar;
  DateTime? dateTime;

  ChartDataSARModel({
    required this.sar,
    required this.dateTime,
  });

  Map<String, dynamic> toMap() {
    return {
      'sar': sar,
      'datetime': dateTime,
    };
  }
}
