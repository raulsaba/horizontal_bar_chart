part of horizontal_bar_chart;

class HorizontalGrid extends _Grid {
  final double? step;

  HorizontalGrid({
    super.showGrid = false,
    super.strokeWidth = 1,
    this.step,
  });
}
