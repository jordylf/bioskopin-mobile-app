// Flutter imports:
import 'package:flutter/material.dart';

class CustomInputPassword extends StatefulWidget {
  final String? label;
  final TextStyle? labelStyle;
  final TextEditingController controller;
  final bool? enabled;
  final bool? filled;
  final Color? fillColor;
  final String? hint;
  final EdgeInsets? contentPadding;
  final String? Function(String?)? validator;

  const CustomInputPassword({
    super.key,
    this.label,
    this.labelStyle,
    required this.controller,
    this.enabled,
    this.filled,
    this.fillColor,
    this.hint,
    this.contentPadding,
    this.validator,
  });

  @override
  State<CustomInputPassword> createState() => _CustomInputPasswordState();
}

class _CustomInputPasswordState extends State<CustomInputPassword> {
  bool obsecureText = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null)
          Text(
            widget.label ?? '',
            style: widget.labelStyle ??
                const TextStyle(
                  color: Colors.black,
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                ),
          ),
        if (widget.label != null) const SizedBox(height: 5.0),
        TextFormField(
          controller: widget.controller,
          decoration: InputDecoration(
            enabled: true,
            filled: widget.filled ?? true,
            fillColor: widget.fillColor ?? Colors.white,
            hintText: widget.hint ?? 'Masukkan ${widget.label}',
            hintStyle: TextStyle(
              color: Colors.black.withValues(alpha: 0.5),
              fontSize: 14.0,
            ),
            contentPadding: widget.contentPadding ?? const EdgeInsets.all(10.0),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Color(0XFFD6D6D6),
                width: 2.0,
              ),
              borderRadius: BorderRadius.circular(10.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
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
            suffixIcon: IconButton(
              icon:
                  Icon(obsecureText ? Icons.visibility : Icons.visibility_off),
              onPressed: () {
                setState(() {
                  obsecureText = !obsecureText;
                });
              },
            ),
          ),
          style: const TextStyle(
            color: Colors.black,
            fontSize: 14.0,
          ),
          validator: widget.validator,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          obscureText: obsecureText,
        ),
      ],
    );
  }
}
