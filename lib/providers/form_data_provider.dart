import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weight_app/helpers/constants.dart';

final formDataProvider = StateProvider<FormData?>((ref) => null);

class FormData {
  final Measurement weightMeasurement;
  final Measurement heightMeasurement;
  final Activity activity;
  final Gender gender;
  final double weight;
  final double height;
  final double cals;
  final int age;
  FormData({
    required this.weightMeasurement,
    required this.heightMeasurement,
    required this.activity,
    required this.gender,
    required this.weight,
    required this.height,
    required this.cals,
    required this.age,
  });
}
