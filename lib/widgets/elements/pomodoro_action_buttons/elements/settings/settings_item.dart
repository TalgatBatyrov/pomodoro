import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pomodoro/cubits/timer_state_cubit.dart';

class SettingsItem extends StatelessWidget {
  final String title;
  final Widget setting;
  final double fontSize;
  final FontWeight fontWeight;
  const SettingsItem({
    Key? key,
    required this.title,
    required this.setting,
    this.fontSize = 16,
    this.fontWeight = FontWeight.w500,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final timerStateCubit = context.watch<TimerStateCubit>();
    return ListTile(
      leading: Text(
        title,
        style: TextStyle(
          color: timerStateCubit.state.timerColorLightTheme,
          fontSize: fontSize,
          fontWeight: fontWeight,
        ),
      ),
      trailing: setting,
    );
  }
}
