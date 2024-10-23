part of horizontal_bar_chart;

class _GridPainter extends CustomPainter {
  final Color color;

  final VerticalGird verticalGird;
  final HorizontalGrid horizontalGird;
  final BorderGrid borderGrid;

  _GridPainter({
    required this.color,
    required this.verticalGird,
    required this.horizontalGird,
    required this.borderGrid,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (borderGrid.left?.showGrid == true) {
      _paintLeftGrid(canvas, size);
    }
    if (borderGrid.top?.showGrid == true) {
      _paintTopGrid(canvas, size);
    }
    if (borderGrid.right?.showGrid == true) {
      _paintRightGrid(canvas, size);
    }
    if (borderGrid.bottom?.showGrid == true) {
      _paintBottomGrid(canvas, size);
    }
    if (verticalGird.showGrid == true) {
      _paintVerticalGrid(canvas, size);
    }
    if (horizontalGird.showGrid == true) {
      _paintHorizontalGrid(canvas, size);
    }
  }

  void _paintLeftGrid(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderGrid.left!.strokeWidth;
    Path path = Path();
    path.moveTo(0, 0);
    path.lineTo(0, size.height);
    canvas.drawPath(path, paint);
  }

  void _paintTopGrid(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderGrid.top!.strokeWidth;
    Path path = Path();
    path.moveTo(0, 0);
    path.lineTo(size.width, 0);
    canvas.drawPath(path, paint);
  }

  void _paintRightGrid(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderGrid.right!.strokeWidth;
    Path path = Path();
    path.moveTo(size.width, 0);
    path.lineTo(size.width, size.height);
    canvas.drawPath(path, paint);
  }

  void _paintBottomGrid(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderGrid.bottom!.strokeWidth;
    Path path = Path();
    path.moveTo(0, size.height);
    path.lineTo(size.width, size.height);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return oldDelegate != this;
  }

  void _paintVerticalGrid(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = verticalGird.strokeWidth;
    Path path = Path();
    double step = verticalGird.step ?? size.width / 10;
    for (double i = 0; i < size.width; i += step) {
      path.moveTo(i.toDouble(), 0);
      path.lineTo(i.toDouble(), size.height);
    }
    canvas.drawPath(path, paint);
  }

  void _paintHorizontalGrid(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = horizontalGird.strokeWidth;
    Path path = Path();
    double step = horizontalGird.step ?? size.height / 10;
    for (double i = 0; i < size.height; i += step) {
      path.moveTo(0, i.toDouble());
      path.lineTo(size.width, i.toDouble());
    }
    canvas.drawPath(path, paint);
  }
}
