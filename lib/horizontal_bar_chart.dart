library horizontal_bar_chart;

import 'package:flutter/material.dart';

part 'horizontal_bar_chart_data.dart';

class HorizontalBarChart extends StatelessWidget {
  const HorizontalBarChart({
    Key? key,
    required this.data,
    this.barsColors,
    this.barPadding,
  }) : super(key: key);

  final List<HorizontalBarChartData> data;
  final Color? barsColors;
  final EdgeInsets? barPadding;

  int get itemCount {
    int quantidade = 6;
    return quantidade;
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

  @override
  Widget build(BuildContext context) {
    final Color gridColor = Colors.black;
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        print(constraints.maxWidth);
        print(constraints.maxHeight);
        return SizedBox(
          height: constraints.maxHeight,
          width: constraints.maxWidth,
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    double value = data[index].value;
                    Color? color = data[index].color;
                    String name = data[index].name;

                    return Padding(
                      padding: barPadding ?? const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        children: [
                          Tooltip(
                            message: name,
                            child: Container(
                              alignment: Alignment.centerRight,
                              width: 180,
                              child: Text(
                                name,
                                textAlign: TextAlign.right,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            width: 20,
                            height: 1,
                            color: gridColor,
                          ),
                          value != 0
                              ? Expanded(
                                  flex: value.ceil() + 1,
                                  child: Tooltip(
                                    message: value.toString(),
                                    child: LinearProgressIndicator(
                                      color: color ?? barsColors ?? Theme.of(context).colorScheme.primary,
                                      minHeight: 40,
                                      value: 1,
                                    ),
                                  ),
                                )
                              : Container(
                                  width: 2,
                                  height: 40,
                                  color: color ?? barsColors ?? Theme.of(context).colorScheme.primary,
                                ),
                          (maxValue - (value + 1)).ceil() >= 0
                              ? Expanded(
                                  flex: (maxValue - (value + 1)).ceil(),
                                  child: const LinearProgressIndicator(
                                    color: Colors.transparent,
                                    backgroundColor: Colors.transparent,
                                    value: 1,
                                    minHeight: 40,
                                  ),
                                )
                              : const SizedBox(),
                        ],
                      ),
                    );
                  },
                  itemCount: data.length,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
