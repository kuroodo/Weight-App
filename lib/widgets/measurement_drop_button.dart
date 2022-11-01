import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:weight_app/helpers/constants.dart';

class MeasurementDropButton extends StatefulWidget {
  final bool isWeight;
  final Function(Measurement) onChanged;
  const MeasurementDropButton({
    super.key,
    required this.isWeight,
    required this.onChanged,
  });

  @override
  State<MeasurementDropButton> createState() => _MeasurementDropButtonState();
}

class _MeasurementDropButtonState extends State<MeasurementDropButton> {
  Measurement _dropdownValue = Measurement.imperial;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.grey[350]),
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: DropdownButton2<Measurement>(
        value: _dropdownValue,
        alignment: Alignment.centerRight,
        dropdownDecoration: BoxDecoration(color: Colors.grey[350]),
        dropdownWidth: 80,
        isExpanded: true,
        icon: const Icon(
          Icons.arrow_drop_down,
          color: Colors.black,
        ),
        style: const TextStyle(color: Colors.black, fontSize: 18),
        selectedItemBuilder: (context) {
          return Measurement.values
              .map((value) => Container(
                    alignment: Alignment.center,
                    width: 100,
                    child: Text(
                      widget.isWeight ? value.weightText : value.heightText,
                      textAlign: TextAlign.end,
                    ),
                  ))
              .toList();
        },
        items: Measurement.values.map<DropdownMenuItem<Measurement>>(
          (Measurement value) {
            return DropdownMenuItem<Measurement>(
              value: value,
              child:
                  Text(widget.isWeight ? value.weightText : value.heightText),
            );
          },
        ).toList(),
        onChanged: (Measurement? value) {
          setState(() {
            _dropdownValue = value!;
          });
          widget.onChanged(value!);
        },
      ),
    );
  }
}
