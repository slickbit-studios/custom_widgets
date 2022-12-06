import 'package:custom_widgets/input/validator.dart';
import 'package:flutter/material.dart';

import 'dimensions.dart';

class DialogDropdownField<T> extends StatefulWidget {
  final bool editable;
  final double width;
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
    this.width = double.maxFinite,
    this.value,
    this.items = const [],
    required this.label,
    this.hint,
    this.unit,
    this.onChanged,
    this.validator,
  }) : super(key: key);

  @override
  State<DialogDropdownField<T>> createState() => _DialogDropdownFieldState<T>();
}

class _DialogDropdownFieldState<T> extends State<DialogDropdownField<T>> {
  final GlobalKey _globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.editable ? _openDropdown : null,
      child: Card(
        margin: EdgeInsets.zero,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        child: SizedBox(
          height: inputHeight,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(flex: 1, child: Text(widget.label)),
                SizedBox(
                  width: widget.width + 24,
                  child: DropdownButtonFormField<T>(
                    key: _globalKey,
                    decoration: InputDecoration.collapsed(
                      hintText: widget.hint,
                    ),
                    value: widget.value,
                    items: widget.items,
                    onChanged: widget.editable ? widget.onChanged : null,
                    validator: (value) =>
                        widget.validator?.validate(context, value),
                    icon: Icon(
                      Icons.arrow_drop_down,
                      color: widget.editable
                          ? Colors.black
                          : Theme.of(context).disabledColor,
                    ),
                  ),
                ),
                if (widget.unit != null)
                  Padding(
                    padding: const EdgeInsets.only(left: unitSpace),
                    child: Text(widget.unit!),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _openDropdown() {
    var actions = _findActionsChild(_globalKey.currentContext);

    if (actions != null) {
      Actions.invoke(actions, const ActivateIntent());
    }
  }

  Element? _findActionsChild(BuildContext? context) {
    Element? result;

    if (context == null) {
      return null;
    }

    if (context.widget is Actions) {
      // return CHILD of Actions Widget
      context.visitChildElements((element) => result = element);
      return result;
    }

    // search
    context.visitChildElements(
      (element) => result ??= _findActionsChild(element),
    );

    return result;
  }
}
