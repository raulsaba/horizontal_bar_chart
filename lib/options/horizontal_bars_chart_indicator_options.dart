part of horizontal_bar_chart;

class HBCIndicatorOptions {
  final bool showIndicator;
  final Color color;
  final double strokeWidth;
  final HBCIndicatorStyle style;

  /// The width of the indicator line as a percentage of the chart width, goes from 0 to 1.
  final double widthPercentage;

  HBCIndicatorOptions({
    this.showIndicator = false,
    this.color = Colors.red,
    this.style = HBCIndicatorStyle.dashed,
    this.widthPercentage = 0.5,
    this.strokeWidth = 1,
  }) : assert(
          widthPercentage >= 0 && widthPercentage <= 1,
          'The widthPercentage must be between 0 and 1',
        );
}
