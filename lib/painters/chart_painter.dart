part of horizontal_bar_chart;

class ChartPainter extends CustomPainter {
  final List<HBCData> data;
  final HBCOptions options;
  final BuildContext context;

  ChartPainter({
    super.repaint,
    required this.context,
    required this.options,
    required this.data,
  });

  Color get gridColor => options.grid?.gridColor ?? Colors.grey;

  BorderGrid get borderGrid => options.grid?.borderGrid ?? BorderGrid();
  VerticalGird get verticalGird => options.grid?.verticalGird ?? VerticalGird();
  HorizontalGrid get horizontalGird => options.grid?.horizontalGird ?? HorizontalGrid();
  HBCIndicatorOptions get indicatorOptions => options.indicator ?? HBCIndicatorOptions();
  HBCDataOptions get dataOptions => options.data ?? HBCDataOptions();
  AxisXLabels get axisXLabels => options.label?.axisXLabels ?? AxisXLabels();
  AxisYLabels get axisYLabels => options.label?.axisYLabels ?? AxisYLabels();

  @override
  void paint(Canvas canvas, Size size) {
    double yLabelsWidth = axisYLabels.show ? axisYLabels.width ?? size.width * 0.2 : 0;
    double xLabelsHeight = axisXLabels.show ? axisXLabels.height ?? size.height * 0.1 : 0;
    Size chartSize = Size(size.width - yLabelsWidth, size.height - xLabelsHeight);

    if (axisYLabels.show) {
      for (HBCData d in data) {
        final TextSpan span = TextSpan(
          style: axisYLabels.textStyle ?? Theme.of(context).textTheme.bodyMedium,
          text: axisYLabels.getLabelString != null ? axisYLabels.getLabelString!(d.name) : d.name,
        );
        final TextPainter tp = TextPainter(
          text: axisYLabels.getLabelTextSpan != null ? axisYLabels.getLabelTextSpan!(d.name) : span,
          textDirection: TextDirection.rtl,
          textAlign: TextAlign.end,
        );
        final double barWidth = chartSize.width * d.value / maxValue;
        final double barHeight = (chartSize.height - (data.length + 1) * options.spaceBetweenBars) / data.length;
        final Rect rect = Rect.fromLTWH(
          yLabelsWidth,
          data.indexOf(d) * barHeight + data.indexOf(d) * options.spaceBetweenBars + options.spaceBetweenBars,
          barWidth,
          barHeight,
        );
        tp.layout();
        double tpDx = yLabelsWidth - tp.width - 8;
        tp.paint(
          canvas,
          Offset(
            tpDx,
            rect.center.dy - tp.height / 2,
          ),
        );
      }
    }

    if (axisXLabels.show) {
      for (int i = 0; i < 11; i++) {
        double value = (maxValue / 10 * i);
        final TextSpan span = TextSpan(
          style: axisXLabels.textStyle ?? Theme.of(context).textTheme.bodyMedium,
          text: axisXLabels.getLabelString != null ? axisXLabels.getLabelString!(value) : value.toStringAsFixed(2),
        );

        final TextPainter tp = TextPainter(
          text: axisXLabels.getLabelTextSpan != null ? axisXLabels.getLabelTextSpan!(value) : span,
          textDirection: TextDirection.ltr,
          textAlign: TextAlign.center,
        );
        tp.layout();
        tp.paint(
          canvas,
          Offset(
            yLabelsWidth + chartSize.width / (axisXLabels.step ?? 10) * i - tp.width / 2,
            size.height - xLabelsHeight + 8,
          ),
        );
      }
    }

    if (borderGrid.left?.showGrid == true) {
      _paintLeftGrid(canvas, size, yLabelsWidth, xLabelsHeight);
    }
    if (borderGrid.top?.showGrid == true) {
      _paintTopGrid(canvas, size, yLabelsWidth, xLabelsHeight);
    }
    if (borderGrid.right?.showGrid == true) {
      _paintRightGrid(canvas, size, yLabelsWidth, xLabelsHeight);
    }
    if (borderGrid.bottom?.showGrid == true) {
      _paintBottomGrid(canvas, size, yLabelsWidth, xLabelsHeight);
    }
    if (verticalGird.showGrid == true) {
      _paintVerticalGrid(canvas, size, yLabelsWidth, xLabelsHeight);
    }
    if (horizontalGird.showGrid == true) {
      _paintHorizontalGrid(canvas, size, yLabelsWidth, xLabelsHeight);
    }

    for (HBCData d in data) {
      final Paint paint = Paint()
        ..color = d.color ?? Colors.blue
        ..style = PaintingStyle.fill;

      final double barWidth = chartSize.width * d.value / maxValue;
      final double barHeight = (chartSize.height - (data.length + 1) * options.spaceBetweenBars) / data.length;

      final Rect rect = Rect.fromLTWH(
        yLabelsWidth,
        data.indexOf(d) * barHeight + data.indexOf(d) * options.spaceBetweenBars + options.spaceBetweenBars,
        barWidth,
        barHeight,
      );

      final RRect rRect = RRect.fromRectAndCorners(
        rect,
        bottomRight: Radius.circular(options.rightBorderRadius),
        topRight: Radius.circular(options.rightBorderRadius),
      );

      canvas.drawRRect(rRect, paint);

      if (dataOptions.showData) {
        final TextSpan span = TextSpan(
          style: dataOptions.dataTextStyle ?? Theme.of(context).textTheme.bodyMedium,
          text: dataOptions.getDataString != null ? dataOptions.getDataString!(d) : d.value.toString(),
        );

        final TextPainter tp = TextPainter(
          text: dataOptions.getDataTextSpan != null ? dataOptions.getDataTextSpan!(d) : span,
          textDirection: TextDirection.rtl,
          textAlign: TextAlign.end,
        );

        tp.layout();
        double tpDx = rect.right - tp.width - 8 - yLabelsWidth;
        tp.paint(
          canvas,
          Offset(
            tpDx < 0 ? rect.right + 8 : tpDx + yLabelsWidth,
            rect.center.dy - tp.height / 2,
          ),
        );
      }
    }

    if (indicatorOptions.showIndicator) {
      final Paint paint = Paint()
        ..color = indicatorOptions.color
        ..style = PaintingStyle.stroke
        ..strokeWidth = indicatorOptions.strokeWidth;

      if (indicatorOptions.style == HBCIndicatorStyle.dashed) {
        drawDashedLine(
          canvas: canvas,
          p1: Offset((chartSize.width * indicatorOptions.widthPercentage) + yLabelsWidth, 0),
          p2: Offset((chartSize.width * indicatorOptions.widthPercentage) + yLabelsWidth, chartSize.height),
          dashWidth: 5,
          dashSpace: 5,
          paint: paint,
        );
      } else {
        final Path path = Path()
          ..moveTo((chartSize.width * indicatorOptions.widthPercentage) + yLabelsWidth, 0)
          ..lineTo((chartSize.width * indicatorOptions.widthPercentage) + yLabelsWidth, chartSize.height);
        canvas.drawPath(path, paint);
      }
    }
  }

