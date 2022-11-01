import 'package:weight_app/helpers/constants.dart';
import 'package:weight_app/models/result_data.dart';
import 'package:weight_app/models/weight_data.dart';

import 'converter.dart' as converter;

WeightData simulateWeek({
  required WeightData weightData,
  required Activity activity,
  required double calorieIntake,
}) {
  WeightData result = weightData;
  double calorieDeficit = 0.0;

  for (int i = 0; i < 7; i++) {
    calorieDeficit = result.getCalorieRate(activity) - calorieIntake;
    double weightLoss = calorieDeficit / caloriePound;
    result = WeightData.newWeight(
      weightData: result,
      newWeight: result.weight - converter.poundToKg(weightLoss),
    );
  }
  return result;
}

List<ResultData> simulateTwoYears({
  required WeightData startingWeight,
  required Activity activity,
  required double calorieIntake,
}) {
  List<ResultData> values = [];
  WeightData weightData = startingWeight;
  DateTime date = DateTime.now();
  for (int i = 0; i < 104; i++) {
    weightData = simulateWeek(
      weightData: weightData,
      activity: activity,
      calorieIntake: calorieIntake,
    );
    date = date.add(const Duration(days: 7));
    values.add(
      ResultData(
        week: i + 1,
        date: date,
        weightData: weightData,
        calsUsed: weightData.getCalorieRate(activity),
        deficit: weightData.getCalorieRate(activity) - calorieIntake,
      ),
    );
  }
  return values;
}
