import 'package:flutter/material.dart';

typedef Validator = String? Function(String?);

class DialogTextField extends StatelessWidget {
  final bool editable;
  final String label;
  final String? unit;
  final String? hint;
  final TextEditingController controller;
  final Validator? validator;

  const DialogTextField({
    Key? key,
    required this.editable,
    required this.label,
    required this.controller,
    this.validator,
    this.unit,
    this.hint,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      child: SizedBox(
        height: 48,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(flex: 1, child: Text(label)),
              Expanded(
                flex: 1,
                child: _ToggleEditTextField(
                    editable: editable,
                    controller: controller,
                    validator: validator,
                    hint: hint),
              ),
              if (unit != null)
                Padding(
                  padding: const EdgeInsets.only(left: 4),
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
  final TextEditingController controller;
  final Validator? validator;
  final String? hint;

  const _ToggleEditTextField({
    Key? key,
    required this.editable,
    required this.controller,
    this.validator,
    this.hint,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (editable) {
      return TextFormField(
        decoration: InputDecoration.collapsed(
          hintText: hint,
        ),
        textAlign: TextAlign.end,
        controller: controller,
        validator: validator,
      );
    } else {
      return Text(
        controller.text,
        textAlign: TextAlign.right,
      );
    }
  }
}
