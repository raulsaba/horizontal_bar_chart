part of horizontal_bar_chart;

class BarsPainter extends CustomPainter {
  final List<HBCData> data;
  final HBCOptions options;
  final BuildContext context;

  BarsPainter({
    super.repaint,
    required this.context,
    required this.options,
    required this.data,
  });

  @override
  void paint(Canvas canvas, Size size) {
    for (HBCData d in data) {
      final Paint paint = Paint()
        ..color = d.color ?? Colors.blue
        ..style = PaintingStyle.fill;

      final double barWidth = size.width * d.value / maxValue;
      final double barHeight = (size.height - (data.length + 1) * options.spaceBetweenBars) / data.length;

      final Rect rect = Rect.fromLTWH(
        0,
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

      if (options.data != null) {
        final TextSpan span = TextSpan(
          style: options.data?.dataTextStyle ?? Theme.of(context).textTheme.bodyMedium,
          text: options.data?.getDataString != null ? options.data!.getDataString!(d) : d.value.toString(),
        );

        final TextPainter tp = TextPainter(
          text: options.data?.getDataTextSpan != null ? options.data!.getDataTextSpan!(d) : span,
          textDirection: TextDirection.rtl,
          textAlign: TextAlign.end,
        );

        tp.layout();
        tp.paint(
          canvas,
          Offset(
            rect.right + (d.value != 0.0 ? (-tp.width - 8) : 8),
            rect.center.dy - tp.height / 2,
          ),
        );
      }
    }

    if (options.indicator?.showIndicator == true) {
      final Paint paint = Paint()
        ..color = options.indicator!.color
        ..style = PaintingStyle.stroke
        ..strokeWidth = options.indicator!.strokeWidth;

      if (options.indicator!.style == HBCIndicatorStyle.dashed) {
        drawDashedLine(
          canvas: canvas,
          p1: Offset(size.width * options.indicator!.widthPercentage, 0),
          p2: Offset(size.width * options.indicator!.widthPercentage, size.height),
          dashWidth: 5,
          dashSpace: 5,
          paint: paint,
        );
      } else {
        final Path path = Path()
          ..moveTo(size.width * options.indicator!.widthPercentage, 0)
          ..lineTo(size.width * options.indicator!.widthPercentage, size.height);
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
