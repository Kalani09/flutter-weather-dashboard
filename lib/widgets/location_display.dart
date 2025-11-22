import 'package:flutter/material.dart';

class LocationDisplay extends StatelessWidget {
  final String index;
  final double latitude;
  final double longitude;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? iconColor;

  const LocationDisplay({
    super.key,
    required this.index,
    required this.latitude,
    required this.longitude,
    this.backgroundColor,
    this.textColor,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: backgroundColor ?? Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.location_on,
            color: iconColor ?? Colors.blue,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              'Index: $index • Location: ${latitude.toStringAsFixed(2)}, ${longitude.toStringAsFixed(2)}',
              style: TextStyle(
                color: textColor ?? Colors.blue,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}