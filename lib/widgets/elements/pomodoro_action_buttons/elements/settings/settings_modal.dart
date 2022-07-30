import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pomodoro/cubits/auto_resume_timer_cubit.dart';
import 'package:pomodoro/cubits/long_break_timer_length_cubit.dart';
import 'package:pomodoro/cubits/notificaton_cubit.dart';
import 'package:pomodoro/cubits/short_break_timer_length_cubit.dart';
import 'package:pomodoro/cubits/theme_cubit.dart';
import 'package:pomodoro/cubits/focus_timer_length_cubit.dart';
import 'package:pomodoro/cubits/timer_sound_cubit.dart';
import 'package:pomodoro/widgets/elements/pomodoro_action_buttons/elements/settings/settings_item.dart';
import '../../../../../cubits/timer_state_cubit.dart';

class SettingsModal extends StatelessWidget {
  const SettingsModal({
    Key? key,
    required this.state,
  }) : super(key: key);

  final TimerState state;

  @override
  Widget build(BuildContext context) {
    final themeCubit = context.watch<ThemeCubit>();
    final autoResumeTimerCubit = context.watch<AutoResumeTimerCubit>();
    final timerSoundCubit = context.watch<TimerSoundCubit>();
    final notificationCubit = context.watch<NotificationCubit>();
    final focuctimerLengthCubit = context.watch<FocusTimerLengthCubit>();
    final longBreakTimerLengthCubit =
        context.watch<LongBreakTimerLengthCubit>();
    final shortBreakTimerLengthCubit =
        context.watch<ShortBreakTimerLengthCubit>();

    List<int> countries = [5, 10, 15, 20, 25, 30, 35, 40, 45, 50, 55, 60];

    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: themeCubit.isLight
            ? state.backgroundColorLight
            : state.backgroundColorDark,
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 2))
        ],
        border: Border.all(color: Colors.black.withOpacity(0.2)),
        borderRadius: const BorderRadius.all(Radius.circular(16)),
      ),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height - 80,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SettingsItem(
                title: 'Settings',
                fontSize: 24,
                fontWeight: FontWeight.w700,
                setting: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.exit_to_app))),
            SettingsItem(
              title: 'Enable dark mode',
              setting: Switch(
                value: !themeCubit.isLight,
                onChanged: (_) => themeCubit.toggleTheme(),
              ),
            ),
            SettingsItem(
              title: 'Pomodoro length',
              setting: DropdownButton<int>(
                value: focuctimerLengthCubit.state,
                items: countries.map((country) {
                  return DropdownMenuItem<int>(
                    value: country,
                    child: Text('$country'),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value != null) {
                    focuctimerLengthCubit.focusTimerLengthChanged(value);
                  }
                },
              ),
            ),
            // SettingsItem(
            //   title: 'Pomodoros until long break length',
            //   setting: DropdownButton<int>(
            //     value: val,
            //     items: countries.map((country) {
            //       return DropdownMenuItem<int>(
            //         value: country,
            //         child: Text('$country'),
            //       );
            //     }).toList(),
            //     onChanged: (value) {
            //       if (value != null) {
            //         val = value;
            //       }
            //     },
            //   ),
            // ),
            SettingsItem(
              title: 'Short break length length',
              setting: DropdownButton<int>(
                value: shortBreakTimerLengthCubit.state,
                items: countries.map((country) {
                  return DropdownMenuItem<int>(
                    value: country,
                    child: Text('$country'),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value != null) {
                    shortBreakTimerLengthCubit
                        .shortBreakTimerLengthChanged(value);
                  }
                },
              ),
            ),
            SettingsItem(
              title: 'Long break length',
              setting: DropdownButton<int>(
                value: longBreakTimerLengthCubit.state,
                items: countries.map((country) {
                  return DropdownMenuItem<int>(
                    value: country,
                    child: Text('$country'),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value != null) {
                    longBreakTimerLengthCubit
                        .longBreakTimerLengthChanged(value);
                  }
                },
              ),
            ),
            SettingsItem(
              title: 'Auto resume timer',
              setting: Switch(
                value: autoResumeTimerCubit.state == AutoResumeState.enable,
                onChanged: (_) => autoResumeTimerCubit.toggleAutoResume(),
              ),
            ),
            SettingsItem(
              title: 'Sound',
              setting: Switch(
                value: timerSoundCubit.state == TimerSoundState.enable,
                onChanged: (_) => timerSoundCubit.timerSoundToggle(),
              ),
            ),
            SettingsItem(
              title: 'Notifications',
              setting: Switch(
                value: notificationCubit.state == NotificationState.enable,
                onChanged: (_) => notificationCubit.toggleNotification(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
