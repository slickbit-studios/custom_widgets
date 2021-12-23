import 'package:custom_widgets/input/validator.dart';
import 'package:flutter/material.dart';

import 'dimensions.dart';

class DialogDropdownField<T> extends StatelessWidget {
  final bool editable;
  final T? value;
  final List<DropdownMenuItem<T>> items;
  final String label;
  final String? hint;
  final String? unit;
  final void Function(T? value)? onChanged;
  final Validator<T>? validator;

  const DialogDropdownField({
    Key? key,
    required this.editable,
    this.value,
    this.items = const [],
    required this.label,
    this.hint,
    this.unit,
    this.onChanged,
    this.validator,
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
              Expanded(flex: 1, child: Text(label)),
              Expanded(
                flex: 1,
                child: _ToggleEditDropdownField<T>(
                  editable: editable,
                  value: value,
                  items: items,
                  hint: hint,
                  onChanged: onChanged,
                  validator: validator,
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

class _ToggleEditDropdownField<T> extends StatelessWidget {
  final bool editable;
  final T? value;
  final List<DropdownMenuItem<T>> items;
  final String? hint;
  final void Function(T?)? onChanged;
  final Validator? validator;

  const _ToggleEditDropdownField({
    Key? key,
    required this.editable,
    this.value,
    this.onChanged,
    this.items = const [],
    this.validator,
    this.hint,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      decoration: InputDecoration.collapsed(hintText: hint),
      value: value,
      onChanged: editable ? onChanged : null,
      items: items,
      validator: validator?.validate,
    );
  }
}
