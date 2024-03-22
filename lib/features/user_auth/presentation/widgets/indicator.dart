import 'package:flutter/material.dart';

class Indicator extends StatelessWidget {
  const Indicator({
    super.key,
    required this.color,
    required this.text,
    required this.isSquare,
    this.size = 16,
    this.textColor = Colors.black, // Default text color set to black
    this.fontSize = 16,
    this.fontWeight = FontWeight.bold,
    this.spacing = 4.0, // Default spacing between icon and text
    this.borderRadius = 0.0, // Default borderRadius, relevant only if isSquare is true
  });

  final Color color;
  final String text;
  final bool isSquare;
  final double size;
  final Color textColor;
  final double fontSize;
  final FontWeight fontWeight;
  final double spacing;
  final double borderRadius; // Used only if isSquare is true

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: isSquare ? BoxShape.rectangle : BoxShape.circle,
            color: color,
            borderRadius: isSquare ? BorderRadius.circular(borderRadius) : null,
          ),
        ),
        SizedBox(
          width: spacing,
        ),
        Text(
          text,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: fontWeight,
            color: textColor,
          ),
        ),
      ],
    );
  }
}
