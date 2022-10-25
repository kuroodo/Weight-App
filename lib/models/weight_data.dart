import 'dart:math';

import 'package:weight_app/helpers/constants.dart';
import 'package:weight_app/helpers/converter.dart';

// BMR is calories burn per day for just existing
// BMR * activity points is calories burned per day

class WeightData {
  /// Weight in metric
  final double weight;

  /// Height in metric
  final double height;

  final double age;
  final bool isMale;
  const WeightData(
      {required this.age,
      required this.weight,
      required this.height,
      required this.isMale});

  factory WeightData.newWeight(
      {required WeightData weightData, required newWeight}) {
    return WeightData(
      age: weightData.age,
      weight: newWeight,
      height: weightData.height,
      isMale: weightData.isMale,
    );
  }

  /// BMR is calculated using the Mifflin-St Jeor Equation
  double get bmr {
    if (isMale) {
      return (10 * weight) + (6.25 * height) - (5 * age) + 5;
    }

    return (10 * weight) + (6.25 * height) - (5 * age) - 161;
  }

  double get bmi {
    return weight / pow(Converter.cmtoMeter(height), 2);
  }

  double get idealBmi {
    if (isMale) {
      return 22.5;
    } else {
      return 21;
    }
  }

  double get idealWeight {
    return 2.2 * idealBmi +
        (3.5 * idealBmi) * (Converter.cmtoMeter(height) - 1.5);
  }

  double getCalorieRate(Activity activity) {
    return bmr * activity.points;
  }

  double getActivityCalorieBurn(Activity activity) {
    return getCalorieRate(activity) - bmr;
  }

  @override
  String toString() {
    return "Age: $age\nIs male: $isMale\nHeight: $height\nWeight: $weight\nBMR: $bmr";
  }

  String toStringDeficit({required calorieIntake, required Activity activity}) {
    return "Age: $age\nIs male: $isMale\nHeight: $height\nWeight: $weight\nBMR: $bmr\nCalories used: ${getCalorieRate(activity)}\nDeficit: ${getCalorieRate(activity) - calorieIntake}";
  }
}
