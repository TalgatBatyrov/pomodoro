import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pomodoro/widgets/elements/pomodoro_action_buttons/elements/settings/settings_modal.dart';
import '../../../../../cubits/theme_cubit.dart';
import '../../../../../cubits/timer_state_cubit.dart';

class Settings extends StatelessWidget {
  const Settings({
    Key? key,
    required this.state,
  }) : super(key: key);

  final TimerState state;

  @override
  Widget build(BuildContext context) {
    final themeCubit = context.watch<ThemeCubit>();
    return GestureDetector(
      onTap: () {
        showCupertinoDialog(
          context: context,
          builder: (context) => Material(
            color: Colors.transparent,
            child: CupertinoDialogAction(
              child: SettingsModal(state: state),
            ),
          ),
        );
      },
      child: Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: state.settingsAndNextPageColorsLight,
        ),
        child: Icon(
          Icons.settings,
          size: 40,
          color: themeCubit.isLight ? state.timerColorLightTheme : Colors.white,
        ),
      ),
    );
  }
}
