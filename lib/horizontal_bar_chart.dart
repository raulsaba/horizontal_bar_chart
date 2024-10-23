library horizontal_bar_chart;

import 'dart:math';

import 'package:flutter/material.dart';

part 'data/horizontal_bar_chart_data.dart';
part 'enum/horizontal_chart_bars_indicator_style.dart';
part 'enum/horizontal_chart_bars_sort.dart';
part 'options/grid/border_grid.dart';
part 'options/grid/grid.dart';
part 'options/grid/horizontal_grid.dart';
part 'options/grid/outside_grid.dart';
part 'options/grid/vertical_grid.dart';
part 'options/horizontal_bars_chart_data_options.dart';
part 'options/horizontal_bars_chart_grid_options.dart';
part 'options/horizontal_bars_chart_indicator_options.dart';
part 'options/horizontal_bars_chart_label_options.dart';
part 'options/horizontal_bars_chart_options.dart';
part 'painters/bars_painter.dart';
part 'painters/grid_painter.dart';

class HorizontalBarChart extends StatelessWidget {
  const HorizontalBarChart({
    Key? key,
    required this.data,
    this.options,
  }) : super(key: key);

  final List<HBCData> data;
  final HBCOptions? options;

  List<HBCData> get sortedData {
    switch (options?.sort) {
      case HorizontalChartBarsSort.none:
        return data;
      case HorizontalChartBarsSort.ascending:
        return List<HBCData>.from(data)..sort((a, b) => a.value.compareTo(b.value));
      case HorizontalChartBarsSort.descending:
        return List<HBCData>.from(data)..sort((a, b) => b.value.compareTo(a.value));
      default:
        return data;
    }
  }

  @override
  Widget build(BuildContext context) {
    const Color gridColor = Colors.grey;
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Center(
          child: SizedBox(
            height: constraints.maxHeight,
            width: constraints.maxWidth,
            child: Stack(
              children: [
                CustomPaint(
                  painter: _GridPainter(
                    color: gridColor,
                    verticalGird: options?.grid?.verticalGird ??
                        VerticalGird(
                          showGrid: false,
                          strokeWidth: 1,
                        ),
                    horizontalGird: options?.grid?.horizontalGird ??
                        HorizontalGrid(
                          showGrid: false,
                          strokeWidth: 1,
                        ),
                    borderGrid: options?.grid?.borderGrid ??
                        BorderGrid(
                          left: OutsideGrid(showGrid: false, strokeWidth: 1),
                          top: OutsideGrid(showGrid: false, strokeWidth: 1),
                          right: OutsideGrid(showGrid: false, strokeWidth: 1),
                          bottom: OutsideGrid(showGrid: false, strokeWidth: 1),
                        ),
                  ),
                  child: CustomPaint(
                    painter: BarsPainter(
                      data: sortedData,
                      context: context,
                      options: options ?? HBCOptions(),
                    ),
                    child: Container(),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
