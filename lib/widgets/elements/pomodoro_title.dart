import 'package:flutter/material.dart';

import '../../cubits/timer_state_cubit.dart';

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
