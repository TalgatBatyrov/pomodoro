import 'package:flutter_bloc/flutter_bloc.dart';

enum AutoResumeState {
  enable,
  disable,
}

class AutoResumeTimerCubit extends Cubit<AutoResumeState> {
  AutoResumeTimerCubit() : super(AutoResumeState.disable);

  void toggleAutoResume() {
    if (state == AutoResumeState.disable) {
      emit(AutoResumeState.enable);
    } else {
      emit(AutoResumeState.disable);
    }
  }
}
