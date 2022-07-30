import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pomodoro/cubits/auto_resume_timer_cubit.dart';
import 'package:pomodoro/cubits/long_break_timer_length_cubit.dart';
import 'package:pomodoro/cubits/notificaton_cubit.dart';
import 'package:pomodoro/cubits/short_break_timer_length_cubit.dart';
import 'package:pomodoro/cubits/theme_cubit.dart';
import 'package:pomodoro/cubits/focus_timer_length_cubit.dart';
import 'package:pomodoro/cubits/timer_sound_cubit.dart';
import 'package:pomodoro/cubits/timer_state_cubit.dart';
import '../cubits/timer_play_button_cubit.dart';
import '../widgets/home_page.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ThemeCubit()),
        BlocProvider(create: (_) => TimerStateCubit()),
        BlocProvider(create: (_) => TimerPlayButtonCubit()),
        BlocProvider(create: (_) => AutoResumeTimerCubit()),
        BlocProvider(create: (_) => TimerSoundCubit()),
        BlocProvider(create: (_) => NotificationCubit()),
        BlocProvider(create: (_) => FocusTimerLengthCubit()),
        BlocProvider(create: (_) => LongBreakTimerLengthCubit()),
        BlocProvider(create: (_) => ShortBreakTimerLengthCubit()),
      ],
      child: BlocBuilder<ThemeCubit, ThemeData>(
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Pomodoro',
            theme: state,
            home: const HomePage(),
          );
        },
      ),
    );
  }
}
