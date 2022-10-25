import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weight_app/helpers/constants.dart';
import 'package:weight_app/helpers/converter.dart';
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
  List<ResultData>? data;

  Future<List<ResultData>> calculateData({
    required WeightData startingWeight,
    required Activity activity,
    required double calorieIntake,
  }) {
    if (data != null) {
      return Future.value(data);
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
            .pushNamed("result_info_screen", arguments: params),
      ),
      body: FutureBuilder(
        future: calculateData(
          startingWeight: weightData,
          activity: activity,
          calorieIntake: params.calorieIntake,
        ),
        builder: (context, snapshot) {
          if (data == null &&
              snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (data == null && snapshot.hasData) {
            data = snapshot.data;
          }

          return ResultChart(
            data: data!,
            weightMeasurement: params.weightMeasurement,
          );
        },
      ),
      drawer: const NavDrawer(),
    );
  }
}

class ResultChart extends StatelessWidget {
  final List<ResultData> data;
  final Measurement weightMeasurement;
  const ResultChart({
    super.key,
    required this.data,
    required this.weightMeasurement,
  });

  @override
  Widget build(BuildContext context) {
    return DataTable2(
      columns: [
        const DataColumn(
          label: Center(child: Text("Week", textAlign: TextAlign.center)),
        ),
        const DataColumn(
          label: Center(child: Text("Date", textAlign: TextAlign.center)),
        ),
        DataColumn(
          label: Center(
              child: Text("Weight (${weightMeasurement.weightText})",
                  textAlign: TextAlign.center)),
        ),
        const DataColumn(
          label:
              Center(child: Text("Calories Used", textAlign: TextAlign.center)),
        ),
        const DataColumn(
          label: Center(child: Text("Deficit", textAlign: TextAlign.center)),
        )
      ],
      headingTextStyle: const TextStyle(fontSize: 13),
      dataTextStyle: const TextStyle(fontSize: 15),
      columnSpacing: 0,
      horizontalMargin: 0,
      dataRowHeight: 62,
      rows: List<DataRow>.generate(
        data.length,
        (index) {
          double weight = weightMeasurement == Measurement.imperial
              ? Converter.kgToPound(data[index].weight)
              : data[index].weight;
          String date = DateFormat("MM/dd/yyyy").format(data[index].date);

          return DataRow(
              color: MaterialStateProperty.resolveWith<Color?>(
                  (Set<MaterialState> states) {
                // All rows will have the same selected color.
                if (states.contains(MaterialState.selected)) {
                  return Theme.of(context)
                      .colorScheme
                      .primary
                      .withOpacity(0.08);
                }
                // Even rows will have a grey color.
                if (index.isEven) {
                  return Colors.grey.withOpacity(0.3);
                }
                return null; // Use default value for other states and odd rows.
              }),
              cells: [
                DataCell(
                  Center(
                    child: Text("${data[index].week}",
                        textAlign: TextAlign.center),
                  ),
                ),
                DataCell(
                  Center(
                    child: Text(date, textAlign: TextAlign.center),
                  ),
                ),
                DataCell(
                  Center(
                    child: Text(
                      weight.toStringAsFixed(2),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.yellow),
                    ),
                  ),
                ),
                DataCell(
                  Center(
                    child: Text(data[index].calsUsed.toStringAsFixed(2),
                        textAlign: TextAlign.center),
                  ),
                ),
                DataCell(
                  Center(
                    child: Text(data[index].deficit.toStringAsFixed(2),
                        textAlign: TextAlign.center),
                  ),
                ),
              ]);
        },
      ),
    );
  }
}
