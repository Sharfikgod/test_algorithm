import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_work/extensions/nav_context_ext.dart';
import 'package:test_work/pages/home_screen/cubit/home_screen_cubit.dart';
import 'package:test_work/pages/preview_screen.dart';
import 'package:test_work/widgets/scaffold_with_app_bar.dart';

class ResultScreen extends StatelessWidget {
  static const routeName = '/ResultScreen';
  const ResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeScreenCubit, HomeScreenState>(
      builder: (context, state) => ScaffoldWithAppBar(
          title: 'Result List Screen',
          body: ListView.builder(
            itemCount: state.resultList!.length,
            itemBuilder: (BuildContext context, int index) {
              final result = state.resultList![index];
              final id = result['id'];
              final path = result['result']['path'];
              final steps = result['result']['steps'];
              return ListTile(
                title: Text(path),
                onTap: () {
                  context.push(
                    MaterialPageRoute<PreviewScreen>(
                      builder: (_) => BlocProvider<HomeScreenCubit>.value(
                        value: context.read<HomeScreenCubit>(),
                        child: PreviewScreen(
                          id: id.toString(),
                          path: path,
                          steps: steps,
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          )),
    );
  }
}

class ResultView extends StatelessWidget {
  final Map<String, dynamic> result;

  const ResultView(this.result, {super.key});

  @override
  Widget build(BuildContext context) {
    List<List<String>> field = (result['field'] as List).map((row) => (row as String).split('')).toList();
    List<Map<String, String>> steps = List<Map<String, String>>.from(result['result']['steps']);

    return Column(
      children: [
        Text('ID: ${result['id']}'),
        Text('Path: ${result['result']['path']}'),
        GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: field.length * field[0].length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: field[0].length),
          itemBuilder: (context, index) {
            int row = index ~/ field[0].length;
            int col = index % field[0].length;
            String cellValue = field[row][col];
            Color color = Colors.white;

            if (cellValue == '.') {
              color = Colors.white;
            } else if (cellValue == 'X') {
              color = Colors.black;
            } else if (row == int.parse(steps[0]['y']!) && col == int.parse(steps[0]['x']!)) {
              color = Colors.green; // Початкова комірка
            } else if (row == int.parse(steps[steps.length - 1]['y']!) &&
                col == int.parse(steps[steps.length - 1]['x']!)) {
              color = Colors.red; // Кінцева комірка
            } else {
              for (var step in steps) {
                if (row == int.parse(step['y']!) && col == int.parse(step['x']!)) {
                  color = Colors.lightGreenAccent; // Комірка найкоротшого шляху
                  break;
                }
              }
            }

            return Container(
              decoration: BoxDecoration(
                border: Border.all(),
                color: color,
              ),
              child: Center(child: Text('($col, $row)')),
            );
          },
        ),
      ],
    );
  }
}
