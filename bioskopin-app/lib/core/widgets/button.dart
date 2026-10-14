// Flutter imports:
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String label;
  final bool enabled;
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? borderColor;
  final double? borderRadius;
  final double? height;
  final double? width;
  final double? fontSize;
  final EdgeInsets? padding;

  const CustomButton({
    super.key,
    required this.label,
    this.enabled = true,
    required this.onPressed,
    this.backgroundColor,
    this.textColor,
    this.borderColor,
    this.borderRadius,
    this.height,
    this.width,
    this.fontSize,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final defaultWidth = width ?? MediaQuery.of(context).size.width;

    final buttonStyle = ElevatedButton.styleFrom(
      backgroundColor: enabled
          ? backgroundColor ?? Theme.of(context).primaryColor
          : Colors.grey,
      foregroundColor: enabled ? textColor ?? Colors.white : Colors.black,
      side: BorderSide(color: borderColor ?? Colors.transparent),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius ?? 8.0),
      ),
      fixedSize: Size(defaultWidth, height ?? 48.0),
      padding: padding ??
          const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      textStyle: TextStyle(fontFamily: 'Poppins', fontSize: fontSize ?? 16.0),
    );

    return ElevatedButton(
      style: buttonStyle,
      onPressed: enabled ? onPressed : null,
      child: Text(label),
    );
  }
}
