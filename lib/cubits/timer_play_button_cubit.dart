import 'package:flutter_bloc/flutter_bloc.dart';

enum TimerPlayButtonState { play, pause }

class TimerPlayButtonCubit extends Cubit<TimerPlayButtonState> {
  TimerPlayButtonCubit() : super(TimerPlayButtonState.pause);

  void toggle() {
    if (state == TimerPlayButtonState.pause) {
      emit(TimerPlayButtonState.play);
    } else {
      emit(TimerPlayButtonState.pause);
    }
  }

  // void setPlay() => emit(TimerPlayButtonState.play);
  // void setPause() => emit(TimerPlayButtonState.pause);

  // void toggle2() {
  //   switch (state) {
  //     case TimerPlayButtonState.play:
  //       setPlay();
  //       break;
  //     case TimerPlayButtonState.pause:
  //       setPause();
  //       break;
  //   }
  // }
}
