part of horizontal_bar_chart;

class VerticalGird extends _Grid {
  final double? step;

  VerticalGird({
    super.showGrid = false,
    super.strokeWidth = 1,
    this.step,
  });
}
