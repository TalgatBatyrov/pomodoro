import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum TimerState { focus, longBreak, shortBreak }

class TimerStateCubit extends Cubit<TimerState> {
  TimerStateCubit() : super(TimerState.focus);

  void nextPage() {
    switch (state) {
      case TimerState.focus:
        emit(TimerState.longBreak);
        break;
      case TimerState.longBreak:
        emit(TimerState.shortBreak);
        break;
      default:
        emit(TimerState.focus);
    }
  }
}

extension TimerStateEx on TimerState {
  Color? get backgroundColorLight {
    switch (this) {
      case TimerState.focus:
        return Colors.red[50];
      case TimerState.longBreak:
        return Colors.blue[50];
      case TimerState.shortBreak:
        return Colors.green[50];
    }
  }

  Color? get backgroundColorDark {
    switch (this) {
      case TimerState.focus:
        return const Color.fromARGB(255, 13, 4, 4);
      case TimerState.longBreak:
        return const Color.fromARGB(255, 4, 13, 6);
      case TimerState.shortBreak:
        return const Color.fromARGB(255, 4, 9, 13);
    }
  }

  Color? get settingsAndNextPageColorsLight {
    switch (this) {
      case TimerState.focus:
        return const Color.fromRGBO(255, 76, 76, 0.15);
      case TimerState.longBreak:
        return const Color.fromRGBO(76, 172, 255, 0.15);
      case TimerState.shortBreak:
        return const Color.fromRGBO(77, 218, 110, 0.15);
    }
  }
  // Color? get settingsAndNextPageColorsLight {
  //   switch (this) {
  //     case TimerState.focus:
  //       return const Color.fromRGBO(255, 76, 76, 0.15);
  //     case TimerState.longBreak:
  //       return const Color.fromRGBO(76, 172, 255, 0.15);
  //     case TimerState.shortBreak:
  //       return const Color.fromRGBO(77, 218, 110, 0.15);
  //   }
  // }

  String get assetName {
    switch (this) {
      case TimerState.focus:
        return 'images/brain.png';
      case TimerState.longBreak:
        return 'images/long_short_break.png';
      case TimerState.shortBreak:
        return 'images/long_short_break.png';
    }
  }

  String get title {
    switch (this) {
      case TimerState.focus:
        return 'Fosuc';
      case TimerState.longBreak:
        return 'Long break';
      case TimerState.shortBreak:
        return 'Short break';
    }
  }

  Color get timerColorLightTheme {
    switch (this) {
      case TimerState.focus:
        return const Color.fromARGB(255, 47, 15, 15);
      case TimerState.longBreak:
        return const Color.fromARGB(255, 15, 30, 47);
      case TimerState.shortBreak:
        return const Color.fromARGB(255, 14, 41, 15);
    }
  }

  Color get timerColorDarkTheme {
    return Colors.white;
  }

  Color get toggleButtonColor {
    switch (this) {
      case TimerState.focus:
        return const Color.fromRGBO(255, 76, 76, 0.71);
      case TimerState.longBreak:
        return const Color.fromRGBO(76, 172, 255, 0.62);
      case TimerState.shortBreak:
        return const Color.fromRGBO(77, 218, 110, 0.62);
    }
  }
}
