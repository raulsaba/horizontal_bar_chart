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
part 'options/labels/axis_labels.dart';
part 'options/labels/axis_x_labels.dart';
part 'options/labels/axis_y_labels.dart';
part 'painters/chart_painter.dart';

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
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Center(
          child: SizedBox(
            height: constraints.maxHeight,
            width: constraints.maxWidth,
            child: Stack(
              children: [
                CustomPaint(
                  painter: ChartPainter(
                    data: sortedData,
                    context: context,
                    options: options ?? HBCOptions(),
                  ),
                  child: Container(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
