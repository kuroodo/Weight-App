import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:weight_app/helpers/constants.dart';

class ActivityDropButton extends StatefulWidget {
  final Function(Activity) onChanged;
  const ActivityDropButton({super.key, required this.onChanged});

  @override
  State<ActivityDropButton> createState() => _ActivityDropButtonState();
}

class _ActivityDropButtonState extends State<ActivityDropButton> {
  Activity _dropdownValue = Activity.lightExercise;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.grey[350]),
      child: DropdownButton2<Activity>(
        isExpanded: true,
        value: _dropdownValue,
        alignment: Alignment.center,
        dropdownDecoration: BoxDecoration(color: Colors.grey[350]),
        icon: const Icon(
          Icons.arrow_drop_down,
          color: Colors.black,
        ),
        style: const TextStyle(color: Colors.black, fontSize: 18),
        selectedItemBuilder: (context) {
          return Activity.values
              .map((value) => Container(
                    alignment: Alignment.center,
                    child: Text(
                      value.text,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 14),
                    ),
                  ))
              .toList();
        },
        items: Activity.values.map<DropdownMenuItem<Activity>>(
          (Activity value) {
            return DropdownMenuItem<Activity>(
              value: value,
              child: Text(
                value.text,
                style: const TextStyle(
                  fontSize: 14,
                ),
              ),
            );
          },
        ).toList(),
        onChanged: (Activity? value) {
          setState(() {
            _dropdownValue = value!;
          });
          widget.onChanged(value!);
        },
      ),
    );
  }
}
