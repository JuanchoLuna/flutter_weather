import 'package:flutter/material.dart';
import 'package:weather_ui/weather_ui.dart';

extension ScreenMeasurements on BuildContext {
  double get screenHeight => MediaQuery.of(this).size.height;
  double get screenWidth => MediaQuery.of(this).size.width;
  bool get isMobile =>
      MediaQuery.of(this).size.width <= tabletMaxWidthBreakpoint;
  bool get isDesktop =>
      MediaQuery.of(this).size.width > tabletMaxWidthBreakpoint;
}
