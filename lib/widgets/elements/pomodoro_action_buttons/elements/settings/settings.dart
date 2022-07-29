import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pomodoro/widgets/elements/pomodoro_action_buttons/elements/settings/settings_modal.dart';
import '../../../../../cubits/timer_state_cubit.dart';

class Settings extends StatelessWidget {
  const Settings({
    Key? key,
    required this.state,
  }) : super(key: key);

  final TimerState state;

  @override
  Widget build(BuildContext context) {
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
          color: state.colors,
        ),
        child: const Icon(
          Icons.settings,
          size: 40,
          color: Color.fromARGB(255, 47, 15, 15),
        ),
      ),
    );
  }
}
