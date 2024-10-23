part of horizontal_bar_chart;

class AxisXLabels extends _AxisLabels {
  final double? height;
  final String Function(double value)? getLabelString;
  final TextSpan Function(double value)? getLabelTextSpan;

  AxisXLabels({
    super.show = false,
    super.textStyle,
    super.step,
    this.getLabelString,
    this.getLabelTextSpan,
    this.height,
  });
}
