import 'package:flutter_bloc/flutter_bloc.dart';

enum TimerPlayButtonState { play, pause }

class TimerPlayButtonCubit extends Cubit<TimerPlayButtonState> {
  TimerPlayButtonCubit() : super(TimerPlayButtonState.pause);

  void setPlay() => emit(TimerPlayButtonState.play);
  void setPause() => emit(TimerPlayButtonState.pause);

  void toggle() {
    switch (state) {
      case TimerPlayButtonState.play:
        setPause();
        break;
      case TimerPlayButtonState.pause:
        setPlay();
        break;
    }
  }
}
