import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../cubits/theme_cubit.dart';
import '../../../../cubits/timer_state_cubit.dart';

class NextPage extends StatelessWidget {
  const NextPage({
    Key? key,
    required this.state,
  }) : super(key: key);

  final TimerState state;

  @override
  Widget build(BuildContext context) {
    final nextPage = context.read<TimerStateCubit>().nextPage;
    final themeCubit = context.watch<ThemeCubit>();
    return GestureDetector(
      onTap: nextPage,
      child: Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: state.settingsAndNextPageColorsLight,
        ),
        child: Icon(
          Icons.skip_next,
          size: 40,
          color: themeCubit.isLight ? state.timerColorLightTheme : Colors.white,
        ),
      ),
    );
  }
}
