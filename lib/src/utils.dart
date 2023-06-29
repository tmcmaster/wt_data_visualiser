import 'package:flutter/material.dart';

extension ColorUtil on Color {
  Color byLuminance() => computeLuminance() > 0.4 ? Colors.black87 : Colors.white;
}
