import 'package:flutter/material.dart';
import 'package:test_work/widgets/scaffold_with_app_bar.dart';

class PreviewScreen extends StatelessWidget {
  const PreviewScreen({
    required this.id,
    required this.path,
    required this.steps,
    super.key,
  });

  final String id;
  final String path;
  final List steps;

  @override
  Widget build(BuildContext context) {
    Color getCellColor(List steps, int x, int y) {
      for (var step in steps) {
        if (step['x'] == x.toString() && step['y'] == y.toString()) {
          return Colors.green;
        }
      }
      return Colors.white;
    }

    String getCellText(List steps, int x, int y) {
      for (var step in steps) {
        if (step['x'] == x.toString() && step['y'] == y.toString()) {
          return '($x,$y)';
        }
      }
      return '($x,$y)';
    }

    return ScaffoldWithAppBar(
      title: 'Preview Screen',
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GridView.builder(
                        shrinkWrap: true,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          crossAxisSpacing: 4,
                          mainAxisSpacing: 4,
                          childAspectRatio: 1,
                        ),
                        itemCount: 16,
                        itemBuilder: (BuildContext context, int cellIndex) {
                          final x = cellIndex % 4;
                          final y = cellIndex ~/ 4;
                          final color = getCellColor(steps, x, y);
                          final text = getCellText(steps, x, y);
                          return GridTile(
                            child: Container(
                              decoration: BoxDecoration(
                                color: color,
                                border: Border.all(),
                              ),
                              child: Center(
                                child: Text(text),
                              ),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 10),
                      Text(
                        path,
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
