// Flutter imports:
import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {
  final String? label;
  final TextStyle? labelStyle;
  final TextEditingController? controller;
  final bool? enabled;
  final bool? filled;
  final Color? fillColor;
  final String? hint;
  final EdgeInsets? contentPadding;
  final bool? isSearch;
  final String? Function(String?)? validator;
  final TextInputType? inputType;
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;

  const CustomInput({
    super.key,
    this.label,
    this.labelStyle,
    this.controller,
    this.enabled,
    this.filled,
    this.fillColor,
    this.hint,
    this.contentPadding,
    this.isSearch,
    this.validator,
    this.inputType,
    this.onChanged,
    this.onSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null)
          Text(
            label ?? '',
            style: labelStyle ??
                const TextStyle(
                  color: Colors.black,
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                ),
          ),
        if (label != null) const SizedBox(height: 5.0),
        TextFormField(
          controller: controller ?? TextEditingController(),
          decoration: InputDecoration(
            enabled: enabled ?? true,
            filled: filled ?? true,
            fillColor: fillColor ?? Colors.white,
            hintText: hint ?? 'Masukkan $label',
            hintStyle: TextStyle(
              color: Colors.black.withValues(alpha: 0.5),
              fontSize: 14.0,
            ),
            suffixIcon: isSearch == true ? const Icon(Icons.search) : null,
            contentPadding: contentPadding ?? const EdgeInsets.all(10.0),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Color(0XFFD6D6D6),
                width: 2.0,
              ),
              borderRadius: BorderRadius.circular(10.0),
            ),
            disabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Color(0XFFD6D6D6),
                width: 2.0,
              ),
              borderRadius: BorderRadius.circular(10.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Color(0xFF277FBF),
                width: 2.0,
              ),
              borderRadius: BorderRadius.circular(10.0),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Color(0XFFB71B1B),
                width: 2.0,
              ),
              borderRadius: BorderRadius.circular(10.0),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Color(0XFFB71B1B),
                width: 2.0,
              ),
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          style: const TextStyle(
            color: Colors.black,
            fontSize: 14.0,
          ),
          validator: validator,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          keyboardType: inputType,
          textInputAction: isSearch == true ? TextInputAction.search : null,
          onChanged: onChanged,
          onFieldSubmitted: onSubmitted,
        ),
      ],
    );
  }
}
