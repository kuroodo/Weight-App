import 'package:weight_app/models/weight_data.dart';

class ResultData {
  final int week;
  final DateTime date;
  final WeightData weightData;
  final double calsUsed;
  final double deficit;

  ResultData({
    required this.week,
    required this.date,
    required this.weightData,
    required this.calsUsed,
    required this.deficit,
  });

  double get weight => weightData.weight;
}
