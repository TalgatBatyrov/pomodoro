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
