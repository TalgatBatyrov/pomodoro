import 'package:flutter/material.dart';
import 'package:pomodoro/widgets/elements/pomodoro_action_buttons/settings/settings_item.dart';
import '../../../../../cubits/timer_state_cubit.dart';

class SettingsModal extends StatelessWidget {
  const SettingsModal({
    Key? key,
    required this.state,
  }) : super(key: key);

  final TimerState state;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: state.backgroundColor,
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
            const SettingsItem(
                title: 'Settings', setting: Icon(Icons.settings)),
            SettingsItem(
              title: 'Enable dark mode',
              setting: Switch(value: false, onChanged: (value) => print(value)),
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
              setting: Switch(value: false, onChanged: (value) => print(value)),
            ),
            SettingsItem(
              title: 'Sound',
              setting: Switch(value: true, onChanged: (value) => print(value)),
            ),
            SettingsItem(
              title: 'Notifications',
              setting: Switch(value: true, onChanged: (value) => print(value)),
            ),
          ],
        ),
      ),
    );
  }
}
