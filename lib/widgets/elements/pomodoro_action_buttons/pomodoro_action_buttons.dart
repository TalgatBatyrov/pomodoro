import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../cubits/timer_play_button_cubit.dart';
import '../../../cubits/timer_state_cubit.dart';
import 'elements/settings_item.dart';

class PomodoroActionButtons extends StatelessWidget {
  final TimerState state;
  const PomodoroActionButtons({
    Key? key,
    required this.state,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final timerPlayButtonCubit = context.read<TimerPlayButtonCubit>();
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            showCupertinoDialog(
              context: context,
              builder: (context) => Material(
                color: Colors.transparent,
                child: CupertinoDialogAction(
                  child: Container(
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
                            setting: Switch(
                                value: false,
                                onChanged: (value) => print(value)),
                          ),
                          SettingsItem(
                            title: 'Pomodoro length',
                            setting: Switch(
                                value: false,
                                onChanged: (value) => print(value)),
                          ),
                          SettingsItem(
                            title: 'Pomodoros until long break length',
                            setting: Switch(
                                value: false,
                                onChanged: (value) => print(value)),
                          ),
                          SettingsItem(
                            title: 'Short break length length',
                            setting: Switch(
                                value: false,
                                onChanged: (value) => print(value)),
                          ),
                          SettingsItem(
                            title: 'Long break length',
                            setting: Switch(
                                value: false,
                                onChanged: (value) => print(value)),
                          ),
                          SettingsItem(
                            title: 'Auto resume timer',
                            setting: Switch(
                                value: false,
                                onChanged: (value) => print(value)),
                          ),
                          SettingsItem(
                            title: 'Sound',
                            setting: Switch(
                                value: true,
                                onChanged: (value) => print(value)),
                          ),
                          SettingsItem(
                            title: 'Notifications',
                            setting: Switch(
                                value: true,
                                onChanged: (value) => print(value)),
                          ),
                        ],
                      ),
                    ),
                  ),
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
        ),
        const SizedBox(width: 10),
        GestureDetector(
          onTap: timerPlayButtonCubit.toggle,
          child: Container(
            width: 130,
            height: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(32),
              color: state.toggleButtonColor,
            ),
            child: BlocBuilder<TimerPlayButtonCubit, TimerPlayButtonState>(
              builder: (context, state) {
                if (state == TimerPlayButtonState.pause) {
                  return const Icon(
                    Icons.play_arrow,
                    size: 40,
                    color: Color.fromARGB(255, 47, 15, 15),
                  );
                }
                return const Icon(
                  Icons.pause,
                  size: 40,
                  color: Color.fromARGB(255, 47, 15, 15),
                );
              },
            ),
          ),
        ),
        const SizedBox(width: 10),
        GestureDetector(
          onTap: context.read<TimerStateCubit>().nextPage,
          child: Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: state.colors,
            ),
            child: const Icon(
              Icons.skip_next,
              size: 40,
              color: Color.fromARGB(255, 47, 15, 15),
            ),
          ),
        ),
      ],
    );
  }
}
