part of horizontal_bar_chart;

class HBCOptions {
  final double spaceBetweenBars;
  final double rightBorderRadius;
  final HorizontalChartBarsSort sort;
  final HBCGridOptions? grid;
  final HBCDataOptions? data;
  final HBCLabelOptions? label;
  final HBCIndicatorOptions? indicator;
  final double? maxValue;

  HBCOptions({
    this.spaceBetweenBars = 0,
    this.rightBorderRadius = 0,
    this.sort = HorizontalChartBarsSort.none,
    this.grid,
    this.data,
    this.label,
    this.indicator,
    this.maxValue,
  });
}