  void drawDashedLine(
      {required Canvas canvas,
      required Offset p1,
      required Offset p2,
      required int dashWidth,
      required int dashSpace,
      required Paint paint}) {
    var dx = p2.dx - p1.dx;
    var dy = p2.dy - p1.dy;
    final magnitude = sqrt(dx * dx + dy * dy);
    dx = dx / magnitude;
    dy = dy / magnitude;
    final steps = magnitude ~/ (dashWidth + dashSpace);

    var startX = p1.dx;
    var startY = p1.dy;

    for (int i = 0; i < steps; i++) {
      final endX = startX + dx * dashWidth;
      final endY = startY + dy * dashWidth;
      canvas.drawLine(Offset(startX, startY), Offset(endX, endY), paint);
      startX += dx * (dashWidth + dashSpace);
      startY += dy * (dashWidth + dashSpace);
    }
  }

  void _paintLeftGrid(Canvas canvas, Size size, double yLabelsWidth, double xLabelsHeight) {
    final Paint paint = Paint()
      ..color = gridColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderGrid.left!.strokeWidth;
    Path path = Path();
    path.moveTo(yLabelsWidth, 0);
    path.lineTo(yLabelsWidth, size.height - xLabelsHeight);
    canvas.drawPath(path, paint);
  }

  void _paintTopGrid(Canvas canvas, Size size, double yLabelsWidth, xLabelsHeight) {
    final Paint paint = Paint()
      ..color = gridColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderGrid.top!.strokeWidth;
    Path path = Path();
    path.moveTo(yLabelsWidth, 0);
    path.lineTo(size.width, 0);
    canvas.drawPath(path, paint);
  }

  void _paintRightGrid(Canvas canvas, Size size, double yLabelsWidth, double xLabelsHeight) {
    final Paint paint = Paint()
      ..color = gridColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderGrid.right!.strokeWidth;
    Path path = Path();
    path.moveTo(size.width, 0);
    path.lineTo(size.width, size.height - xLabelsHeight);
    canvas.drawPath(path, paint);
  }

  void _paintBottomGrid(Canvas canvas, Size size, double yLabelsWidth, double xLabelsHeight) {
    final Paint paint = Paint()
      ..color = gridColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderGrid.bottom!.strokeWidth;
    Path path = Path();
    path.moveTo(yLabelsWidth, size.height - xLabelsHeight);
    path.lineTo(size.width, size.height - xLabelsHeight);
    canvas.drawPath(path, paint);
  }

  void _paintVerticalGrid(Canvas canvas, Size size, double yLabelsWidth, double xLabelsHeight) {
    final Paint paint = Paint()
      ..color = gridColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = verticalGird.strokeWidth;
    Path path = Path();
    double step = verticalGird.step ?? (size.width - yLabelsWidth) / 10;
    for (double i = yLabelsWidth; i < size.width; i += step) {
      path.moveTo(i.toDouble(), 0);
      path.lineTo(i.toDouble(), size.height - xLabelsHeight);
    }
    canvas.drawPath(path, paint);
  }

  void _paintHorizontalGrid(Canvas canvas, Size size, double yLabelsWidth, double xLabelsHeight) {
    final Paint paint = Paint()
      ..color = gridColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = horizontalGird.strokeWidth;
    Path path = Path();
    double step = horizontalGird.step ?? (size.height - xLabelsHeight) / 10;
    for (double i = 0; i < size.height - xLabelsHeight; i += step) {
      path.moveTo(yLabelsWidth, i.toDouble());
      path.lineTo(size.width, i.toDouble());
    }
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return oldDelegate != this;
  }

  double get maxValue {
    if (options.maxValue != null) return options.maxValue!;
    double maxValue = 0;
    for (int i = 0; i < data.length; i++) {
      if (data[i].value > maxValue) {
        maxValue = data[i].value;
      }
    }
    return maxValue;
  }

  double get minValue {
    double minValue = double.infinity;
    for (int i = 0; i < data.length; i++) {
      if (data[i].value < minValue) {
        minValue = data[i].value;
      }
    }
    return minValue;
  }
}
