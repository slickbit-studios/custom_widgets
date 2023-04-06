import 'package:custom_widgets/input/validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'dimensions.dart';

class DialogTextField extends StatefulWidget {
  final bool editable;
  final String label;
  final String? hint;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final Validator<String>? validator;
  final String? unit;
  final bool autofocus;
  final List<TextInputFormatter>? inputFormatters;

  const DialogTextField({
    Key? key,
    this.editable = true,
    required this.label,
    this.hint,
    required this.controller,
    this.keyboardType,
    this.validator,
    this.unit,
    this.autofocus = false,
    this.inputFormatters,
  }) : super(key: key);

  @override
  State<DialogTextField> createState() => _DialogTextFieldState();
}

class _DialogTextFieldState extends State<DialogTextField> {
  late FocusNode _focus;

  @override
  void initState() {
    super.initState();

    _focus = FocusNode();
  }

  @override
  void dispose() {
    _focus.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.editable ? () => _focus.requestFocus() : null,
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
                Text(widget.label),
                SizedBox(width: 12),
                Expanded(
                  flex: 1,
                  child: _ToggleEditTextField(
                    editable: widget.editable,
                    controller: widget.controller,
                    keyboardType: widget.keyboardType,
                    validator: widget.validator,
                    hint: widget.hint,
                    autofocus: widget.autofocus,
                    focus: _focus,
                    inputFormatters: widget.inputFormatters,
                  ),
                ),
                if (widget.unit != null)
                  Padding(
                    padding: const EdgeInsets.only(left: unitSpace),
                    child: Text(widget.unit!),
                  )
              ],
            ),
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
  final bool autofocus;
  final FocusNode focus;
  final List<TextInputFormatter>? inputFormatters;

  const _ToggleEditTextField({
    Key? key,
    required this.editable,
    this.hint,
    required this.controller,
    this.keyboardType,
    this.validator,
    this.autofocus = false,
    required this.focus,
    this.inputFormatters,
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
          autofocus: autofocus,
          focusNode: focus,
          inputFormatters: inputFormatters,
        ),
      );
    } else {
      return Text(controller.text, textAlign: TextAlign.right);
    }
  }
}
