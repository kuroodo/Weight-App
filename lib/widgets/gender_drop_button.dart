import 'package:flutter/material.dart';
import 'package:weight_app/helpers/constants.dart';

class GenderDropButton extends StatefulWidget {
  final Gender? initialValue;
  final Function(Gender) onChanged;
  const GenderDropButton(
      {super.key, required this.onChanged, this.initialValue});

  @override
  State<GenderDropButton> createState() => _GenderDropButtonState();
}

class _GenderDropButtonState extends State<GenderDropButton> {
  late Gender _dropdownValue;
  @override
  void initState() {
    super.initState();
    _dropdownValue = widget.initialValue ?? Gender.male;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.grey[350]),
      child: DropdownButton<Gender>(
        value: _dropdownValue,
        dropdownColor: Colors.grey[350],
        icon: const Icon(
          Icons.arrow_drop_down,
          color: Colors.black,
        ),
        style: const TextStyle(color: Colors.black, fontSize: 20),
        selectedItemBuilder: (context) {
          return Gender.values
              .map((gender) => Container(
                    alignment: Alignment.center,
                    width: 100,
                    child: Text(
                      gender.name,
                      //textAlign: TextAlign.end,
                    ),
                  ))
              .toList();
        },
        items: Gender.values.map<DropdownMenuItem<Gender>>(
          (Gender value) {
            return DropdownMenuItem<Gender>(
              value: value,
              child: Text(value.name),
            );
          },
        ).toList(),
        onChanged: (Gender? value) {
          setState(() {
            _dropdownValue = value!;
          });
          widget.onChanged(value!);
        },
      ),
    );
  }
}
