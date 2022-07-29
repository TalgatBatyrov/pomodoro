import 'package:flutter/material.dart';
import 'package:pomodoro/widgets/elements/pomodoro_action_buttons/elements/settings/settings.dart';
import 'package:pomodoro/widgets/elements/pomodoro_action_buttons/toggle.dart';
import '../../../cubits/timer_state_cubit.dart';
import 'next_page.dart';

class PomodoroActionButtons extends StatelessWidget {
  final TimerState state;
  const PomodoroActionButtons({
    Key? key,
    required this.state,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Settings(state: state),
        const SizedBox(width: 10),
        Toggle(state: state),
        const SizedBox(width: 10),
        NextPage(state: state),
      ],
    );
  }
}
