import 'package:weight_app/helpers/constants.dart';
import 'package:weight_app/models/weight_data.dart';

class CalcParams {
  final WeightData weightData;
  final Activity activity;
  final double calorieIntake;
  final Measurement heightMeasurement;
  final Measurement weightMeasurement;

  CalcParams({
    required this.weightData,
    required this.activity,
    required this.calorieIntake,
    required this.heightMeasurement,
    required this.weightMeasurement,
  });
}
