import 'package:flutter/material.dart';
import 'package:weight_app/helpers/constants.dart';

class GenderDropButton extends StatefulWidget {
  final Function(Gender) onChanged;
  const GenderDropButton({super.key, required this.onChanged});

  @override
  State<GenderDropButton> createState() => _GenderDropButtonState();
}

class _GenderDropButtonState extends State<GenderDropButton> {
  Gender _dropdownValue = Gender.male;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.grey[350]),
      child: DropdownButton<Gender>(
        value: _dropdownValue,
        //alignment: Alignment.center,
        dropdownColor: Colors.grey[350],
        isExpanded: true,
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
