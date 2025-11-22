import 'package:flutter/material.dart';

class WeatherDetailItem extends StatelessWidget {
  final String label;
  final String value;
  final CrossAxisAlignment alignment;
  final Color? labelColor;
  final Color? valueColor;
  final double? labelFontSize;
  final double? valueFontSize;

  const WeatherDetailItem({
    super.key,
    required this.label,
    required this.value,
    this.alignment = CrossAxisAlignment.start,
    this.labelColor,
    this.valueColor,
    this.labelFontSize,
    this.valueFontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: alignment,
      children: [
        Text(
          label,
          style: TextStyle(
            color: labelColor ?? Colors.black54,
            fontSize: labelFontSize ?? 16,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: valueFontSize ?? 20,
            fontWeight: FontWeight.bold,
            color: valueColor ?? Colors.black87,
          ),
        ),
      ],
    );
  }
}