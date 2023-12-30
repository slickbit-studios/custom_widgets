import 'package:flutter/material.dart';

import 'dimensions.dart';

class DialogBoolInput extends StatelessWidget {
  final bool editable;
  final String label;
  final bool value;
  final void Function(bool) onChanged;
  final Widget? help;

  const DialogBoolInput({
    super.key,
    this.editable = true,
    required this.label,
    required this.value,
    required this.onChanged,
    this.help,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      child: InkWell(
        onTap: editable ? () => onChanged(!value) : null,
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
    );
  }
}
