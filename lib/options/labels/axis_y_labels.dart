part of horizontal_bar_chart;

class AxisYLabels extends _AxisLabels {
  final double? width;
  final String Function(String value)? getLabelString;
  final TextSpan Function(String value)? getLabelTextSpan;
  AxisYLabels({
    super.show = false,
    super.textStyle,
    super.step,
    this.getLabelString,
    this.getLabelTextSpan,
    this.width,
  });
}
