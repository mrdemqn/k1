import 'package:flutter/material.dart';

// Configuring ListView to remove GlowEffect
class BehaviorWithoutGlow extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}