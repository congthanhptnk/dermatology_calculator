import 'package:dental_calculator/theme.dart';
import 'package:dental_calculator/translations.i18n.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';

class CustomInputFieldStyle {
  final TextStyle? customLabelStyle;
  final TextStyle? customInputStyle;
  final TextStyle? customHintStyle;
  final TextStyle? customHelperTextStyle;
  final Color? fillColor;

  const CustomInputFieldStyle({
    this.customLabelStyle,
    this.customHintStyle,
    this.fillColor,
    this.customInputStyle,
    this.customHelperTextStyle,
  });
}

class InputField extends StatefulWidget {
  final String? label;
  final TextInputType keyboardType;
  final ValueChanged<String>? onSubmitted;
  final FormFieldValidator<String>? validator;
  final TextInputAction textInputAction;
  final String? initialValue;
  final bool autofocus;
  final Function(String)? onChanged;
  final String? hintText;
  final TextCapitalization textCapitalization;
  final Iterable<String>? autofillHints;
  final FocusNode? focusNode;
  final String? helperText;
  final Function? onEditingComplete;
  final List<TextInputFormatter>? inputFormatters;
  final TextEditingController? controller;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final int maxLines;
  final int minLines;
  final String? placeHolder;
  final Color? colorBorderInActive;
  final bool isDense;
  final bool enabled;
  final bool autocorrect;
  final CustomInputFieldStyle? customInputFieldStyle;

  const InputField({
    Key? key,
    this.label,
    this.focusNode,
    this.onSubmitted,
    this.validator,
    this.onChanged,
    this.initialValue,
    this.autofocus = false,
    this.hintText,
    this.textInputAction = TextInputAction.next,
    this.keyboardType = TextInputType.text,
    this.textCapitalization = TextCapitalization.none,
    this.autofillHints,
    this.helperText,
    this.onEditingComplete,
    this.inputFormatters,
    this.controller,
    this.suffixIcon,
    this.prefixIcon,
    this.maxLines = 1,
    this.minLines = 1,
    this.placeHolder,
    this.colorBorderInActive,
    this.isDense = true,
    this.enabled = true,
    this.autocorrect = true,
    this.customInputFieldStyle,
  }) : super(key: key);

  @override
  _InputFieldState createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  final OutlineInputBorder _fieldBorder = OutlineInputBorder(borderRadius: BorderRadius.circular(8));

  final Color _activeColor = GrayLightColor.s900;
  final Color _inActiveColor = GrayLightColor.s500;
  bool _isActive = false;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        primaryColor: BlueLightColor.s500,
        hintColor: _isActive ? _activeColor : _inActiveColor,
        disabledColor: GrayLightColor.s200,
        colorScheme: const ColorScheme.light()
            .copyWith(
              primary: BlueLightColor.s500,
              secondary: GrayLightColor.s200,
            )
            .copyWith(error: ErrorColor.s500),
      ),
      child: Builder(
        builder: (context) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (widget.label != null && widget.label!.isNotEmpty) ...[
                Text(
                  widget.label!,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                if (widget.helperText == null) const Gap(4),
              ],
              if (widget.helperText != null && widget.helperText!.isNotEmpty) ...[
                Text(
                  widget.helperText!,
                  style: Theme.of(context).textTheme.labelSmall,
                ),
                const Gap(4),
              ],
              TextFormField(
                enabled: widget.enabled,
                textCapitalization: widget.textCapitalization,
                onFieldSubmitted: widget.onSubmitted,
                enableSuggestions: true,
                autocorrect: widget.autocorrect,
                controller: widget.controller,
                inputFormatters: widget.inputFormatters,
                initialValue: widget.initialValue,
                keyboardType: widget.keyboardType,
                style: Theme.of(context).textTheme.bodyLarge,
                autofillHints: widget.autofillHints,
                textInputAction: widget.textInputAction,
                validator: widget.validator,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                autofocus: widget.autofocus,
                focusNode: widget.focusNode,
                minLines: widget.minLines,
                maxLines: widget.maxLines,
                onEditingComplete: () {
                  widget.onEditingComplete?.call();
                },
                onChanged: (value) {
                  if (widget.onChanged != null) {
                    widget.onChanged!(value);
                  }
                  if (value.trim().isNotEmpty) {
                    setState(() {
                      _isActive = true;
                    });
                  } else {
                    setState(() {
                      _isActive = false;
                    });
                  }
                },
                decoration: getInputDecoration(context),
              ),
            ],
          );
        },
      ),
    );
  }

  InputDecoration getInputDecoration(BuildContext context) {
    return InputDecoration(
      hintText: 'Enter'.i18n,
      hintStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(color: GrayLightColor.s300),
      alignLabelWithHint: true,
      isDense: widget.isDense,
      fillColor: Colors.white,
      filled: true,
      contentPadding: const EdgeInsets.only(
        left: 12,
        top: 16,
        bottom: 16,
      ),
      errorStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(color: ErrorColor.s500),
      helperStyle: Theme.of(context).textTheme.bodyLarge,
      enabledBorder: _fieldBorder.copyWith(
          borderSide:
              BorderSide(color: _isActive ? _activeColor : widget.colorBorderInActive ?? _inActiveColor, width: 1.5)),
      border: _fieldBorder,
      focusedBorder: _fieldBorder.copyWith(
        borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1.5),
      ),
      focusedErrorBorder: _fieldBorder.copyWith(
        borderSide: const BorderSide(color: ErrorColor.s600, width: 1.5),
      ),
      errorBorder: _fieldBorder.copyWith(
        borderSide: const BorderSide(color: ErrorColor.s600, width: 1.5),
      ),
      suffixIcon: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        child: widget.suffixIcon,
      ),
      prefixIcon: widget.prefixIcon,
      suffixIconConstraints: const BoxConstraints(
        minWidth: 16,
        minHeight: 16,
      ),
    );
  }
}
