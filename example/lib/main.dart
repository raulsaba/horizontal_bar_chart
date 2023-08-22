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
  List<HorizontalBarChartData> data = [];

  _generateData() {
    data.clear();

    for (int i = 0; i < 10; i++) {
      data.add(
        HorizontalBarChartData(
          name: "Item $i",
          value: Random().nextDouble() * 100,
          color: exampleColors[i],
        ),
      );
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
      body: HorizontalBarChart(
        data: data,
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
