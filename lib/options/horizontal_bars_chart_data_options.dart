import 'package:flutter/material.dart';

import '../horizontal_bar_chart.dart';

class HBCDataOptions {
  final bool showData;
  final String Function(HBCData data)? getDataString;
  final TextStyle? dataTextStyle;
  final TextSpan Function(HBCData data)? getDataTextSpan;

  HBCDataOptions({
    this.showData = false,
    this.getDataString,
    this.dataTextStyle,
    this.getDataTextSpan,
  });
}
