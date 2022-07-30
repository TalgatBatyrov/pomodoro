import 'package:flutter_bloc/flutter_bloc.dart';

enum TimerSoundState {
  enable,
  disable,
}

class TimerSoundCubit extends Cubit<TimerSoundState> {
  TimerSoundCubit() : super(TimerSoundState.disable);

  void timerSoundToggle() {
    if (state == TimerSoundState.disable) {
      emit(TimerSoundState.enable);
    } else {
      emit(TimerSoundState.disable);
    }
  }
}
