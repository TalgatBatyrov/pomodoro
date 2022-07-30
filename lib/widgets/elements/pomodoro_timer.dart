import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pomodoro/cubits/auto_resume_timer_cubit.dart';
import 'package:pomodoro/cubits/notificaton_cubit.dart';

import '../../cubits/theme_cubit.dart';
import '../../cubits/timer_cubit.dart';
import '../../cubits/timer_play_button_cubit.dart';
import '../../cubits/timer_state_cubit.dart';

class PomodoroTimer extends StatefulWidget {
  final TimerState state;
  const PomodoroTimer({
    Key? key,
    required this.state,
  }) : super(key: key);

  @override
  State<PomodoroTimer> createState() => _PomodoroTimerState();
}

class _PomodoroTimerState extends State<PomodoroTimer> {
  late final _timerCubit = TimerCubit(
    context.read<TimerStateCubit>(),
    context.read<TimerPlayButtonCubit>(),
    context.read<AutoResumeTimerCubit>(),
    context.read<NotificationCubit>(),
  );

  @override
  void dispose() {
    _timerCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final timerPlayButtonCubit = context.watch<TimerPlayButtonCubit>();
    final themeCubit = context.watch<ThemeCubit>();
    var format = NumberFormat("00");

    final style = TextStyle(
      height: .9,
      fontSize: 220,
      color:
          themeCubit.isLight ? widget.state.timerColorLightTheme : Colors.white,
      fontWeight: timerPlayButtonCubit.state == TimerPlayButtonState.play
          ? FontWeight.w900
          : FontWeight.normal,
    );

    return BlocBuilder<TimerCubit, Duration>(
      bloc: _timerCubit,
      builder: (context, state) {
        // if (state <= const Duration(seconds: 0)) {
        //   return const CircularProgressIndicator();
        // }
        return Column(
          children: [
            AnimatedDefaultTextStyle(
              style: style,
              duration: const Duration(milliseconds: 200),
              child: Text(format.format(state.inSeconds ~/ 60)),
            ),
            AnimatedDefaultTextStyle(
              style: style,
              duration: const Duration(milliseconds: 200),
              child: Text(format.format(state.inSeconds % 60)),
            ),
          ],
        );
      },
    );
  }
}
