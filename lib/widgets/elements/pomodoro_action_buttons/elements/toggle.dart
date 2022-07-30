import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pomodoro/cubits/timer_sound_cubit.dart';
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
    final timerSoundCubit = context.watch<TimerSoundCubit>();

    Future<void> toggle() async {
      final player = AudioPlayer();
      const alarmAudioPath = "sound.mp3";
      if (timerPlayButtonCubit.state == TimerPlayButtonState.pause) {
        await player.play(AssetSource(alarmAudioPath));
      }
      timerPlayButtonCubit.toggle();
    }

    return GestureDetector(
      onTap: timerSoundCubit.state == TimerSoundState.enable
          ? toggle
          : timerPlayButtonCubit.toggle,
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
