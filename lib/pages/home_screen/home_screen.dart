import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_work/extensions/nav_context_ext.dart';
import 'package:test_work/pages/home_screen/cubit/home_screen_cubit.dart';
import 'package:test_work/pages/process_screen.dart';
import 'package:test_work/widgets/flushbar.dart';
import 'package:test_work/widgets/main_button.dart';
import 'package:test_work/widgets/scaffold_with_app_bar.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/HomeScreen';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final urlTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeScreenCubit(),
      child: BlocConsumer<HomeScreenCubit, HomeScreenState>(
        listener: (context, state) {
          if (state.status == HomeScreenStatus.error) {
            showPopup(context, text: state.errorMessage!, isPositive: false);
          }
        },
        builder: (context, state) => ScaffoldWithAppBar(
          title: 'Home Screen',
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Set valid API base URL in order to continue'),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Icon(Icons.compare_arrows),
                    const SizedBox(width: 40),
                    Expanded(
                        child: TextFormField(
                      controller: urlTextController,
                    )),
                  ],
                ),
                const Spacer(),
                MainButton(
                  title: 'Start counting process',
                  onPressed: () async {
                    FocusManager.instance.primaryFocus?.unfocus();
                    context.push(
                      MaterialPageRoute<ProcessScreen>(
                        builder: (_) => BlocProvider<HomeScreenCubit>.value(
                          value: context.read<HomeScreenCubit>(),
                          child: const ProcessScreen(),
                        ),
                      ),
                    );

                    context.read<HomeScreenCubit>().getDataFromUrl(url: urlTextController.text);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
