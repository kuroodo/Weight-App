import 'package:flutter/material.dart';

class StyledFormField extends StatelessWidget {
  final String keyName;
  final TextInputType? keyBoardType;
  final void Function(String) onSave;

  final String? Function(String?)? onValidate;

  const StyledFormField({
    Key? key,
    required this.keyName,
    required this.onSave,
    this.onValidate,
    this.keyBoardType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.grey[350]),
      child: TextFormField(
        key: ValueKey(keyName),
        autocorrect: false,
        textAlign: TextAlign.center,
        style: const TextStyle(color: Colors.black, fontSize: 20),
        textCapitalization: TextCapitalization.none,
        keyboardType: keyBoardType,
        onSaved: (value) => onSave(value!),
        validator: onValidate,
      ),
    );
  }
}
