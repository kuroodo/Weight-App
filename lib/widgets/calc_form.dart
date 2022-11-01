import 'package:flutter/material.dart';
import 'package:weight_app/helpers/constants.dart';
import 'package:weight_app/helpers/converter.dart' as converter;
import 'package:weight_app/models/calc_params.dart';
import 'package:weight_app/models/weight_data.dart';
import 'package:weight_app/widgets/activity_drop_button.dart';
import 'package:weight_app/widgets/calc_form/styled_form_field.dart';
import 'package:weight_app/widgets/gender_drop_button.dart';
import 'package:weight_app/widgets/measurement_drop_button.dart';

class CalcForm extends StatefulWidget {
  const CalcForm({super.key});

  @override
  State<CalcForm> createState() => _CalcFormState();
}

class _CalcFormState extends State<CalcForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Measurement _weightMeasure = Measurement.imperial;
  Measurement _heightMeasure = Measurement.imperial;
  Activity _activity = Activity.lightExercise;
  Gender _gender = Gender.male;
  double _weight = 0;
  double _height = 0;
  double _cals = 0;
  int _age = 0;

  @override
  Widget build(BuildContext context) {
    const double spacing = 14;
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Gender
          Row(
            children: [
              const _ConstrainedText(text: "Select Gender"),
              Expanded(
                flex: 1,
                child: GenderDropButton(
                  onChanged: (gender) => _gender = gender,
                ),
              ),
              const Expanded(flex: 2, child: SizedBox.shrink()),
            ],
          ),
          const SizedBox(height: spacing),

          _FormRow(
            label: "Weight",
            keyName: "w",
            isWeight: true,
            onSave: (w) => _weight = double.parse(w),
            onValidate: _validateDouble,
            onDropDownChange: (val) => _weightMeasure = val,
          ),
          const SizedBox(height: spacing),
          _FormRow(
            label: "Height",
            keyName: "h",
            isWeight: false,
            onSave: (h) => _height = double.parse(h),
            onValidate: _validateDouble,
            onDropDownChange: (val) => _heightMeasure = val,
          ),
          const SizedBox(height: spacing),

          Row(
            children: [
              const _ConstrainedText(text: "Age"),
              Expanded(
                child: StyledFormField(
                  keyName: "a",
                  keyBoardType: TextInputType.number,
                  onSave: (age) => _age = int.parse(age),
                  onValidate: _validateInt,
                ),
              ),
              const Expanded(flex: 2, child: SizedBox.shrink())
            ],
          ),
          const SizedBox(height: spacing + 14),

          Row(
            children: [
              const _ConstrainedText(text: "Calories To Eat Per Day"),
              Expanded(
                child: StyledFormField(
                  keyName: "c",
                  keyBoardType: TextInputType.number,
                  onSave: (cals) => _cals = double.parse(cals),
                  onValidate: _validateInt,
                ),
              ),
            ],
          ),
          const SizedBox(height: spacing),

          Row(
            children: [
              const _ConstrainedText(text: "How active are you?"),
              Expanded(
                child: ActivityDropButton(
                  onChanged: (activity) => _activity = activity,
                ),
              ),
            ],
          ),
          const SizedBox(height: spacing * 2),

          // Submit
          ElevatedButton(
            onPressed: _trySubmit,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 99, 135, 152),
              minimumSize: const Size(100, 50),
            ),
            child: const Text(
              "Submit",
              style: TextStyle(fontSize: 16),
            ),
          )
        ],
      ),
    );
  }

  void _trySubmit() {
    final bool isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (!isValid) return;
    _formKey.currentState!.save();
    _onSubmit();
  }

  void _onSubmit() {
    final double weight = _weightMeasure == Measurement.imperial
        ? converter.poundToKg(_weight)
        : _weight;
    final double height = _heightMeasure == Measurement.imperial
        ? converter.inchToCm(_height)
        : _height;
    Navigator.of(context).popAndPushNamed(
      "result_screen",
      arguments: CalcParams(
        weightData: WeightData(
          age: _age.toDouble(),
          weight: weight,
          height: height,
          isMale: _gender == Gender.male,
        ),
        activity: _activity,
        calorieIntake: _cals,
        heightMeasurement: _heightMeasure,
        weightMeasurement: _weightMeasure,
      ),
    );
  }

  String? _validateDouble(val) {
    if (val == null || double.tryParse(val) == null) {
      return "Please enter a valid number";
    }
    return null;
  }

  String? _validateInt(val) {
    if (val == null || int.tryParse(val) == null) {
      return "Please enter a valid number";
    }
    return null;
  }
}

class _FormRow extends StatelessWidget {
  final String label;
  final String keyName;
  final bool isWeight;
  final Function(Measurement) onDropDownChange;
  final Function(String) onSave;
  final String? Function(String?) onValidate;
  const _FormRow({
    required this.label,
    required this.keyName,
    required this.isWeight,
    required this.onSave,
    required this.onValidate,
    required this.onDropDownChange,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _ConstrainedText(text: label),
        Expanded(
          flex: 3,
          child: StyledFormField(
            keyName: keyName,
            keyBoardType: TextInputType.number,
            onSave: onSave,
            onValidate: onValidate,
          ),
        ),
        Expanded(
          flex: 2,
          child: FractionallySizedBox(
            widthFactor: .7,
            child: MeasurementDropButton(
              onChanged: onDropDownChange,
              isWeight: isWeight,
            ),
          ),
        ),
      ],
    );
  }
}

class _ConstrainedText extends StatelessWidget {
  final String text;
  const _ConstrainedText({required this.text});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(minWidth: 135, maxWidth: 135),
      child: Text(text, style: const TextStyle(fontSize: 18)),
    );
  }
}
