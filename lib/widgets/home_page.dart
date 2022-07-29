import 'package:flutter/material.dart';
import 'package:pomodoro/cubits/timer_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pomodoro/cubits/timer_play_button_cubit.dart';
import 'package:pomodoro/cubits/timer_state_cubit.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimerStateCubit, TimerState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Pomodoro'),
          ),
          body: Container(
            color: state.backgroundColor,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 70),
                PomodoroTitle(state: state),
                const SizedBox(height: 40),
                PomodoroTimer(state: state),
                const SizedBox(height: 20),
                PomodoroActionButtons(state: state),
              ],
            ),
          ),
        );
      },
    );
  }
}

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
        Container(
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

class PomodoroTimer extends StatefulWidget {
  final TimerState state;
  const PomodoroTimer({
    Key? key,
    required this.state,
  }) : super(key: key);

  @override
  State<PomodoroTimer> createState() => _PomodoroTimerState();
}

class _PomodoroTimerState extends State<PomodoroTimer> {
  late final _timerCubit = TimerCubit(
    context.read<TimerStateCubit>(),
    context.read<TimerPlayButtonCubit>(),
  );

  @override
  void dispose() {
    _timerCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final timerPlayButtonCubit = context.read<TimerPlayButtonCubit>();

    final style = TextStyle(
      height: .9,
      fontSize: 220,
      color: widget.state.timerColor,
      fontWeight: TimerPlayButtonState.play == true
          ? FontWeight.w900
          : FontWeight.normal,
    );

    return BlocBuilder<TimerCubit, Duration>(
      bloc: _timerCubit,
      builder: (context, state) {
        return Column(
          children: [
            AnimatedDefaultTextStyle(
              style: style,
              duration: const Duration(milliseconds: 300),
              child: Text('${state.inSeconds ~/ 60}'),
            ),
            AnimatedDefaultTextStyle(
              style: style,
              duration: const Duration(milliseconds: 300),
              child: Text('${state.inSeconds % 60}'),
            ),
          ],
        );
      },
    );
  }
}

class PomodoroTitle extends StatelessWidget {
  final TimerState state;
  const PomodoroTitle({
    Key? key,
    required this.state,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      height: 60,
      decoration: BoxDecoration(
          border: const Border.fromBorderSide(BorderSide(width: 2)),
          color: state.colors,
          borderRadius: BorderRadius.circular(26)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image(image: AssetImage(state.assetName)),
          Text(
            state.title,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 24,
              fontWeight: FontWeight.w500,
            ),
          )
        ],
      ),
    );
  }
}
