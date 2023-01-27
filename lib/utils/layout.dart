import 'package:flutter/material.dart';

bool useMobileLayout(context) {
  var shortestSide = MediaQuery.of(context).size.shortestSide;
  final bool mobile = shortestSide < 600;
  return mobile;
}
