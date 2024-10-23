import 'dart:math';

import 'package:flutter/material.dart';
import 'package:horizontal_bar_chart/horizontal_bar_chart.dart';

import 'example_colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Horizontal Bar Chart Example',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Horizontal Bar Chart Example'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<HBCData> data = [];

  _generateData() {
    data.clear();

    for (int i = 0; i < 10; i++) {
      if (i == 5) {
        data.add(
          HBCData(
            name: "Item $i",
            value: 0,
            color: exampleColors[i],
          ),
        );
      } else {
        data.add(
          HBCData(
            name: "Item $i",
            value: Random().nextDouble() * 100,
            color: exampleColors[i],
          ),
        );
      }
    }
  }

  @override
  void initState() {
    _generateData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: SizedBox(
          width: 800,
          height: 600,
          child: HorizontalBarChart(
            data: data,
            options: HBCOptions(
              maxValue: 100,
              spaceBetweenBars: 8,
              rightBorderRadius: 16,
              data: HBCDataOptions(
                showData: true,
                getDataString: (data) {
                  return data.value.toStringAsFixed(2);
                },
              ),
              label: HBCLabelOptions(
                axisXLabels: AxisXLabels(show: true),
                axisYLabels: AxisYLabels(show: true),
              ),
              indicator: HBCIndicatorOptions(
                showIndicator: true,
                style: HBCIndicatorStyle.dashed,
                widthPercentage: 0.75,
              ),
              grid: HBCGridOptions(
                verticalGird: VerticalGird(showGrid: true),
                horizontalGird: HorizontalGrid(showGrid: true),
                borderGrid: BorderGrid(
                  left: OutsideGrid(showGrid: true),
                  top: OutsideGrid(showGrid: true),
                  right: OutsideGrid(showGrid: true),
                  bottom: OutsideGrid(showGrid: true),
                ),
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _generateData();
          setState(() {});
        },
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
