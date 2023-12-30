import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'dimensions.dart';

class DialogDatePicker extends StatelessWidget {
  final bool editable;
  final String label;
  final DateTime date;
  final DateTime firstDate;
  final DateTime lastDate;
  final void Function(DateTime value) onChanged;

  DialogDatePicker({
    super.key,
    this.editable = true,
    required this.label,
    DateTime? date,
    required this.onChanged,
    DateTime? firstDate,
    DateTime? lastDate,
  })  : date = date ?? DateTime.now(),
        firstDate = firstDate ?? DateTime(2020),
        lastDate = lastDate ?? DateTime(2199, 12, 31);

  @override
  Widget build(BuildContext context) {
    String dateString = _formatDate(date);

    return GestureDetector(
      onTap: editable ? () => _onTap(context) : null,
      child: Card(
        margin: EdgeInsets.zero,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        child: SizedBox(
          height: inputHeight,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(child: Text(label)),
                SizedBox(width: 12),
                Text(
                  dateString,
                  style: editable
                      ? TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold,
                        )
                      : null,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onTap(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: date,
      firstDate: firstDate,
      lastDate: lastDate,
    );

    if (picked != null) {
      var date = DateTime.utc(picked.year, picked.month, picked.day);
      onChanged(date);
    }
  }

  String _formatDate(DateTime date) {
    final DateFormat formatter = DateFormat('dd.MM.yyyy');
    return formatter.format(date);
  }
}
