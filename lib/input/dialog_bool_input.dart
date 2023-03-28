import 'package:flutter/material.dart';

import 'dimensions.dart';

class DialogBoolInput extends StatelessWidget {
  final bool editable;
  final String label;
  final bool value;
  final void Function(bool) onChanged;
  final Widget? help;

  const DialogBoolInput({
    Key? key,
    this.editable = true,
    required this.label,
    required this.value,
    required this.onChanged,
    this.help,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: editable ? _onTap : null,
      child: Card(
        margin: EdgeInsets.zero,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        child: InkWell(
          onTap: () => onChanged(!value),
          child: SizedBox(
            height: inputHeight,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(label),
                  if (help != null) SizedBox(width: 4),
                  if (help != null) help!,
                  Expanded(child: SizedBox()),
                  Switch(value: value, onChanged: editable ? onChanged : null),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onTap() {
    if (editable) {
      onChanged(!value);
    }
  }
}
