import 'package:flutter/material.dart';

class Utils {
  final BuildContext context;

  Utils(this.context);

  double getWidth() => MediaQuery.of(context).size.width;
  double getHeight() => MediaQuery.of(context).size.height;
}
