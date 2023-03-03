import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:weight_app/helpers/constants.dart';
import 'package:weight_app/helpers/converter.dart' as converter;
import 'package:weight_app/helpers/routes.dart' as routes;
import 'package:weight_app/helpers/simulator.dart' as simulator;
import 'package:weight_app/models/result_data.dart';
import 'package:weight_app/models/weight_data.dart';
import 'package:weight_app/providers/form_data_provider.dart';
import 'package:weight_app/widgets/navigation/nav_drawer.dart';
import 'package:weight_app/widgets/navigation/side_navigator.dart';
import 'package:weight_app/widgets/result_screen/result_app_bar.dart';

class ResultScreen extends ConsumerStatefulWidget {
  const ResultScreen({super.key});

  @override
  ConsumerState<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends ConsumerState<ResultScreen> {
  late final FormData? _formData;
  late final WeightData _weightData;
  late final Activity _activity;
  List<ResultData>? _data;

  Future<List<ResultData>> _calculateData({
    required WeightData startingWeight,
    required Activity activity,
    required double calorieIntake,
  }) {
    if (_data != null) {
      return Future.value(_data);
    }
    return Future.value(
      simulator.simulateTwoYears(
        startingWeight: startingWeight,
        activity: activity,
        calorieIntake: calorieIntake,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _formData = ref.read(formDataProvider);
    if (_formData == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showNoDataAlert();
      });
      return;
    }

    // Note: Convert to records for Dart 3
    double weight = _formData!.weightMeasurement == Measurement.imperial
        ? converter.poundToKg(_formData!.weight)
        : _formData!.weight;
    double height = _formData!.heightMeasurement == Measurement.imperial
        ? converter.inchToCm(_formData!.height)
        : _formData!.height;

    _weightData = WeightData(
      age: _formData!.age.toDouble(),
      weight: weight,
      height: height,
      isMale: _formData!.gender == Gender.male,
    );
    _activity = _formData!.activity;
  }

  @override
  Widget build(BuildContext context) {
    bool useMobile = Platform.isAndroid || Platform.isIOS;

    if (_formData == null) return const SizedBox.shrink();

    return Scaffold(
      body: Row(
        children: [
          if (!useMobile) const SideNavigator(),
          Expanded(
            child: Column(
              children: [
                ResultAppBar(
                  height: 45,
                  onQuestionTapped: () => Navigator.of(context)
                      .pushNamed(routes.resultInfoScreen, arguments: _formData),
                ),
                Expanded(
                  child: FutureBuilder(
                    future: _calculateData(
                      startingWeight: _weightData,
                      activity: _activity,
                      calorieIntake: _formData!.cals,
                    ),
                    builder: (context, snapshot) {
                      if (_data == null &&
                          snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      if (_data == null && snapshot.hasData) {
                        _data = snapshot.data;
                      }

                      return _ResultChart(
                        data: _data!,
                        weightMeasurement: _formData!.weightMeasurement,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      drawer: useMobile ? const NavDrawer() : null,
    );
  }

  void showNoDataAlert() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Error"),
        content: const Text("No data found. Please go back and try again."),
        actions: [
          TextButton(
            onPressed: () =>
                Navigator.of(context).popAndPushNamed("home_screen"),
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }
}

class _ResultChart extends StatelessWidget {
  final List<ResultData> data;
  final Measurement weightMeasurement;
  const _ResultChart({
    required this.data,
    required this.weightMeasurement,
  });

  @override
  Widget build(BuildContext context) {
    const TextStyle headerStyle = TextStyle(fontSize: 13);
    const TextStyle dataStyle = TextStyle(fontSize: 15);
    const double columnHeight = 62;
    return Column(
      children: [
        SizedBox(
          height: columnHeight,
          // Multi-row hack needed to keep Week text to the left while keeping everything else centered
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Row(
                  children: const [
                    Expanded(
                      flex: 1,
                      child: Text(
                        "Week",
                        textAlign: TextAlign.center,
                        style: headerStyle,
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(
                        "Date",
                        textAlign: TextAlign.center,
                        style: headerStyle,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 3,
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Text(
                        "Weight (${weightMeasurement.weightText})",
                        textAlign: TextAlign.center,
                        style: headerStyle,
                      ),
                    ),
                    const Expanded(
                      flex: 1,
                      child: Text(
                        "Calories Used",
                        textAlign: TextAlign.center,
                        style: headerStyle,
                      ),
                    ),
                    const Expanded(
                      flex: 1,
                      child: Text(
                        "Deficit",
                        textAlign: TextAlign.center,
                        style: headerStyle,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              double weight = weightMeasurement == Measurement.imperial
                  ? converter.kgToPound(data[index].weight)
                  : data[index].weight;
              String date = DateFormat("MM/dd/yyyy").format(data[index].date);

              return Container(
                color: index.isEven ? Colors.grey.withOpacity(0.3) : null,
                child: SizedBox(
                  height: columnHeight,
                  child: Row(
                    children: [
                      // Once again multi-row hack needed to keep Week text to the left while keeping everything else centered
                      Expanded(
                        flex: 2,
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                "${data[index].week}",
                                textAlign: TextAlign.center,
                                style: dataStyle,
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Text(
                                date,
                                textAlign: TextAlign.center,
                                style: dataStyle,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Text(
                                weight.toStringAsFixed(2),
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.yellow),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Text(
                                data[index].calsUsed.toStringAsFixed(2),
                                textAlign: TextAlign.center,
                                style: dataStyle,
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Text(
                                data[index].deficit.toStringAsFixed(2),
                                textAlign: TextAlign.center,
                                style: dataStyle,
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
