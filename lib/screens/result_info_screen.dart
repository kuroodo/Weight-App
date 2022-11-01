import 'package:flutter/material.dart';
import 'package:weight_app/helpers/constants.dart';
import 'package:weight_app/helpers/converter.dart';
import 'package:weight_app/models/calc_params.dart';
import 'package:weight_app/models/weight_data.dart';

class ResultInfoScreen extends StatelessWidget {
  const ResultInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    CalcParams data = ModalRoute.of(context)!.settings.arguments as CalcParams;
    const TextStyle textStyle = TextStyle(fontSize: 18);
    const EdgeInsets textPadding =
        EdgeInsets.symmetric(horizontal: 8, vertical: 15);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Result Information"),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: ListView(
              children: [
                Container(
                  padding: textPadding,
                  color: Colors.blueGrey.withOpacity(.4),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(_getDataText(data), style: textStyle),
                      const SizedBox(height: 5),
                      Text(_getBMIText(data), style: textStyle),
                    ],
                  ),
                ),
                Container(
                  padding: textPadding,
                  color: Colors.blueGrey.withOpacity(.15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(_getBMIRangeText(), style: textStyle),
                      const SizedBox(height: 5),
                      Text(_getIdealWeightText(data), style: textStyle),
                      const SizedBox(height: 25),
                      Text(_getIdealWeightInfoText(), style: textStyle)
                    ],
                  ),
                ),
                Divider(color: Colors.grey[600], thickness: 2, height: 0),
                Container(
                  padding: textPadding,
                  color: Colors.grey.withOpacity(.1),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(_getResultInfoText(), style: textStyle),
                      const SizedBox(height: 5),
                      Text(
                        _getMoreInfoText(),
                        style: textStyle,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  String _getDataText(CalcParams data) {
    String gender = data.weightData.isMale ? "male" : "female";
    String weightMeasurement = data.weightMeasurement.weightText;
    String weight = _getWeight(data.weightData.weight, data.weightMeasurement);
    String heightMeasurement = data.heightMeasurement.heightText;
    String height = _getHeight(data.weightData.height, data.heightMeasurement);

    return "You are a $height$heightMeasurement tall $gender who weighs $weight $weightMeasurement who intends to eat around ${data.calorieIntake} calories each day.";
  }

  String _getBMIText(CalcParams data) {
    String weightStatus = _getWeightStatusText(data.weightData);
    _getWeight(data.weightData.idealWeight, data.weightMeasurement);

    return "Your current BMI is ${data.weightData.bmi.toStringAsFixed(2)} which means you are $weightStatus.";
  }

  String _getBMIRangeText() {
    return "A healthy BMI range is between 18.5 and 24.9.";
  }

  String _getIdealWeightText(CalcParams data) {
    String weightMeasurement = data.weightMeasurement.weightText;
    String idealWeight =
        _getWeight(data.weightData.idealWeight, data.weightMeasurement);

    return "For a person of your age, height, and gender, your ideal weight should be around $idealWeight $weightMeasurement.";
  }

  String _getIdealWeightInfoText() {
    return "Note that the ideal weight and BMI may vary per individual. Factors such as muscle mass, muscle to fat ratio, skeletal structure and more are not measured by this application.";
  }

  String _getResultInfoText() {
    return "The data on the results screen shows an estimated projection of your weight based on your activity and calorie intake.";
  }

  String _getMoreInfoText() {
    return "For more information, return to the results screen, open the side menu, and select Weight Lost Tips";
  }

  String _getWeightStatusText(WeightData weightData) {
    String weightStatus;

    if (weightData.bmi < 18.5) {
      weightStatus = "underweight";
    } else if (weightData.bmi > 24.9) {
      weightStatus = "overweight";
    } else {
      weightStatus = "of healthy weight";
    }

    return weightStatus;
  }

  String _getWeight(double weight, Measurement weightMeasurement) {
    if (weightMeasurement == Measurement.imperial) {
      return Converter.kgToPound(weight).toStringAsFixed(2);
    } else {
      return weight.toStringAsFixed(2);
    }
  }

  String _getHeight(double height, Measurement heightMeasurement) {
    if (heightMeasurement == Measurement.imperial) {
      return Converter.cmToInch(height).toStringAsFixed(2);
    } else {
      return height.toStringAsFixed(2);
    }
  }
}
