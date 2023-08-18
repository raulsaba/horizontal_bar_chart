import 'dart:math';

import 'package:flutter/material.dart';

import 'example_colors.dart';

class ChartPage extends StatelessWidget {
  const ChartPage({Key? key}) : super(key: key);

  int get itemCount {
    int quantidade = 6;
    return quantidade;
  }

  double get espacamento {
    int espacamento = (292 - (itemCount * 40)) ~/ (1 + itemCount);
    return espacamento.toDouble();
  }

  int get maxValue {
    int maxValue = 20;
    return maxValue;
  }

  int get gridVerticalLineCount => maxValue > 10 ? 10 : maxValue;
  int get indicatorsCount => maxValue > 10 ? 11 : maxValue + 1;

  @override
  Widget build(BuildContext context) {
    final Color corGrid = Theme.of(context).colorScheme.surfaceVariant;
    return LayoutBuilder(builder: (context, c) {
      return SizedBox(
        height: 320,
        width: c.maxWidth,
        child: Stack(
          children: [
            // Positioned(
            //   top: 0,
            //   right: 16,
            //   child: Container(
            //     height: 290,
            //     width: c.maxWidth - 240,
            //     decoration: BoxDecoration(
            //       border: Border.all(
            //         color: corGrid,
            //         width: 0.5,
            //       ),
            //     ),
            //     child: ListView.builder(
            //       scrollDirection: Axis.horizontal,
            //       itemBuilder: (context, index) {
            //         return Container(
            //           height: 290,
            //           width: (c.maxWidth - 240) / gridVerticalLineCount,
            //           decoration: BoxDecoration(
            //             border: Border.all(
            //               color: corGrid,
            //               width: 0.5,
            //             ),
            //           ),
            //         );
            //       },
            //       itemCount: gridVerticalLineCount,
            //     ),
            //   ),
            // ),
            // Positioned(
            //   top: 290,
            //   right: 4,
            //   child: SizedBox(
            //     height: 30,
            //     width: c.maxWidth - (indicatorsCount) * 40,
            //     child: ListView.builder(
            //       scrollDirection: Axis.horizontal,
            //       itemBuilder: (context, index) {
            //         return SizedBox(
            //           width: (c.maxWidth - (indicatorsCount) * 8) /
            //               (indicatorsCount),
            //           child: Column(
            //             mainAxisSize: MainAxisSize.min,
            //             mainAxisAlignment: MainAxisAlignment.start,
            //             crossAxisAlignment: CrossAxisAlignment.center,
            //             children: [
            //               Container(
            //                 height: 8,
            //                 width: 1,
            //                 color: corGrid,
            //               ),
            //               Center(
            //                   child: Text(
            //                       '${maxValue > 10 ? index * (maxValue ~/ 10) : index}')),
            //             ],
            //           ),
            //         );
            //       },
            //       itemCount: indicatorsCount,
            //     ),
            //   ),
            // ),
            Padding(
              padding:
                  EdgeInsets.symmetric(vertical: espacamento, horizontal: 16),
              child: ListView.separated(
                separatorBuilder: (context, index) {
                  return SizedBox(height: espacamento);
                },
                itemBuilder: (context, index) {
                  int value = Random().nextInt(maxValue) + 1;

                  return Row(
                    children: [
                      Tooltip(
                        message:
                            "Quero um texto maior pra ver a alternativa como vai ficar",
                        child: Container(
                          alignment: Alignment.centerRight,
                          width: 180,
                          child: const Text(
                            "Quero um texto maior pra ver a alternativa como vai ficar",
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
                        color: corGrid,
                      ),
                      value != 0
                          ? Expanded(
                              flex: value + 1,
                              child: Tooltip(
                                message: value.toString(),
                                child: LinearProgressIndicator(
                                  color: exampleColors[index % 18],
                                  minHeight: 40,
                                  value: 1,
                                ),
                              ),
                            )
                          : Container(
                              width: 2,
                              height: 40,
                              color: exampleColors[index % 18],
                            ),
                      maxValue - (value + 1) >= 0
                          ? Expanded(
                              flex: maxValue - (value + 1),
                              child: const LinearProgressIndicator(
                                color: Colors.transparent,
                                backgroundColor: Colors.transparent,
                                value: 1,
                                minHeight: 40,
                              ),
                            )
                          : const SizedBox(),
                    ],
                  );
                },
                itemCount: itemCount,
              ),
            ),
          ],
        ),
      );
    });
  }
}
