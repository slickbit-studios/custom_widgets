import 'package:custom_widgets/input/validator.dart';
import 'package:flutter/material.dart';

import 'dimensions.dart';

class DialogTextField extends StatelessWidget {
  final bool editable;
  final String label;
  final String? hint;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final Validator<String>? validator;
  final String? unit;

  const DialogTextField({
    Key? key,
    required this.editable,
    required this.label,
    this.hint,
    required this.controller,
    this.keyboardType,
    this.validator,
    this.unit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      child: SizedBox(
        height: inputHeight,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(label),
              SizedBox(width: 12),
              Expanded(
                flex: 1,
                child: _ToggleEditTextField(
                  editable: editable,
                  controller: controller,
                  keyboardType: keyboardType,
                  validator: validator,
                  hint: hint,
                ),
              ),
              if (unit != null)
                Padding(
                  padding: const EdgeInsets.only(left: unitSpace),
                  child: Text(unit!),
                )
            ],
          ),
        ),
      ),
    );
  }
}

class _ToggleEditTextField extends StatelessWidget {
  final bool editable;
  final String? hint;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final Validator? validator;

  const _ToggleEditTextField({
    Key? key,
    required this.editable,
    this.hint,
    required this.controller,
    this.keyboardType,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (editable) {
      return Directionality(
        textDirection: TextDirection.rtl,
        child: TextFormField(
          decoration: InputDecoration.collapsed(hintText: hint),
          controller: controller,
          validator: (value) => validator?.validate(context, value),
          keyboardType: keyboardType,
        ),
      );
    } else {
      return Text(controller.text, textAlign: TextAlign.right);
    }
  }
}
