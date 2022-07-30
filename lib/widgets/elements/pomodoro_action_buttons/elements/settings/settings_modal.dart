import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pomodoro/cubits/auto_resume_timer_cubit.dart';
import 'package:pomodoro/cubits/notificaton_cubit.dart';
import 'package:pomodoro/cubits/theme_cubit.dart';
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
                // splashRadius: 0,
                // activeColor: Colors.blueGrey,
                // thumbColor: MaterialStateProperty.resolveWith<Color>((states) {
                //   return const Color.fromARGB(255, 58, 119, 88);
                // }),
                value: !themeCubit.isLight,
                onChanged: (_) => themeCubit.toggleTheme(),
              ),
            ),
            SettingsItem(
              title: 'Pomodoro length',
              setting: Switch(value: false, onChanged: (value) => print(value)),
            ),
            SettingsItem(
              title: 'Pomodoros until long break length',
              setting: Switch(value: false, onChanged: (value) => print(value)),
            ),
            SettingsItem(
              title: 'Short break length length',
              setting: Switch(value: false, onChanged: (value) => print(value)),
            ),
            SettingsItem(
              title: 'Long break length',
              setting: Switch(value: false, onChanged: (value) => print(value)),
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
