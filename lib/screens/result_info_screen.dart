import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weight_app/helpers/constants.dart';
import 'package:weight_app/helpers/converter.dart' as converter;
import 'package:weight_app/helpers/navigation.dart';
import 'package:weight_app/providers/form_data_provider.dart';

class ResultInfoScreen extends ConsumerWidget {
  const ResultInfoScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const TextStyle textStyle = TextStyle(fontSize: 18);
    const EdgeInsets textPadding =
        EdgeInsets.symmetric(horizontal: 8, vertical: 15);

    FormData? formData = ref.read(formDataProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Result Information"),
        centerTitle: true,
      ),
      body: formData == null
          ? const NoDataWidget()
          : WillPopScope(
              onWillPop: () async {
                // Make the current route the result screen when pressing back
                Navigation.overrideCurrentRoute(resultScreen);
                Navigator.pop(context);
                return Future.value(false);
              },
              child: Column(
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
                              Text(_getDataText(formData), style: textStyle),
                              const SizedBox(height: 5),
                              Text(_getBMIText(formData), style: textStyle),
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
                              Text(_getIdealWeightText(formData),
                                  style: textStyle),
                              const SizedBox(height: 25),
                              Text(_getIdealWeightInfoText(), style: textStyle)
                            ],
                          ),
                        ),
                        Divider(
                            color: Colors.grey[600], thickness: 2, height: 0),
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
            ),
    );
  }

  String _getDataText(FormData data) {
    String gender = data.gender == Gender.male ? "male" : "female";
    String weightMeasurement = data.weightMeasurement.weightText;
    String weight = data.weight.toStringAsFixed(2);
    String heightMeasurement = data.heightMeasurement.heightText;
    String height = data.height.toStringAsFixed(2);

    return "You are a $height$heightMeasurement tall $gender who weighs $weight $weightMeasurement who intends to eat around ${data.cals} calories each day.";
  }

  String _getBMIText(FormData data) {
    double bmi = data.weightData.bmi;
    String weightStatus = _getWeightStatusText(bmi);

    return "Your current BMI is ${bmi.toStringAsFixed(2)} which means you are $weightStatus.";
  }

  String _getBMIRangeText() {
    return "A healthy BMI range is between 18.5 and 24.9.";
  }

  String _getIdealWeightText(FormData data) {
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

  String _getWeightStatusText(double bmi) {
    String weightStatus;

    if (bmi < 18.5) {
      weightStatus = "underweight";
    } else if (bmi > 24.9) {
      weightStatus = "overweight";
    } else {
      weightStatus = "of healthy weight";
    }

    return weightStatus;
  }

  String _getWeight(double weight, Measurement weightMeasurement) {
    if (weightMeasurement == Measurement.imperial) {
      return converter.kgToPound(weight).toStringAsFixed(2);
    } else {
      return weight.toStringAsFixed(2);
    }
  }
}

class NoDataWidget extends StatelessWidget {
  const NoDataWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("No data available"),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () => Navigation.popAndNavigateTo(
              route: homeScreen,
              context: context,
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 99, 135, 152),
              minimumSize: const Size(100, 50),
            ),
            child: const Text("Go back"),
          )
        ],
      ),
    );
  }
}
