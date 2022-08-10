import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
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
    final timerStateCubit = context.watch<TimerStateCubit>();
    final autoResumeTimerCubit = context.watch<AutoResumeTimerCubit>();
    final timerSoundCubit = context.watch<TimerSoundCubit>();
    final notificationCubit = context.watch<NotificationCubit>();
    final focuctimerLengthCubit = context.watch<FocusTimerLengthCubit>();
    final longBreakTimerLengthCubit =
        context.watch<LongBreakTimerLengthCubit>();
    final shortBreakTimerLengthCubit =
        context.watch<ShortBreakTimerLengthCubit>();

    List<int> minutes = [5, 10, 15, 20, 25, 30, 35, 40, 45, 50, 55, 60];

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
                title: tr('settings'),
                fontSize: 24,
                fontWeight: FontWeight.w700,
                setting: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(
                    Icons.exit_to_app,
                    size: 40,
                  ),
                )),
            SettingsItem(
              title: tr('settings_enable_dark_mode'),
              setting: CupertinoSwitch(
                activeColor:
                    !themeCubit.isLight ? state.toggleButtonColor : null,
                value: !themeCubit.isLight,
                onChanged: (_) => themeCubit.toggleTheme(),
              ),
            ),
            SettingsItem(
              title: tr('settings_pomodoro_length'),
              setting: DropdownButton<int>(
                value: focuctimerLengthCubit.state,
                items: minutes.map((minute) {
                  return DropdownMenuItem<int>(
                    value: minute,
                    child: Text('$minute'),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value != null) {
                    focuctimerLengthCubit.focusTimerLengthChanged(value);
                  }
                },
              ),
            ),
            SettingsItem(
              title: tr('settings_language'),
              setting: DropdownButton<Locale>(
                  value: context.locale,
                  isDense: true,
                  icon: const SizedBox.shrink(),
                  underline: const SizedBox.shrink(),
                  onChanged: (locale) {
                    context.setLocale(locale ?? context.locale);
                  },
                  items: const [
                    DropdownMenuItem(
                      value: Locale('en', 'US'),
                      child: Text('EN'),
                    ),
                    DropdownMenuItem(
                      value: Locale('ky', 'KG'),
                      child: Text('KG'),
                    ),
                    DropdownMenuItem(
                      value: Locale('ru', 'RU'),
                      child: Text('RU'),
                    ),
                  ],
                  selectedItemBuilder: (context) {
                    final style = TextStyle(
                      color: themeCubit.isLight
                          ? timerStateCubit.state.timerColorLightTheme
                          : Colors.white,
                    );

                    return [
                      Text('EN', style: style),
                      Text('KG', style: style),
                      Text('RU', style: style),
                    ];
                  }),
            ),
            SettingsItem(
              title: tr('settings_short_break_length'),
              setting: DropdownButton<int>(
                value: shortBreakTimerLengthCubit.state,
                items: minutes.map((minute) {
                  return DropdownMenuItem<int>(
                    value: minute,
                    child: Text('$minute'),
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
              title: tr('settings_long_break_length'),
              setting: DropdownButton<int>(
                value: longBreakTimerLengthCubit.state,
                items: minutes.map((minute) {
                  return DropdownMenuItem<int>(
                    value: minute,
                    child: Text('$minute'),
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
              title: tr('settings_auto_resume_timer'),
              setting: CupertinoSwitch(
                activeColor:
                    autoResumeTimerCubit.state == AutoResumeState.enable
                        ? state.toggleButtonColor
                        : null,
                value: autoResumeTimerCubit.state == AutoResumeState.enable,
                onChanged: (_) => autoResumeTimerCubit.toggleAutoResume(),
              ),
            ),
            SettingsItem(
              title: tr('settings_sound'),
              setting: CupertinoSwitch(
                activeColor: timerSoundCubit.state == TimerSoundState.enable
                    ? state.toggleButtonColor
                    : null,
                value: timerSoundCubit.state == TimerSoundState.enable,
                onChanged: (_) => timerSoundCubit.timerSoundToggle(),
              ),
            ),
            SettingsItem(
              title: tr('settings_notofications'),
              setting: CupertinoSwitch(
                activeColor: notificationCubit.state == NotificationState.enable
                    ? state.toggleButtonColor
                    : null,
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
