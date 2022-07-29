import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../cubits/theme_cubit.dart';
import '../../../../cubits/timer_play_button_cubit.dart';
import '../../../../cubits/timer_state_cubit.dart';

class Toggle extends StatelessWidget {
  const Toggle({
    Key? key,
    required this.state,
  }) : super(key: key);

  final TimerState state;

  @override
  Widget build(BuildContext context) {
    final timerPlayButtonCubit = context.read<TimerPlayButtonCubit>();
    final themeCubit = context.watch<ThemeCubit>();
    return GestureDetector(
      onTap: timerPlayButtonCubit.toggle,
      child: Container(
        width: 130,
        height: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(32),
          color: state.toggleButtonColor,
        ),
        child: BlocBuilder<TimerPlayButtonCubit, TimerPlayButtonState>(
          builder: (context, playButtonState) {
            if (playButtonState == TimerPlayButtonState.pause) {
              return Icon(
                Icons.play_arrow,
                size: 40,
                color: themeCubit.isLight
                    ? state.timerColorLightTheme
                    : Colors.white,
              );
            }
            return Icon(
              Icons.pause,
              size: 40,
              color: themeCubit.isLight
                  ? state.timerColorLightTheme
                  : Colors.white,
            );
          },
        ),
      ),
    );
  }
}
