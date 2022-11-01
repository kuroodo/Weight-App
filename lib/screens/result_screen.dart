import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weight_app/helpers/constants.dart';
import 'package:weight_app/helpers/converter.dart';
import 'package:weight_app/helpers/routes.dart' as routes;
import 'package:weight_app/helpers/simulator.dart';
import 'package:weight_app/models/calc_params.dart';
import 'package:weight_app/models/result_data.dart';
import 'package:weight_app/models/weight_data.dart';
import 'package:weight_app/widgets/nav_drawer.dart';
import 'package:weight_app/widgets/result_screen/result_app_bar.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen({super.key});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
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
      Simulator.simulateTwoYears(
        startingWeight: startingWeight,
        activity: activity,
        calorieIntake: calorieIntake,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    CalcParams params =
        ModalRoute.of(context)!.settings.arguments as CalcParams;
    WeightData weightData = params.weightData;
    Activity activity = params.activity;

    return Scaffold(
      appBar: ResultAppBar(
        onQuestionTapped: () => Navigator.of(context)
            .pushNamed(routes.resultInfoScreen, arguments: params),
      ),
      body: FutureBuilder(
        future: _calculateData(
          startingWeight: weightData,
          activity: activity,
          calorieIntake: params.calorieIntake,
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
            weightMeasurement: params.weightMeasurement,
          );
        },
      ),
      drawer: const NavDrawer(),
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
    const double rowHeight = 62;
    return Column(
      children: [
        SizedBox(
          height: rowHeight,
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
            itemBuilder: (context, index) {
              double weight = weightMeasurement == Measurement.imperial
                  ? Converter.kgToPound(data[index].weight)
                  : data[index].weight;
              String date = DateFormat("MM/dd/yyyy").format(data[index].date);

              return Container(
                color: index.isEven ? Colors.grey.withOpacity(0.3) : null,
                child: SizedBox(
                  height: rowHeight,
                  child: Row(
                    children: [
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
