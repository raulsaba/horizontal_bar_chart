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
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return oldDelegate != this;
  }

  double get maxValue {
    double maxValue = 0;
    for (int i = 0; i < data.length; i++) {
      if (data[i].value > maxValue) {
        maxValue = data[i].value;
      }
    }
    return maxValue;
  }
}
