part of horizontal_bar_chart;

abstract class _AxisLabels {
  final bool show;
  final TextStyle? textStyle;
  final double? step;

  _AxisLabels({
    required this.show,
    this.textStyle,
    this.step,
  });
}
