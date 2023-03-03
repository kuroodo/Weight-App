import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weight_app/helpers/constants.dart';
import 'package:weight_app/providers/form_data_provider.dart';
import 'package:weight_app/widgets/activity_drop_button.dart';
import 'package:weight_app/widgets/calc_form/styled_form_field.dart';
import 'package:weight_app/widgets/gender_drop_button.dart';
import 'package:weight_app/widgets/measurement_drop_button.dart';

const double _formWidth = 150;

class CalcForm extends ConsumerStatefulWidget {
  const CalcForm({super.key});

  @override
  ConsumerState<CalcForm> createState() => _CalcFormState();
}

class _CalcFormState extends ConsumerState<CalcForm> {
  late final FormData? _formData;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Measurement _weightMeasure = Measurement.imperial;
  Measurement _heightMeasure = Measurement.imperial;
  Activity _activity = Activity.lightExercise;
  Gender _gender = Gender.male;
  double _weight = 0;
  double _height = 0;
  double _cals = 0;
  int _age = 0;

  bool _showInitialValues = false;

  @override
  void initState() {
    super.initState();
    _formData = ref.read(formDataProvider);
    if (_formData == null) return;
    _weightMeasure = _formData!.weightMeasurement;
    _heightMeasure = _formData!.heightMeasurement;
    _activity = _formData!.activity;
    _gender = _formData!.gender;
    _weight = _formData!.weight;
    _height = _formData!.height;
    _cals = _formData!.cals;
    _age = _formData!.age;
    _showInitialValues = true;
  }

  @override
  Widget build(BuildContext context) {
    const double columnSpacing = 14;
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Gender
          Row(
            children: [
              const _ConstrainedText(text: "Gender"),
              GenderDropButton(
                initialValue: _gender,
                onChanged: (gender) => _gender = gender,
              ),
            ],
          ),
          const SizedBox(height: columnSpacing),

          _FormRow(
            label: "Weight",
            keyName: "w",
            initialFormValue: _showInitialValues ? _weight.toString() : null,
            initialDropDownValue: _weightMeasure,
            isWeight: true,
            onSave: (w) => _weight = double.parse(w),
            onValidate: _validateDouble,
            onDropDownChange: (val) => _weightMeasure = val,
          ),
          const SizedBox(height: columnSpacing),
          _FormRow(
            label: "Height",
            keyName: "h",
            initialFormValue: _showInitialValues ? _height.toString() : null,
            initialDropDownValue: _heightMeasure,
            isWeight: false,
            onSave: (h) => _height = double.parse(h),
            onValidate: _validateDouble,
            onDropDownChange: (val) => _heightMeasure = val,
          ),
          const SizedBox(height: columnSpacing),

          Row(
            children: [
              const _ConstrainedText(text: "Age"),
              Flexible(
                fit: FlexFit.loose,
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: _formWidth),
                  child: StyledFormField(
                    keyName: "a",
                    initialValue: _showInitialValues ? _age.toString() : null,
                    keyBoardType: TextInputType.number,
                    onSave: (age) => _age = int.parse(age),
                    onValidate: _validateInt,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: columnSpacing),

          Row(
            children: [
              const _ConstrainedText(text: "Calories To Eat Per Day"),
              Flexible(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: _formWidth),
                  child: StyledFormField(
                    keyName: "c",
                    initialValue: _showInitialValues ? _cals.toString() : null,
                    keyBoardType: TextInputType.number,
                    onSave: (cals) => _cals = double.parse(cals),
                    onValidate: _validateDouble,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: columnSpacing),

          Row(
            children: [
              const _ConstrainedText(text: "How active are you?"),
              Flexible(
                fit: FlexFit.loose,
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 325),
                  child: ActivityDropButton(
                    initialValue: _activity,
                    onChanged: (activity) => _activity = activity,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: columnSpacing * 2),

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
    ref.read(formDataProvider.notifier).state = FormData(
      weightMeasurement: _weightMeasure,
      heightMeasurement: _heightMeasure,
      activity: _activity,
      age: _age,
      cals: _cals,
      gender: _gender,
      height: _height,
      weight: _weight,
    );

    Navigator.of(context).pushNamed("result_screen");
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
  final String? initialFormValue;
  final Measurement? initialDropDownValue;
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
    this.initialFormValue,
    this.initialDropDownValue,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _ConstrainedText(text: label),
        Flexible(
          fit: FlexFit.loose,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: _formWidth),
            child: StyledFormField(
              keyName: keyName,
              keyBoardType: TextInputType.number,
              initialValue: initialFormValue,
              onSave: onSave,
              onValidate: onValidate,
            ),
          ),
        ),
        const SizedBox(width: 16),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 100),
          child: MeasurementDropButton(
            onChanged: onDropDownChange,
            isWeight: isWeight,
            initialValue: initialDropDownValue,
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
