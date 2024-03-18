import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:test_work/extensions/nav_context_ext.dart';
import 'package:test_work/pages/home_screen/cubit/home_screen_cubit.dart';
import 'package:test_work/pages/result_screen.dart';
import 'package:test_work/widgets/main_button.dart';
import 'package:test_work/widgets/scaffold_with_app_bar.dart';

class ProcessScreen extends StatefulWidget {
  static const routeName = '/ProcessScreen';
  const ProcessScreen({super.key});

  @override
  State<ProcessScreen> createState() => _ProcessScreenState();
}

class _ProcessScreenState extends State<ProcessScreen> {
  @override
  Widget build(BuildContext context) {
    return ScaffoldWithAppBar(
      title: 'Process Screen',
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: BlocBuilder<HomeScreenCubit, HomeScreenState>(
          builder: (context, state) {
            bool _buttonEnabled = state.listOfShortestPath != null;
            return Column(
              children: [
                const Spacer(),
                const Text('All calculations has finished, you can send your results to server'),
                Text(state.loadingProgress != null ? "${state.loadingProgress!.toStringAsFixed(0)} %" : '0%'),
                CircularPercentIndicator(
                  radius: 60.0,
                  lineWidth: 5.0,
                  percent: state.loadingProgress != null ? state.loadingProgress! / 100 : 0,
                  progressColor: Colors.green,
                ),
                const Spacer(),
                if (state.listOfShortestPath != null)
                  MainButton(
                    title: 'Send results to server',
                    onPressed: _buttonEnabled
                        ? () async {
                            setState(() {
                              _buttonEnabled = false;
                            });
                            if (state.resultList == null) {
                              await context.read<HomeScreenCubit>().checkShortestPathsCalculations();
                            }
                            setState(() {
                              _buttonEnabled = state.resultList != null;
                            });
                            context.push(
                              MaterialPageRoute<ResultScreen>(
                                builder: (_) => BlocProvider<HomeScreenCubit>.value(
                                  value: context.read<HomeScreenCubit>(),
                                  child: const ResultScreen(),
                                ),
                              ),
                            );
                          }
                        : null,
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}
