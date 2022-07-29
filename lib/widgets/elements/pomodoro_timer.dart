import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
  );

  @override
  void dispose() {
    _timerCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final timerPlayButtonCubit = context.watch<TimerPlayButtonCubit>();

    final style = TextStyle(
      height: .9,
      fontSize: 220,
      color: widget.state.timerColor,
      fontWeight: timerPlayButtonCubit.state == TimerPlayButtonState.play
          ? FontWeight.w900
          : FontWeight.normal,
    );

    return BlocBuilder<TimerCubit, Duration>(
      bloc: _timerCubit,
      builder: (context, state) {
        return Column(
          children: [
            AnimatedDefaultTextStyle(
              style: style,
              duration: const Duration(milliseconds: 200),
              child: Text('${state.inSeconds ~/ 60}'),
            ),
            AnimatedDefaultTextStyle(
              style: style,
              duration: const Duration(milliseconds: 200),
              child: Text('${state.inSeconds % 60}'),
            ),
          ],
        );
      },
    );
  }
}
