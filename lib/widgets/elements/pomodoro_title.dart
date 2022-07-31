import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubits/theme_cubit.dart';
import '../../cubits/timer_state_cubit.dart';

class PomodoroTitle extends StatelessWidget {
  final TimerState state;
  const PomodoroTitle({
    Key? key,
    required this.state,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.locale;
    final themeCubit = context.watch<ThemeCubit>();
    return Container(
      width: 270,
      height: 60,
      decoration: BoxDecoration(
          border: Border.fromBorderSide(
            BorderSide(
              width: 2,
              color: themeCubit.isLight ? Colors.black : Colors.white,
            ),
          ),
          color: state.settingsAndNextPageColorsLight,
          borderRadius: BorderRadius.circular(26)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image(
            image: AssetImage(state.assetName),
            color:
                themeCubit.isLight ? state.timerColorLightTheme : Colors.white,
          ),
          Text(
            state.title,
            style: TextStyle(
              color: themeCubit.isLight
                  ? state.timerColorLightTheme
                  : Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.w500,
            ),
          )
        ],
      ),
    );
  }
}
