import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pomodoro/cubits/theme_cubit.dart';
import 'package:pomodoro/cubits/timer_state_cubit.dart';

import 'elements/pomodoro_action_buttons/pomodoro_action_buttons.dart';
import 'elements/pomodoro_timer.dart';
import 'elements/pomodoro_title.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final themeCubit = context.watch<ThemeCubit>();
    return BlocBuilder<TimerStateCubit, TimerState>(
      builder: (context, state) {
        return Scaffold(
          body: Container(
            color: themeCubit.isLight
                ? state.backgroundColorLight
                : state.backgroundColorDark,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 70),
                PomodoroTitle(state: state),
                const SizedBox(height: 40),
                PomodoroTimer(state: state),
                const SizedBox(height: 20),
                PomodoroActionButtons(state: state),
              ],
            ),
          ),
        );
      },
    );
  }
}
